#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
### AJOUTER LES CORRECTIONS APRÈS CETTE LIGNE ###

rm -rf ~/installation_postes_cyber-base.sh
rm -rf ~/modules
sudo apt-mark hold wslu


### AJOUTER LES CORRECTIONS AVANT CETTE LIGNE ###
echo 'Corrections terminées.'
