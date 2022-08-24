#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
### AJOUTER LES CORRECTIONS APRÈS CETTE LIGNE ###

# Installer le support des systèmes de fichier iOS
sudo apt install -y ifuse
# Installer le support des images HEIF
sudo apt install -y heif-gdk-pixbuf heif-thumbnailer
# Définir la visionneuse d’images (Eye Of GNOME) comme logiciel par défaut pour ouvrir les images HEIF
xdg-mime default org.gnome.eog.desktop image/heic

### AJOUTER LES CORRECTIONS AVANT CETTE LIGNE ###
echo 'Corrections terminées.'
