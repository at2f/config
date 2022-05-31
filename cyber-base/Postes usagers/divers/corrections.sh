#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
### AJOUTER LES CORRECTIONS APRÈS CETTE LIGNE ###

# Toujours afficher les vignettes d’aperçu des images/documents (y compris sur les périphériques externes)
gsettings reset org.gnome.nautilus.preferences show-image-thumbnails
# Afficher les vignettes pour les documents faisant 4 Go au maximum (au lieu de 512 Mo par défaut)
gsettings reset org.gnome.nautilus.preferences thumbnail-limit
# Lors d’une recherche, chercher dans les sous-dossiers également
gsettings reset org.gnome.nautilus.preferences recursive-searchs
# Toujours afficher le nombre de fichiers dans un dossier
gsettings reset org.gnome.nautilus.preferences show-directory-item-counts

### AJOUTER LES CORRECTIONS AVANT CETTE LIGNE ###
echo 'Corrections terminées.'
