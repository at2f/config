#!/usr/bin/bash

# Si l’assignation du mot de passe échoue, supprimmer l’utilisateur avec la commande suivante :
# userdel -r 'login'

if [[ $# != 2 ]] ; then
  echo "Usage: $0 login 'User name'"
  exit 1
fi

# Créer l’utilisateur
useradd -m ${1} -s /bin/bash -c "${2}"

# Générer un mot de passe aléatoire
user_password=$(printf "$(date)${RANDOM}" | md5sum | cut -d' ' -f1)

# Assigner ce mot de passe à l’utilisateur
echo "${1}:${user_password}" | chpasswd
