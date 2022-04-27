#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
rm -f ~/installation_pc_cyber-base.sh

#sudo smbpasswd -x usager
#read -rp 'Entrer le mot de passe du partage SAMBA pour recevoir les scans : ' mdp_samba
#echo -ne "${mdp_samba}\n${mdp_samba}\n" | sudo smbpasswd -aes usager
