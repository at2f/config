#!/usr/bin/bash

## Création du compte usager ##
# Créer un utilisateur « usager » dont le /home se trouve sur un tmpfs
sudo useradd usager -m -d /dev/shm/usager -c Usager -s /bin/bash
# Générer un mot de passe aléatoire
mdp_usager=$(printf "$(date)${RANDOM}" | md5sum | cut -d' ' -f1)
# Assigner ce mot de passe
echo "$usager:${mdp_usager}" | chpasswd
# Activer la connexion automatique
sudo sed -i 's/.*AutomaticLoginEnable =.*/AutomaticLoginEnable = true/' /etc/gdm3/custom.conf
sudo sed -i 's/.*AutomaticLogin =.*/AutomaticLogin = usager/' /etc/gdm3/custom.conf
# Interdire le changement de mots de passe pour tout le monde sauf root
sudo chmod u-s /usr/bin/passwd
# Créer le service pour recréer automatiquement le home de usager au démarrage de l’ordinateur
sudo tee /etc/systemd/system/mkhomedir_helper.service << EOF > /dev/null
[Unit]
Description=Lance le service mkhomedir_helper pour créer un répertoire home pour usager à partir du modèle skel.

[Service]
ExecStart=/usr/sbin/mkhomedir_helper usager

[Install]
WantedBy=graphical.target
EOF
# Lancer le service
sudo systemctl enable --now mkhomedir_helper
