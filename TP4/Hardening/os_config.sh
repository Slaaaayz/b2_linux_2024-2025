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

log "Configuration du système d'exploitation..."

# Configuration des paramètres kernel via sysctl
configure_kernel() {
    log "Configuration des paramètres kernel..."
    
    cat > /etc/sysctl.d/99-security.conf << EOF
# Désactive le forwarding IPv4
net.ipv4.ip_forward = 0

# Protection contre les attaques de type SYN flood
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 2048
net.ipv4.tcp_synack_retries = 2

# Désactive les pings (pour éviter le ping flood)
net.ipv4.icmp_echo_ignore_all = 1

# Protection contre les attaques de type MITM
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0

# Désactive le source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0

# Active la protection contre les attaques de type spoofing
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
EOF

    sysctl -p /etc/sysctl.d/99-security.conf || return 1
}

# Configuration NTP
configure_ntp() {
    log "Configuration NTP..."
    
    # Installation de chrony
    dnf install -y chrony || return 1
    
    # Configuration de chrony avec des serveurs NTP français
    cat > /etc/chrony.conf << EOF
server fr.pool.ntp.org iburst
server 0.fr.pool.ntp.org iburst
server 1.fr.pool.ntp.org iburst
server 2.fr.pool.ntp.org iburst

# Enregistrement des statistiques
driftfile /var/lib/chrony/drift
logdir /var/log/chrony
log measurements statistics tracking

# Synchronisation rapide au démarrage
makestep 1.0 3
EOF

    # Activation et démarrage du service
    systemctl enable --now chronyd || return 1
}

# Configuration de la politique de mots de passe
configure_password_policy() {
    log "Configuration de la politique de mots de passe..."
    
    # Installation de libpam-pwquality
    dnf install -y libpwquality || return 1
    
    # Configuration de la politique de mots de passe
    cat > /etc/security/pwquality.conf << EOF
minlen = 12
minclass = 4
maxrepeat = 3
gecoscheck = 1
dictcheck = 1
EOF

    # Configuration de PAM
    sed -i 's/password\s*requisite\s*pam_pwquality.so.*/password    requisite     pam_pwquality.so retry=3/' /etc/pam.d/system-auth || return 1
}

# Désactivation des services non essentiels
disable_services() {
    log "Désactivation des services non essentiels..."
    
    SERVICES_TO_DISABLE=(
        "avahi-daemon"
        "cups"
        "rpcbind"
    )
    
    for service in "${SERVICES_TO_DISABLE[@]}"; do
        if systemctl is-active --quiet "$service"; then
            systemctl stop "$service" || return 1
            systemctl disable "$service" || return 1
            log "Service $service désactivé"
        fi
    done
}

# Configuration de sudo
configure_sudo() {
    log "Configuration de sudo..."
    
    cat > /etc/sudoers.d/custom << EOF
Defaults        use_pty
Defaults        logfile="/var/log/sudo.log"
Defaults        log_input,log_output
Defaults        requiretty
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
EOF

    chmod 440 /etc/sudoers.d/custom || return 1
}

# Exécution des fonctions
configure_kernel || exit 1
configure_ntp || exit 1
configure_password_policy || exit 1
disable_services || exit 1
configure_sudo || exit 1

log "Configuration du système d'exploitation terminée" 