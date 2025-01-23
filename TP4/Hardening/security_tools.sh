#!/bin/bash

# Définition des couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Fonction pour afficher les messages
log() {
    echo -e "${GREEN}[+]${NC} $1"
}

error() {
    echo -e "${RED}[!]${NC} $1"
}

log "Installation et configuration des outils de sécurité..."

# Installation de fail2ban
configure_fail2ban() {
    log "Configuration de fail2ban..."
    
    # Installation de EPEL
    log "Installation du dépôt EPEL..."
    dnf install -y epel-release || return 1
    
    # Installation de fail2ban
    log "Installation de fail2ban..."
    dnf install -y fail2ban || return 1
    
    # Configuration principale
    cat > /etc/fail2ban/jail.local << EOF || return 1
[DEFAULT]
# Ban IP pour 1 heure (3600 secondes)
bantime = 3600
# Temps de recherche des tentatives (10 minutes)
findtime = 600
# 5 tentatives avant bannissement
maxretry = 5
# Ignorer les IP locales
ignoreip = 127.0.0.1/8 ::1

# Configuration pour SSH
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/secure
maxretry = 3

# Configuration pour NGINX
[nginx-http-auth]
enabled = true
filter = nginx-http-auth
port = http,https
logpath = /var/log/nginx/error.log

[nginx-botsearch]
enabled = true
filter = nginx-botsearch
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 2

[nginx-badbots]
enabled = true
filter = nginx-badbots
port = http,https
logpath = /var/log/nginx/access.log
maxretry = 2
EOF

    # Démarrage du service
    systemctl enable fail2ban || return 1
    systemctl restart fail2ban || return 1

    # Création du répertoire de logs pour fail2ban
    mkdir -p /var/log/fail2ban || return 1
    chmod 750 /var/log/fail2ban || return 1
    chown root:root /var/log/fail2ban || return 1
}

# Installation et configuration de AIDE
configure_aide() {
    log "Configuration de AIDE..."
    
    # Installation
    dnf install -y aide || return 1
    
    # Configuration de base
    cat > /etc/aide.conf.local << EOF || return 1
# Règles de base
/etc NORMAL
/bin NORMAL
/sbin NORMAL
/usr NORMAL
/var/log LOGS
/boot NORMAL
/root NORMAL

# Fichiers de configuration spécifiques
/etc/ssh/sshd_config CONTENT_EX
/etc/nginx/nginx.conf CONTENT_EX
/etc/fail2ban CONTENT_EX

# Exclusions
!/var/log/aide.log
!/var/lib/aide/aide.db.new
EOF

    # Initialisation de la base de données AIDE
    aide --init || return 1
    mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz || return 1

    # Création d'un service systemd pour les vérifications quotidiennes
    cat > /etc/systemd/system/aide-check.service << EOF || return 1
[Unit]
Description=AIDE Check Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/sbin/aide --check
EOF

    cat > /etc/systemd/system/aide-check.timer << EOF || return 1
[Unit]
Description=Daily AIDE check

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

    systemctl enable aide-check.timer || return 1
    systemctl start aide-check.timer || return 1

    # Création du répertoire pour la base de données AIDE
    mkdir -p /var/lib/aide || return 1
    chmod 700 /var/lib/aide || return 1
}

# Exécution des fonctions
configure_fail2ban || exit 1
configure_aide || exit 1

log "Configuration des outils de sécurité terminée" 