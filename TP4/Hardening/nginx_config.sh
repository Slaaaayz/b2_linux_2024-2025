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

log "Configuration de NGINX..."

# Installation de NGINX si nécessaire
if ! command -v nginx &> /dev/null; then
    log "Installation de NGINX..."
    dnf install -y nginx || exit 1
fi

# Sauvegarde des configurations originales
if [ ! -f /etc/nginx/nginx.conf.orig ]; then
    cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig || exit 1
fi

# Configuration du site par défaut
configure_default_site() {
    log "Configuration du site par défaut..."
    
    cat > /etc/nginx/conf.d/default.conf << EOF || return 1
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    
    # Redirection vers HTTPS
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl http2 default_server;
    listen [::]:443 ssl http2 default_server;
    server_name _;

    # Certificats SSL
    ssl_certificate /etc/nginx/ssl/server.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;

    # Root directory
    root /var/www/app_nulle/;
    index index.html;

    # Sécurité supplémentaire
    location ~ /\. {
        deny all;
    }

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        log_not_found off;
        access_log off;
    }

    # Configuration des logs
    access_log /var/log/nginx/app_access.log main;
    error_log /var/log/nginx/app_error.log warn;

    # Protection contre les injections PHP
    location ~ \.php$ {
        return 404;
    }
}
EOF
}

# Configuration du pare-feu
configure_firewall() {
    log "Configuration du pare-feu pour NGINX..."
    
    firewall-cmd --permanent --add-service=http || return 1
    firewall-cmd --permanent --add-service=https || return 1
    firewall-cmd --reload || return 1
}

# Configuration des certificats SSL
configure_ssl() {
    log "Configuration des certificats SSL..."
    
    # Création du répertoire pour les certificats
    mkdir -p /etc/nginx/ssl || return 1
    chmod 700 /etc/nginx/ssl || return 1
    
    # Génération des certificats auto-signés de manière interactive
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/server.key \
        -out /etc/nginx/ssl/server.crt || return 1
    
    # Permissions des certificats
    chmod 600 /etc/nginx/ssl/server.key || return 1
    chmod 644 /etc/nginx/ssl/server.crt || return 1
    chown nginx:nginx /etc/nginx/ssl/server.* || return 1
}

# Vérification des permissions
configure_permissions() {
    log "Configuration des permissions..."
    
    # Création des répertoires s'ils n'existent pas
    mkdir -p /var/www/app_nulle/ || return 1
    
    # Création du fichier index.html s'il n'existe pas
    if [ ! -f /var/www/app_nulle/index.html ]; then
        cat > /var/www/app_nulle/index.html << EOF || return 1
<h1>Hi, Im Slayz</h1>
EOF
    fi
    
    # Permissions des répertoires
    chmod 755 /var/www || return 1
    chmod -R 755 /var/www/app_nulle/ || return 1
    chown -R nginx:nginx /var/www/app_nulle/ || return 1
    
    # Permissions des logs
    mkdir -p /var/log/nginx || return 1
    chmod 755 /var/log/nginx || return 1
    chown -R nginx:nginx /var/log/nginx || return 1
}

# Exécution des fonctions
configure_default_site || exit 1
configure_firewall || exit 1
configure_ssl || exit 1
configure_permissions || exit 1

# Test de la configuration
nginx -t || exit 1

# Redémarrage de NGINX
systemctl restart nginx || exit 1

# Vérification du statut
if systemctl is-active --quiet nginx; then
    log "Configuration NGINX terminée avec succès"
else
    error "Erreur lors du redémarrage de NGINX"
    exit 1
fi 