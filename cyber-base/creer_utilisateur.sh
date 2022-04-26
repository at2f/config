#!/usr/bin/bash

if [[ $# != 2 ]] ; then
  echo "Usage: $0 login 'User name'"
  exit 1
fi

# Cr\u00e9er l\u2019utilisateur
useradd -m ${1} -s /bin/bash -c "${2}"

# G\u00e9n\u00e9rer un mot de passe al\u00e9atoire
user_password=$(printf "$(date)${RANDOM}" | md5sum | cut -d' ' -f1) 

# Assigner ce mot de passe \u00e0 l\u2019utilisateur
echo "${1}:${user_password}" | chpasswd

