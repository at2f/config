#!/usr/bin/bash

# Ouvrir les nouvelles fenêtres au centre de l’écran
gsettings set org.gnome.mutter center-new-windows true
# Activer le fuseau horaire automatique
gsettings set org.gnome.desktop.datetime automatic-timezone true
# Afficher le jour de la semaine dans l’horloge
gsettings set org.gnome.desktop.interface clock-show-weekday true
# Désactiver l’historique d’utilisation des applications
gsettings set org.gnome.desktop.privacy remember-app-usage false
# Désactiver la possibilité de verrouiller l’écran
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
# Désactiver la mise en veille
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
# Désactiver le verrouillage de la session lors de l’économie d’écran
gsettings set org.gnome.desktop.screensaver lock-enabled false
# Régler le nombre d’espaces de travail sur le mode fixe
gsettings set org.gnome.mutter dynamic-workspaces false
# Régler le nombre d’espaces de travail à 1
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
# Activer le verrouillage numérique
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true
# Se souvenir de l’état du verrouillage numérique à l’ouverture de la session
gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
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
# Se déplacer dans un dossier temporaire et ouvrir un subshell
( cd "$(mktemp -d)"

# Télécharger le script d’extinction des postes
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/eteindre.sh
# Installer le script
sudo cp -f eteindre.sh /usr/local/bin/
# Rendre le script exécutable
sudo chmod 755 /usr/local/bin/eteindre.sh
# Télécharger le fond d’écran
wget https://github.com/at2f/config/raw/main/cyber-base/fond_ecran_postes_usagers_cyber-base.png
# Créer le répertoire des fonds d’écrans
sudo mkdir -p /usr/share/backgrounds
# Copier le fond d’écran dans /usr/share/backgrounds
sudo cp fond_ecran_postes_usagers_cyber-base.png /usr/share/backgrounds/
# Fermer le subshell
)
# Changer le fond d’écran
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/fond_ecran_postes_usagers_cyber-base.png
# Définir les favoris dans « Dash to Dock » (barre latérale)
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'libreoffice-startcenter.desktop', 'eteindre.desktop']"
# Ne pas afficher la corbeille dans « Dash to Dock » (barre latérale)
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
# Ne pas afficher le dossier personnel sur le bureau
gsettings set org.gnome.shell.extensions.ding show-home false
# Ne pas afficher le bureau dans les raccourcis
gsettings set org.gnome.desktop.background show-desktop-icons false
