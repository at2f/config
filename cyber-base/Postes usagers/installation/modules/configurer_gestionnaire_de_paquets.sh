#!/usr/bin/bash

# Désactiver les notifications de nouvelles mises à jour
gsettings set com.ubuntu.update-notifier no-show-notifications true
# Désactiver les mises à jour automatiques
sudo sed -i 's/"1"/"0"/g' /etc/apt/apt.conf.d/20auto-upgrades
# Mettre à jour la liste des paquets disponibles
sudo apt update
# Mettre à jour les paquets
sudo apt upgrade -y
# Installer les paquets propriétaires (codecs multimédias, pilotes wi-fi, etc.)
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt install -y ubuntu-restricted-extras
# Installer le support des DVD
sudo DEBIAN_FRONTEND=noninteractive apt install -y libdvd-pkg
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure libdvd-pkg
# Installer le gestionnaire de tâches htop
sudo apt install -y htop
# Installer LibreOffice
sudo apt install -y libreoffice
# Installer le lecteur multimédia Celluloid
sudo apt install -y celluloid
# Installer GIMP
sudo apt install -y gimp
# Installer ImageMagick pour les scripts de conversion d’images/pdf
sudo apt install -y imagemagick
# Permettre à ImageMagick de convertir des images en PDF
sudo sed -i_bak 's/rights="none" pattern="PDF"/rights="read | write" pattern="PDF"/' /etc/ImageMagick-6/policy.xml
# Installation de lynx et purge + blacklist de wslu pour satisfaire la dépendance du paquet virtuel « www-browser »
# et éviter le bug https://bugs.launchpad.net/ubuntu/+source/wslu/+bug/1971757
sudo apt install -y lynx
sudo apt purge -y wslu
sudo apt-mark hold wslu
# Installer le support des systèmes de fichier iOS
sudo apt install -y ifuse
# Installer le support des images HEIF
sudo apt install -y heif-gdk-pixbuf heif-thumbnailer
# Définir la visionneuse d’images (Eye Of GNOME) comme logiciel par défaut pour ouvrir les images HEIF
xdg-mime default org.gnome.eog.desktop image/heic
# Installer les paquets de traduction manquants
sudo apt install -y $(check-language-support)
# Supprimer quelques paquets inutiles pour les postes publics
sudo apt purge -y whoopsie apport ubuntu-report popularity-contest
# Supprimer les paquets obsolètes
sudo apt autoremove -y
