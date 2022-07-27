#!/usr/bin/bash

## Configuration du partage Samba pour le répertoire de destination des scans ##
# Créer le mot de passe du partage SAMBA
read -rp 'Entrer le mot de passe du partage SAMBA pour recevoir les scans : ' mdp_samba
# Installer SAMBA
sudo apt install -y samba
# Autoriser Samba dans le pare-feu
sudo ufw allow samba
# Ajouter l’utilisateur usager au groupe sambashare
sudo usermod -aG sambashare usager
# Assigner le mot de passe du compte SAMBA « usager »
echo -ne "${mdp_samba}\n${mdp_samba}\n" | sudo smbpasswd -as usager
# Créer le répertoire « Scans »
mkdir -p ~/Scans
# Autoriser les utilisateurs à créer des partages même s’ils ne sont pas propriétaires du répertoire
#sudo sed -i '/\[global\]/a usershare owner only = false' /etc/samba/smb.conf
# Créer le fichier de configuration de partage du répertoire Scans
sudo tee /var/lib/samba/usershares/scans << EOF > /dev/null
#VERSION 2
path=/dev/shm/usager/Scans
comment=
usershare_acl=S-1-1-0:F
guest_ok=n
sharename=Scans
EOF
# Changer le propriétaire du fichier de configuration vers l’utilisateur usager
sudo chown usager:usager /var/lib/samba/usershares/scans
