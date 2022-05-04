#!/usr/bin/bash

# Cacher le répertoire « snap » situé dans le dossier home
grep -qx snap ~/.hidden &> /dev/null || echo snap >> ~/.hidden
# Supprime le répertoire « Public »
rmdir ~/Public
# Toujours afficher les vignettes d’aperçu des images/documents (y compris sur les périphériques externes)
gsettings set org.gnome.nautilus.preferences show-image-thumbnails always
# Afficher les vignettes pour les documents faisant 4 Go au maximum (au lieu de 512 Mo par défaut)
gsettings set org.gnome.nautilus.preferences thumbnail-limit 4096
# Lors d’une recherche, chercher dans les sous-dossiers également
gsettings set org.gnome.nautilus.preferences recursive-search always
# Toujours afficher le nombre de fichiers dans un dossier
gsettings set org.gnome.nautilus.preferences show-directory-item-counts always
# En mode liste, afficher les colonnes Nom, Taille, Type, et Dernière modification
gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'date_modified']"
## Ajouter des scripts au menu contextuel de l’explorateur de fichiers
# Créer le répertoire
mkdir -p ~/.local/share/nautilus/scripts/
# Se déplacer dans un dossier temporaire et ouvrir un subshell
( cd "$(mktemp -d)"
# Télécharger et installer les scripts
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/scripts_nautilus/Compresser%20et%20aplatir%20les%20PDFs%20s%C3%A9lectionn%C3%A9s
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/scripts_nautilus/Rassembler%20les%20images%20s%C3%A9lectionn%C3%A9es%20dans%20un%20PDF
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/scripts_nautilus/Rogner%20les%20contours%20des%20images%20s%C3%A9lectionn%C3%A9es
cp 'Compresser et aplatir les PDFs sélectionnés' ~/.local/share/nautilus/scripts/
cp 'Rassembler les images sélectionnées dans un PDF' ~/.local/share/nautilus/scripts/
cp 'Rogner les contours des images sélectionnées' ~/.local/share/nautilus/scripts/
# Fermer le subshell
)
# Les rendre exécutables
chmod +x ~/.local/share/nautilus/scripts/*
