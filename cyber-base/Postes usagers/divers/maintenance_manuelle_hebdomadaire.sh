#!/bin/bash

# Créer un répertoire temporaire et s’y déplacer
cd $(mktemp -d)

# Appliquer les modifications présentes dans le script « corrections.sh »
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/corrections.sh
chmod +x corrections.sh
./corrections.sh

# Synchroniser la liste des paquets
sudo apt update
# Télécharger et mettre à jour les paquets
sudo apt upgrade -y
# Supprimer les paquets obsolètes
sudo apt autoremove -y
# Mettre à jour les snaps
sudo snap refresh

## Mettre à jour Firefox
# Télécharger la dernière version de Firefox
wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=fr"
# Extraire l’archive
tar -xjvf firefox.tar.bz2
# Mettre à jour Firefox
sudo rsync -av --delete ./firefox/* /usr/local/bin/Firefox/
# Changer le propriétaire du répertoire vers l’utilisateur root
sudo chown -R root:root /usr/local/bin/Firefox

# Télécharger le fichier de configuration de Firefox
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/firefox/policies.json
# Installer le fichier de configuration de Firefox
sudo cp policies.json /etc/firefox/policies/
# Télécharger le fichier de configuration de uBlock Origin
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/firefox/uBlock0%40raymondhill.net.json
# Installer le fichier de configuration de uBlock Origin
sudo cp uBlock0@raymondhill.net.json /usr/lib/mozilla/managed-storage/
# Ouvrir la page des filtres de uBlock Origin pour les mettre à jour
notify-send --hint int:transient:1 'uBlock Origin' 'Vider le cache et mettre à jour les filtres.'
firefox
# Attendre que Firefox soit fermé avant de continuer
wait $(pidof firefox)
# Télécharger la liste des fichiers/répertoires à ne pas synchroniser avec rsync
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/rsync_ignorer
# Synchroniser le répertoire skel
sudo rsync -avz --delete --exclude-from=rsync_ignorer "${HOME}/" /etc/skel
