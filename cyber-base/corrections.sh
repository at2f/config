#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
rm -f ~/installation_pc_cyber-base.sh

echo -e "${mdp_samba}\n${mdp_samba}\n" | sudo smbpasswd -aes usager
