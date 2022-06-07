#!/usr/bin/bash

# Cacher le répertoire « snap » situé dans le dossier home
grep -qx snap ~/.hidden &> /dev/null || echo snap >> ~/.hidden
# Supprime le répertoire « Public »
rmdir ~/Public
# En mode liste, afficher les colonnes Nom, Taille, Type, et Dernière modification
gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'date_modified']"
## Ajouter des scripts au menu contextuel de l’explorateur de fichiers
# Créer le répertoire
mkdir -p ~/.local/share/nautilus/scripts/
# Se déplacer dans un dossier temporaire et ouvrir un subshell
( cd "$(mktemp -d)"
# Télécharger et installer les scripts
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/scripts_nautilus/Compresser%20et%20aplatir%20les%20PDFs
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/scripts_nautilus/Rassembler%20les%20fichiers%20dans%20un%20PDF
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/scripts_nautilus/Rogner%20les%20contours%20des%20images
cp 'Compresser et aplatir les PDFs sélectionnés' ~/.local/share/nautilus/scripts/
cp 'Rassembler les images sélectionnées dans un PDF' ~/.local/share/nautilus/scripts/
cp 'Rogner les contours des images sélectionnées' ~/.local/share/nautilus/scripts/
# Fermer le subshell
)
# Les rendre exécutables
chmod +x ~/.local/share/nautilus/scripts/*
