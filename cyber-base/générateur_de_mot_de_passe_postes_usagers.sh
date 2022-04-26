#!/usr/bin/bash

generer_un_mot_de_passe() {
  mot_de_passe=$(
  tr -dc [:graph:] < /dev/urandom |\
  tr -d "\'\"_^<>$~\`\\\{}[]|oO01lI-" |\
  head -c 14)
}

# Génère un mot de passe jusqu’à en trouver un avec au moins une minuscule,
# une majuscule, un chiffre, et entre 1 & 3 caractères spéciaux
while [[ ${critere_de_conformite} -ne 5 ]] ; do
  generer_un_mot_de_passe
  # Réinitialise le compteur des critères de conformité à chaque passe
  critere_de_conformite='0'
  if [[ $(printf "%s" "${mot_de_passe}" | tr -dc a-z | wc -c) -gt 0 ]] ; then
    critere_de_conformite=$(( ${critere_de_conformite} + 1 ))
  fi
  if [[ $(printf "%s" "${mot_de_passe}" | tr -dc A-Z | wc -c) -gt 0 ]] ; then
    critere_de_conformite=$(( ${critere_de_conformite} + 1 ))
  fi
  if [[ $(printf "%s" "${mot_de_passe}" | tr -dc 0-9 | wc -c) -gt 0 ]] ; then
    critere_de_conformite=$(( ${critere_de_conformite} + 1 ))
  fi
  if [[ $(printf "%s" "${mot_de_passe}" | tr -d 0-9a-zA-Z | wc -c) -gt 0 ]] ; then
    critere_de_conformite=$(( ${critere_de_conformite} + 1 ))
  fi
  if [[ $(printf "%s" "${mot_de_passe}" | tr -d 0-9a-zA-Z | wc -c) -lt 4 ]] ; then
    critere_de_conformite=$(( ${critere_de_conformite} + 1 ))
  fi
done

case ${XDG_SESSION_TYPE} in
  wayland)  printf "%s" "${mot_de_passe}" | wl-copy ;;
  x11)      printf "%s" "${mot_de_passe}" | xclip -selection clip-board ;;
esac

notify-send "Mot de passe :     ${mot_de_passe}" "Collez-le avec clic-droit -> Coller ou bien ctrl + v."
