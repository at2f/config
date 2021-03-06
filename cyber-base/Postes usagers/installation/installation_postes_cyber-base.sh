#!/usr/bin/bash


bash ./modules/configurer_gestionnaire_de_paquets.sh
bash ./modules/configurer_session_usager.sh
bash ./modules/configurer_explorateur_de_fichiers.sh
bash ./modules/configurer_interface.sh
bash ./modules/configurer_firefox.sh
bash ./modules/configurer_scanner.sh
bash ./modules/configurer_securite_et_confidentialite.sh
bash ./modules/configurer_performances.sh
bash ./modules/configurer_teicee.sh


# Configuration manuelle
echo 'Firefox : Ajouter le bouton de capture d’écran à la barre d’outils & vérifier le moteur de recherche.'
notify-send --hint int:transient:1 'Firefox' 'Ajouter le bouton de capture d’écran à la barre d’outils & vérifier le moteur de recherche.'
firefox about:preferences#search
wait $(pidof firefox)


# Télécharger le script de maintenance hebdomadaire
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/divers/maintenance_manuelle_hebdomadaire.sh
# Copier le script dans le répertoire utilisateur
cp -f maintenance_manuelle_hebdomadaire.sh ~/maintenance_manuelle_hebdomadaire.sh
# Rendre le script exécutable
chmod 755 ~/maintenance_manuelle_hebdomadaire.sh
# Lancer le script
~/maintenance_manuelle_hebdomadaire.sh
