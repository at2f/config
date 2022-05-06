#!/usr/bin/bash

# Installer le navigateur web en ligne de commande Lynx, nécessaire pour déconnecter les usagers de Tic'nCube à l’extinction du poste
sudo apt install -y lynx
# Créer le script de déconnexion du compte Téïcée
sudo tee /usr/local/sbin/deconnexion_ticncube.sh << EOF > /dev/null
#!/usr/bin/bash

# Liste les liens existants sur la page de connexion Téïcée
lynx -listonly -nonumbers -dump https://at2f.ticncube.com |\\
# Filtre les liens pour ne garder que celui vers le bouton de déconnexion
grep logout |\\
# Ouvre le lien du bouton de déconnexion avec lynx, et cache la sortie avec nohup
nohup lynx -dump -accept_all_cookies - &> /dev/null &
# Ajouter un délai pour laisser le temps à lynx d’atteindre la page de déconnexion
sleep 5
EOF
# Rendre le script exécutable
sudo chmod 755 /usr/local/sbin/deconnexion_ticncube.sh
# Créer le service qui lancera le script de déconnexion à l’extinction de l’ordinateur
sudo tee /etc/systemd/system/deconnexion_ticncube.service << EOF > /dev/null
[Unit]
Description=Lance le script de déconnexion du compte Téïcée
After=network.target

[Service]
Type=oneshot
RemainAfterExit=true
ExecStop=/usr/local/sbin/deconnexion_ticncube.sh

[Install]
WantedBy=multi-user.target
EOF
# Démarrer le service
sudo systemctl enable deconnexion_ticncube
# Régler le problème de fenêtre intempestive avec le filtrage réseau Téïcée
sudo tee -a /etc/NetworkManager/NetworkManager.conf << EOF > /dev/null

[connectivity]
enabled=false
EOF
