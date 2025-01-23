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

log "Configuration de SSH..."

# Installation de SSH si nécessaire
if ! command -v sshd &> /dev/null; then
    log "Installation de OpenSSH..."
    dnf install -y openssh-server || exit 1
fi

# Sauvegarde de la configuration SSH originale
if [ ! -f /etc/ssh/sshd_config.orig ]; then
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig || exit 1
fi

# Configuration SSH sécurisée
configure_ssh() {
    log "Application de la configuration SSH sécurisée..."
    
    cat > /etc/ssh/sshd_config << EOF || return 1
# Configuration SSH sécurisée

# Protocole et ports
Port 22
Protocol 2

# Authentification
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
PermitEmptyPasswords no
AuthenticationMethods publickey

# Restriction des utilisateurs
AllowUsers slayz
MaxAuthTries 3
MaxSessions 2

# Timeouts
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 2

# Forwarding et tunneling
X11Forwarding no
AllowTcpForwarding no
AllowAgentForwarding no
PermitTunnel no

# Bannière et logging
Banner /etc/ssh/banner
LogLevel VERBOSE

# Algorithmes et chiffrement
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group16-sha512
HostKeyAlgorithms ssh-ed25519,rsa-sha2-512,rsa-sha2-256

# Autres options de sécurité
StrictModes yes
UsePrivilegeSeparation sandbox
PermitUserEnvironment no
EOF

    # Création d'une bannière personnalisée
    cat > /etc/ssh/banner << EOF || return 1
***************************************************************************
*                                                                         *
*                     Accès autorisé uniquement                          *
*              Toute tentative non autorisée sera signalée              *
*                                                                         *
***************************************************************************
EOF
}

# Configuration des clés SSH pour l'utilisateur
configure_user_keys() {
    local user="slayz"
    log "Configuration des clés SSH pour l'utilisateur $user..."
    
    # Vérification que l'utilisateur existe
    if ! id -u "$user" >/dev/null 2>&1; then
        error "L'utilisateur $user n'existe pas"
        return 1
    fi
    
    # Création du répertoire .ssh avec les bonnes permissions
    if [ ! -d "/home/$user/.ssh" ]; then
        mkdir -p "/home/$user/.ssh" || return 1
        chmod 700 "/home/$user/.ssh" || return 1
        chown "$user:$user" "/home/$user/.ssh" || return 1
    fi
    
    # Création/Configuration du fichier authorized_keys
    touch "/home/$user/.ssh/authorized_keys" || return 1
    chmod 600 "/home/$user/.ssh/authorized_keys" || return 1
    chown "$user:$user" "/home/$user/.ssh/authorized_keys" || return 1
}

# Configuration du pare-feu pour SSH
configure_firewall() {
    log "Configuration du pare-feu pour SSH..."
    
    # Ajout de la règle pour SSH
    firewall-cmd --permanent --add-service=ssh || return 1
    firewall-cmd --reload || return 1
}

# Exécution des fonctions
configure_ssh || exit 1
configure_user_keys || exit 1
configure_firewall || exit 1

# Redémarrage du service SSH
systemctl restart sshd || exit 1

# Vérification du statut
if systemctl is-active --quiet sshd; then
    log "Configuration SSH terminée avec succès"
else
    error "Erreur lors du redémarrage du service SSH"
    exit 1
fi 