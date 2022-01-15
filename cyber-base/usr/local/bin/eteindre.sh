#!/usr/bin/env bash
# Définition des variables nécessaires aux messages spéciaux d'anniversaires
aujourdhui=`date +"%d/%m"`
annee_en_cours=`date +"%Y"`

if [ $aujourdhui = '12/03' ]; then
    age_web=`expr $annee_en_cours - 1989`
    printf "Aujourd’hui le Web a $age_web ans. Joyeux anniversaire !\n"
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com > /tmp/page_connexion_teicee
    grep logout /tmp/page_connexion_teicee > /tmp/bouton_deconnexion_teicee
    cat /tmp/bouton_deconnexion_teicee | nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    printf "Déconnexion des comptes en ligne…\n"
    sleep 2
    printf "Suppression des documents sur l’ordinateur…\n"
    sleep 2
    printf "Suppression de l’historique internet…\n"
    sleep 2
    shutdown now

elif [ $aujourdhui = '01/04' ]; then
    printf "Tentative d'intrusion sur le serveur de l’Élysée…\n"
    sleep 2
    printf "Contournement du pare-feu…\n"
    sleep 2
    printf "Brèche de sécurité trouvée ! Connexion établie.\n"
    sleep 1
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 0 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 7 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 14 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 21 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 28 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 35 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 42 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 49 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 56 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 63 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 70 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 77 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 84 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 91 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 98 %%\r"
    sleep 0.2
    printf "Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : 100 %%\n"
    sleep 0.2
    printf "Déchiffrement du mot de passe…\n"
    sleep 3
    printf "Mot de passe trouvé, ouverture de l’archive…\n"
    sleep 2
    printf "ALERTE !!! Le serveur était un pot de miel, nous sommes repérés !\n"
    sleep 5
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com > /tmp/page_connexion_teicee
    grep logout /tmp/page_connexion_teicee > /tmp/bouton_deconnexion_teicee
    cat /tmp/bouton_deconnexion_teicee | nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    printf "Autodestruction dans 5.\r"
    sleep 1
    printf "Autodestruction dans 4.\r"
    sleep 1
    printf "Autodestruction dans 3.\r"
    sleep 1
    printf "Autodestruction dans 2.\r"
    sleep 1
    printf "Autodestruction dans 1.\n"
    sleep 1
    shutdown now

elif [ $aujourdhui = '25/08' ]; then
    age_linux=`expr $annee_en_cours - 1991`
    printf "Aujourd’hui Linux a $age_linux ans. Joyeux anniversaire !\n"
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com > /tmp/page_connexion_teicee
    grep logout /tmp/page_connexion_teicee > /tmp/bouton_deconnexion_teicee
    cat /tmp/bouton_deconnexion_teicee | nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    printf "Déconnexion des comptes en ligne…\n"
    sleep 2
    printf "Suppression des documents sur l’ordinateur…\n"
    sleep 2
    printf "Suppression de l’historique internet…\n"
    sleep 2
    shutdown now

elif [ $aujourdhui = '20/10' ]; then
    age_ubuntu=`expr $annee_en_cours - 2004`
    printf "Aujourd’hui Ubuntu a $age_ubuntu ans. Joyeux anniversaire !\n"
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com > /tmp/page_connexion_teicee
    grep logout /tmp/page_connexion_teicee > /tmp/bouton_deconnexion_teicee
    cat /tmp/bouton_deconnexion_teicee | nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    printf "Déconnexion des comptes en ligne…\n"
    sleep 2
    printf "Suppression des documents sur l’ordinateur…\n"
    sleep 2
    printf "Suppression de l’historique internet…\n"
    sleep 2
    shutdown now

elif [ $aujourdhui = '24/10' ] || [ $aujourdhui = '25/10' ] || [ $aujourdhui = '26/10' ] || [ $aujourdhui = '27/10' ] || [ $aujourdhui = '28/10' ] || [ $aujourdhui = '29/10' ] || [ $aujourdhui = '30/10' ] || [ $aujourdhui = '31/10' ]; then
    printf "Du 24 au 31 octobre, nous célébrons la semaine mondiale\nde l’éducation aux médias et à l’information !\n"
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com > /tmp/page_connexion_teicee
    grep logout /tmp/page_connexion_teicee > /tmp/bouton_deconnexion_teicee
    cat /tmp/bouton_deconnexion_teicee | nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    printf "Déconnexion des comptes en ligne…\n"
    sleep 2
    printf "Suppression des documents sur l’ordinateur…\n"
    sleep 2
    printf "Suppression de l’historique internet…\n"
    sleep 2
    shutdown now

elif [ $aujourdhui = '24/12' ]; then
    printf "Joyeux Noël !\n"
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com > /tmp/page_connexion_teicee
    grep logout /tmp/page_connexion_teicee > /tmp/bouton_deconnexion_teicee
    cat /tmp/bouton_deconnexion_teicee | nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    printf "Déconnexion des comptes en ligne…\n"
    sleep 2
    printf "Suppression des documents sur l’ordinateur…\n"
    sleep 2
    printf "Suppression de l’historique internet…\n"
    sleep 2
    shutdown now

else
    # Liste les liens existants sur la page de connexion Téïcée, et les envoie dans le fichier « page_connexion_teicee »
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com > /tmp/page_connexion_teicee
    # Filtre les liens pour ne garder que celui vers le bouton de déconnexion, et l'envoie dans le fichier « bouton_deconnexion_teicee »
    grep logout /tmp/page_connexion_teicee > /tmp/bouton_deconnexion_teicee
    # Ouvre le lien du bouton de déconnexion avec lynx, et cache la sortie avec nohup
    cat /tmp/bouton_deconnexion_teicee | nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    # Ajout d'un délai de 6s pour laisser le temps à lynx d'atteindre la page de déconnexion, et affiche aux usagers ce que l'extinction fait
    printf "Déconnexion des comptes en ligne…\n"
    sleep 2
    printf "Suppression des documents sur l’ordinateur…\n"
    sleep 2
    printf "Suppression de l’historique internet…\n"
    sleep 2
    shutdown now
fi
