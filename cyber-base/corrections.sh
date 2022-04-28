#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
rm -f ~/installation_pc_cyber-base.sh
rm -f ~/installation_postes_cyber-base.sh
# Créer le service qui lancera le script de déconnexion à l’extinction de l’ordinateur
sudo tee /etc/systemd/system/deconnexion_teicee.service << EOF > /dev/null
[Unit]
Description=Lance le script de déconnexion du compte Téïcée
After=network.target

[Service]
Type=oneshot
RemainAfterExit=true
ExecStop=/usr/local/sbin/deconnexion_teicee.sh

[Install]
WantedBy=multi-user.target
EOF
# Démarrer le service
sudo systemctl enable deconnexion_teicee
echo 'Corrections terminées.'
