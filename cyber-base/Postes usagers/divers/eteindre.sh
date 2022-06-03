#!/usr/bin/bash

# Définition des variables nécessaires aux messages spéciaux d’anniversaires
aujourdhui=$(date +"%d/%m")
annee_en_cours=$(date +"%Y")

extinction_du_poste () {
  # Cache le curseur du terminal
  tput civis
  # Affiche un compte à rebours avant de lancer l’extinction
  for secondes in {5..1} ; do
    clear
    # Affiche le message du jour s’il y en a un
    if [[ ${message_du_jour} ]] ; then
      printf "%s\n\n" "${message_du_jour}"
    fi
    printf "Exctinction du poste dans %s secondes.\n" "${secondes}"
    printf 'Fermez cette fenêtre pour annuler.'
    sleep 1
  done
  systemctl poweroff
}

case "${aujourdhui}" in
  24/01)
    age_at2f=$((annee_en_cours-1973))
    message_du_jour="Aujourd’hui les Ateliers de la Fontaine ont ${age_at2f} ans. Joyeux anniversaire !"
    extinction_du_poste
  ;;
  12/03)
    age_web=$((annee_en_cours-1989))
    message_du_jour="Aujourd’hui le Web a ${age_web} ans. Joyeux anniversaire !"
    extinction_du_poste
  ;;
  01/04)
    lynx -listonly -nonumbers -dump https://at2f.ticncube.com |\
    grep logout |\
    nohup lynx -dump -accept_all_cookies - &> /dev/null &
    printf " Tentative d’intrusion sur le serveur de l’Élysée…\n" ; sleep 2
    printf " Contournement du pare-feu…\n" ; sleep 2
    printf " Brèche de sécurité trouvée ! Connexion établie.\n" ; sleep 1
    for pourcentage in {1..100} ; do
      printf " Téléchargement de l’archive « codes_nucléaires_secret_défense.tar.gz » : %s %%\r" "${pourcentage}"
      sleep 0.05
    done
    printf "\n" ; sleep 0.2
    printf " Déchiffrement du mot de passe…\n" ; sleep 3
    printf " Mot de passe trouvé, ouverture de l’archive…\n" ; sleep 2
    printf " ALERTE !!! Le serveur était un pot de miel, nous sommes repérés !\n" ; sleep 5
    for compte_a_rebours in {5..1} ; do
      printf " Autodestruction dans %s.\r" "${compte_a_rebours}"
      sleep 1
    done
    shutdown now
  ;;
  25/08)
    age_linux=$((annee_en_cours-1991))
    message_du_jour="Aujourd’hui Linux a ${age_linux} ans. Joyeux anniversaire !"
    extinction_du_poste
  ;;
  20/10)
    age_ubuntu=$((annee_en_cours-2004))
    message_du_jour="Aujourd’hui Ubuntu a ${age_ubuntu} ans. Joyeux anniversaire !"
    extinction_du_poste
  ;;
  2[456789]/10 | 3[01]/10)
    message_du_jour="Du 24 au 31 octobre, nous célébrons la semaine mondiale de l’éducation aux médias et à l’information !"
    extinction_du_poste
  ;;
  24/12)
    message_du_jour='Joyeux Noël !'
    extinction_du_poste
  ;;
  *)
    extinction_du_poste
  ;;
esac
