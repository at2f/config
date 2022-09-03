#!/usr/bin/bash

# Ajouter les corrections à appliquer aux postes usagers.
# Elles seront appliquées lors de l’exécution du script de maintenance.

echo 'Appliquation des corrections…'
### AJOUTER LES CORRECTIONS APRÈS CETTE LIGNE ###

#!/usr/bin/bash

# Supprimer l’installation actuelle de Firefox
sudo rm -rf /usr/local/bin/Firefox/*
sudo rm -rf ~/.mozilla

(
cd $(mktemp -d)
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/installation/modules/configurer_firefox.sh
bash ./configurer_firefox.sh
)

### AJOUTER LES CORRECTIONS AVANT CETTE LIGNE ###
echo 'Corrections terminées.'
