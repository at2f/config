#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
### AJOUTER LES CORRECTIONS APRÈS CETTE LIGNE ###

# Ne pas afficher la corbeille dans « Dash to Dock » (barre latérale)
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false

### AJOUTER LES CORRECTIONS AVANT CETTE LIGNE ###
echo 'Corrections terminées.'
