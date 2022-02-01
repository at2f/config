#!/usr/bin/bash
# Définition des variables nécessaires aux messages spéciaux d'anniversaires
aujourdhui=$(date +"%d/%m")
annee_en_cours=$(date +"%Y")

extinction_du_poste () {
    # Liste les liens existants sur la page de connexion Téïcée
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com |\
    # Filtre les liens pour ne garder que celui vers le bouton de déconnexion
    grep logout |\
    # Ouvre le lien du bouton de déconnexion avec lynx, et cache la sortie avec nohup
    nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    # Ajout d'un délai de 6s pour laisser le temps à lynx d'atteindre la page de déconnexion, et affiche aux usagers ce que l'extinction fait
    printf "Déconnexion des comptes en ligne…\n"
    sleep 2
    printf "Suppression des documents sur l’ordinateur…\n"
    sleep 2
    printf "Suppression de l’historique internet…\n"
    sleep 2
    shutdown now
}

if [[ ${aujourdhui} = '24/01' ]]; then
    age_at2f=$((annee_en_cours-1973))
    printf "Aujourd’hui les Ateliers de la Fontaine ont ${age_at2f} ans. Joyeux anniversaire !\n"
    extinction_du_poste

elif [[ ${aujourdhui} = '12/03' ]]; then
    age_web=$((annee_en_cours-1989))
    printf "Aujourd’hui le Web a ${age_web} ans. Joyeux anniversaire !\n"
    extinction_du_poste

elif [[ ${aujourdhui} = '01/04' ]]; then
    printf " Tentative d'intrusion sur le serveur de l’Élysée…\n"
    sleep 2
    printf " Contournement du pare-feu…\n"
    sleep 2
    printf " Brèche de sécurité trouvée ! Connexion établie.\n"
    sleep 1
    for pourcentage in {1..100}
    do
    printf " Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : ${pourcentage} %%\r"
    sleep 0.05
    done
    echo
    sleep 0.2
    printf " Déchiffrement du mot de passe…\n"
    sleep 3
    printf " Mot de passe trouvé, ouverture de l’archive…\n"
    sleep 2
    printf " ALERTE !!! Le serveur était un pot de miel, nous sommes repérés !\n"
    sleep 5
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com |\
    grep logout |\
    nohup lynx -dump -accept_all_cookies - > /tmp/nohup.out 2>&1 &
    for compte_a_rebours in {5..1}
    do
    printf " Autodestruction dans ${compte_a_rebours}.\r"
    sleep 1
    done
    shutdown now

elif [[ ${aujourdhui} = '25/08' ]]; then
    age_linux=$((annee_en_cours-1991))
    printf "Aujourd’hui Linux a ${age_linux} ans. Joyeux anniversaire !\n"
    extinction_du_poste

elif [[ ${aujourdhui} = '20/10' ]]; then
    age_ubuntu=$((annee_en_cours-2004))
    printf "Aujourd’hui Ubuntu a ${age_ubuntu} ans. Joyeux anniversaire !\n"
    extinction_du_poste

elif [[ ${aujourdhui} = @(24|25|26|27|28|29|30|31)'/10' ]]; then
    printf "Du 24 au 31 octobre, nous célébrons la semaine mondiale\nde l’éducation aux médias et à l’information !\n"
    extinction_du_poste

elif [[ ${aujourdhui} = '24/12' ]]; then
    printf "Joyeux Noël !\n"
    extinction_du_poste

else
    # Affiche un message indiquant que l'extinction est en cours
    printf "Extinction de l’ordinateur en cours…\n"
    extinction_du_poste
fi
