#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
rm -f ~/installation_pc_cyber-base.sh

firefox about:preferences#search
wait $(pidof firefox)

# Réactiver la possibilité de se déconnecter
gsettings reset org.gnome.desktop.lockdown disable-log-out
# Réactiver la possibilité de changer d’utilisateur
gsettings reset org.gnome.desktop.lockdown disable-user-switching

# Ne rien faire lorsque le bouton d’alimentation est enfoncé
gsettings reset org.gnome.settings-daemon.plugins.power power-button-action #nothing



# Créer le bouton d’extinction
sudo tee /usr/share/applications/eteindre.desktop << EOF > /dev/null
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Éteindre
Comment=Éteindre l’ordinateur.
Exec=/usr/local/bin/eteindre.sh
Icon=system-shutdown-symbolic.svg
Terminal=true
EOF
# Télécharger le script d’extinction des postes
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/eteindre.sh
# Installer le script
sudo cp -f eteindre.sh /usr/local/bin/
# Rendre le script exécutable
sudo chmod 755 /usr/local/bin/eteindre.sh

sudo rm -f /usr/local/bin/oust

# Créer le script de déconnexion du compte Téïcée
sudo tee /usr/local/sbin/deconnexion_teicee.sh << EOF > /dev/null
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
sudo chmod 755 /usr/local/sbin/deconnexion_teicee.sh


# Créer le service qui lancera le script de déconnexion à l’extinction de l’ordinateur
sudo tee /etc/systemd/system/deconnexion_teicee.service << EOF > /dev/null
[Unit]
Description=Lance le script de déconnexion du compte Téïcée
After=network.target

[Service]
Type=oneshot
RemainAfterExit=true
ExecStop=/usr/local/sbin/test.sh

[Install]
WantedBy=multi-user.target
EOF
# Démarrer le service
sudo systemctl enable deconnexion_teicee
