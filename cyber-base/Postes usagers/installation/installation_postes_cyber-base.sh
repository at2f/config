#!/usr/bin/bash


# Créer le mot de passe du partage SAMBA
read -rp 'Entrer le mot de passe du partage SAMBA pour recevoir les scans : ' mdp_samba


./modules/configurer_gestionnaire_de_paquets.sh
./modules/configurer_explorateur_de_fichiers
./modules/configurer_interface.sh
./modules/configurer_securite_et_confidentialite.sh
./modules/configurer_performances.sh
./modules/configurer_teicee.sh
./modules/configurer_firefox.sh
./modules/configurer_scanner.sh
./modules/configurer_session_usager.sh


# Configuration manuelle
notify-send --hint int:transient:1 'LibreOffice' 'Activer l’interface en onglets pour tous les logiciels de la suite : Affichage -> Interface utilisateur -> Onglets'
libreoffice --writer
wait $(pidof libreoffice)
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

