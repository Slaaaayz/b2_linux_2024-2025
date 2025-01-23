#!/bin/bash

# Vérification que le script est exécuté en tant que root
if [ "$EUID" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant que root"
    exit 1
fi

# Vérification des dépendances
DEPS=("dnf" "systemctl" "firewall-cmd")
for dep in "${DEPS[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        echo "Erreur: $dep n'est pas installé"
        exit 1
    fi
done

# Définition des couleurs pour les messages
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export NC='\033[0m'

# Fonction pour afficher les messages
log() {
    echo -e "${GREEN}[+]${NC} $1"
}
export -f log

error() {
    echo -e "${RED}[!]${NC} $1"
}
export -f error

# Vérification de la présence des scripts
SCRIPTS=("os_config.sh" "ssh_config.sh" "nginx_config.sh" "security_tools.sh")
for script in "${SCRIPTS[@]}"; do
    if [ ! -f "$script" ]; then
        error "Script $script manquant"
        exit 1
    fi
done

# Exécution des scripts
log "Début du processus de hardening..."

for script in "${SCRIPTS[@]}"; do
    log "Exécution de $script..."
    bash "./$script"
    if [ $? -ne 0 ]; then
        error "Erreur lors de l'exécution de $script"
        exit 1
    fi
done

log "Processus de hardening terminé avec succès" 