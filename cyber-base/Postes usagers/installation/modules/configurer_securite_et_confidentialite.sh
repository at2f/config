#!/usr/bin/bash

# Activer le pare-feu
sudo ufw enable
# Supprimer les fichiers temporaires & dans la corbeille chaque jour
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy old-files-age 1
# Supprimer les fichiers récents chaque jour
gsettings set org.gnome.desktop.privacy recent-files-max-age 1
# Désactiver l’envoi des statistiques d’usage des logiciels
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
