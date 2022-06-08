#!/usr/bin/bash
## Ce script installe le nécessaire pour générer des mots de passe aléatoires,
## les imprimer, et les copier dans le presse-papier.
## Il fonctionne sur Ubuntu, Fedora, et Windows via WSL (Windows Subsystem for Linux).
## Il suffit pour cela de lancer « mdp » via l’application ou un terminal Linux.

##################################################################################
## ÉDITER CETTE SECTION DU SCRIPT POUR CHANGER LA CONFIGURATION DE L’IMPRIMANTE ##
##################################################################################

## Vérifier les informations ci-dessous ##
nom_de_l_imprimante="mdp" # Max 127 caractères, pas de caractères spéciaux ni d’espaces
description_de_l_imprimante="Imprimante_pour_mdp"
emplacement_de_l_imprimante="Cyber-Base"
fichier_ppd="KMbeuC360iux.ppd"
uri_imprimante="socket://10.11.111.50"

# Demander les mots de passe de l'imprimante
read -rp 'Mot de passe noir & blanc de l’imprimante ? ' mot_de_passe_imprimante_nb
read -rp 'Mot de passe couleur de l’imprimante ? ' mot_de_passe_imprimante_couleur

## Lister les options disponibles avec la commande ci-dessous ##
# lpoptions -p $nom_de_l_imprimante -l
# Attention, l’imprimante doit déjà être installée avec le PPD correspondant.

## Options de l’imprimante ##
# Options installées
sources_papier="PC416"
unite_de_finition="FS536"
unite_de_perforation="None"
kit_couture="SD511"
storage="HDD"
modele="C250i"
# General
format_papier="A4"
# Finishing Options
type_d_impression="1Sided" # 1Sided = recto | 2Sided = recto/verso
# Quality
selectionner_couleur="Grayscale" # Options possibles : Auto Color Grayscale
image_quality_setting="Document" # Options possibles : Document-Photo Document Photo CAD
# Account Track
suivi_de_volume_ekc="True"
mot_de_passe_imprimante="Custom.${mot_de_passe_imprimante_nb}" # Options possibles : None Custom.$mot_de_passe_imprimante_couleur Custom.$mot_de_passe_imprimante_nb



###################################################
## INSTALLATION ET CONFIGURATION DE L’IMPRIMANTE ##
###################################################

# Créer le dossier temporaire qui recevra les téléchargements
dossier_temporaire=$(mktemp -d)
# Supprimer le dossier temporaire lorsque le script se termine ou est interrompu
trap "rm -rf ${dossier_temporaire}" 0 1 2 3 15

# Créer une fonction pour gérer les messages d’erreurs au fil du script
afficher_message_d_erreur_en_cas_d_echec () {
if [[ "${?}" -ne 0 ]] ; then
  printf "%s\n" "${@}" >&2
  exit 1
fi
}

installer_pilote () {
# Nom du pilote, sans « .tar.gz »
nom_pilote="KMbeuUXv1_24_multi_language"
url_telechargement="https://dl.konicaminolta.eu/fr?tx_kmanacondaimport_downloadproxy[fileId]=79da0f659ac2191cf88560aee21df50d&tx_kmanacondaimport_downloadproxy[documentId]=128230&tx_kmanacondaimport_downloadproxy[system]=KonicaMinolta&tx_kmanacondaimport_downloadproxy[language]=FR&type=1558521685"
## Pour obtenir l’adresse de téléchargement, télécharger l’archive sur le centre
## de téléchargement de Konica Minolta, ouvrir le menu des téléchargements, et
## faire un clic droit sur l’archive, puis sélectionner « Copier l’adresse
## d’origine du téléchargement ».
# Se déplacer dans le répertoire temporaire
( cd "${dossier_temporaire}" || exit 1
# Télécharger l’archive des pilotes de l’imprimante
wget -O "${nom_pilote}.tar.gz" "${url_telechargement}"
# Afficher un message d’erreur et quitter en cas d’échec
afficher_message_d_erreur_en_cas_d_echec "Erreur lors du téléchargement du pilote de l’imprimante."
# Extraire l’archive
tar -xf "${nom_pilote}".tar.gz
# Copier le fichier ppd dans le répertoire de configuration de CUPS
sudo cp "./${nom_pilote}/KMbeuC360iux.ppd" /usr/share/cups/model/
# Copier les filtres dans le répertoire des filtres de CUPS
sudo cp "./${nom_pilote}/KMbeuEmpPS.pl" /usr/lib/cups/filter/
sudo cp "./${nom_pilote}/KMbeuEnc.pm" /usr/lib/cups/filter/ )
# Redémarrer le service CUPS
sudo systemctl restart cups || sudo service cups restart
}

creer_imprimante () {
sudo lpadmin \
-p "${nom_de_l_imprimante}" \
-D "${description_de_l_imprimante}" \
-L "${emplacement_de_l_imprimante}" \
-E \
-v "${uri_imprimante}" \
-m ${fichier_ppd} \
-o PaperSources=${sources_papier} \
-o Finisher=${unite_de_finition} \
-o KOPunch=${unite_de_perforation} \
-o SaddleUnit=${kit_couture} \
-o PrinterHDD=${storage} \
-o Model=${modele} \
-o PageSize=${format_papier} \
-o KMDuplex=${type_d_impression} \
-o SelectColor=${selectionner_couleur} \
-o OriginalImageType=${image_quality_setting} \
-o KMSectionManagement=${suivi_de_volume_ekc} \
-o KMAccPass=${mot_de_passe_imprimante}
# Afficher un message d’erreur et quitter en cas d’échec
afficher_message_d_erreur_en_cas_d_echec "Erreur lors de la création de l’imprimante."
}



################################
## INSTALLATION DES PRÉREQUIS ##
################################

installer_prerequis_ubuntu () {
# Installer les paquets nécessaires
sudo apt install -y cups cups-bsd enscript unzip xclip wl-clipboard ttf2ufm
# Afficher un message d’erreur et quitter en cas d’échec
afficher_message_d_erreur_en_cas_d_echec "Erreur lors de l’installation des dépendances."
# Démarrer le service CUPS
sudo systemctl enable --now cups
}

installer_prerequis_fedora () {
# Installer les paquets nécessaires
sudo dnf install -y cups enscript unzip xclip wl-clipboard ttf2pt1
# Afficher un message d’erreur et quitter en cas d’échec
afficher_message_d_erreur_en_cas_d_echec "Erreur lors de l’installation des dépendances."
# Démarrer le service CUPS
sudo systemctl enable --now cups
}

installer_prerequis_wsl () {
# Installer les paquets nécessaires
sudo apt install -y cups cups-bsd enscript unzip ttf2ufm
# Afficher un message d’erreur et quitter en cas d’échec
afficher_message_d_erreur_en_cas_d_echec "Erreur lors de l’installation des dépendances."
# Démarrer le service CUPS
sudo service cups start
# Lancer CUPS au démarrage de WSL si ce n’est pas déjà le cas (Windows 11 minumum)
service_cups_start_existe=$(grep -sc "service cups start" /etc/wsl.conf)
if [[ "${service_cups_start_existe}" -eq 0 ]] ; then
sudo tee -a /etc/wsl.conf << EOF > /dev/null

[boot]
command="service cups start"
EOF
fi
# Ajouter l’utilisateur au groupe lpadmin
sudo usermod -a -G lpadmin "${USER}"
}



##########################################
## INSTALLATION DE LA POLICE D’ÉCRITURE ##
##########################################

installer_police_ecriture () {
# Se déplacer dans le répertoire temporaire
( cd "${dossier_temporaire}" || exit 1
# Télécharger la police Ubuntu
wget https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip
# Afficher un message d’erreur et quitter en cas d’échec
afficher_message_d_erreur_en_cas_d_echec "Erreur lors du téléchargement de la police."
# Extraire l’archive
unzip 0cef8205-ubuntu-font-family-0.83.zip
# Se déplacer dans le répertoire de l’archive extraite
cd ubuntu-font-family-0.83 || exit 1
# Convertir la police au format nécessaire pour enscript
ttf2pt1 --encode Ubuntu-R.ttf || ttf2ufm -b Ubuntu-R.ttf
# Copier les fichiers nécessaires dans le répertoire d’enscript
sudo cp Ubuntu-R.afm /usr/share/enscript/afm/
sudo cp Ubuntu-R.pf? /usr/share/enscript/afm/ )
# Ajouter la police à la liste d’enscript si elle n’en fait pas déjà partie
afm_existe=$(grep -sc "Ubuntu" /usr/share/enscript/afm/font.map)
if [[ "${afm_existe}" -eq 0 ]] ; then
echo "Ubuntu                          Ubuntu-R" | sudo tee -a /usr/share/enscript/afm/font.map > /dev/null
fi
}



###########################
## CRÉATION DU PROGRAMME ##
###########################

installer_script_mdp () {
# Créer le script « mdp » qui permettra de générer un mot de passe
# aléatoire, de l’imprimer, et de le copier dans le presse-papier.
sudo tee /usr/local/bin/mdp << EOF > /dev/null
#!/usr/bin/bash
# Génère un mot de passe aléatoire, l’imprime, et le copie dans le presse-papier
# v1.3

# Générer un mot de passe et compter le nombre de lettres et chiffres
generer_mdp () {
  mdp=\$(printf "\$(date)\${RANDOM}" | md5sum | tr -d o0 | cut -c -8)
  nombre_de_lettres=$(printf "\${mdp}" | tr -d [0-9] | wc -c)
  nombre_de_chiffres=$(printf "\${mdp}" | tr -d [a-z] | wc -c)
}

# Si le mot de passe comporte moins de 2 lettres ou chiffres, en créer un nouveau
while [[ \${nombre_de_lettres} -lt 2 ]] || [[ \${nombre_de_chiffres} -lt 2 ]] ; do
  generer_mdp
done

imprimer_mdp () {
  printf "\${mdp}" | enscript --no-header --font=Ubuntu@20 -d "${nom_de_l_imprimante}"
}

# Nécessaire sur Windows 10 uniquement
redemarrer_cups_wsl () {
  printf "Entrer le mot de passe de l’ordinateur pour démarrer le service d’impression :\n"
  sudo service cups start
  imprimer_mdp
}

case "\${XDG_SESSION_TYPE}" in
  "wayland" )
    generer_mdp
    printf "\${mdp}" | wl-copy --trim-newline
    imprimer_mdp &> /dev/null ;;
  "x11" )
    generer_mdp
    printf "\${mdp}" | xclip -rmlastnl -selection clipboard
    imprimer_mdp &> /dev/null ;;
  * )
    generer_mdp
    printf "\${mdp}" | clip.exe
    imprimer_mdp &> /dev/null || redemarrer_cups_wsl ;;
esac
EOF

# Rendre le script exécutable
sudo chmod 755 /usr/local/bin/mdp
}


creer_application () {
sudo tee /usr/share/applications/mdp.desktop << EOF > /dev/null
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=mdp
Comment=Générer un mot de passe aléatoire, l’imprimer, et le copier dans le presse-papier.
Exec=/usr/local/bin/mdp
Icon=dialog-password-symbolic.svg
Terminal=false
EOF
}


desinstaller_mdp () {
# Supprimer l’exécutable
sudo rm -f /usr/local/bin/mdp
# Supprimer l’application
sudo rm -f /usr/share/applications/mdp.desktop
# Supprimer l’imprimante
sudo lpadmin -x "${nom_de_l_imprimante}" &> /dev/null
printf "$(tput bold)mdp$(tput sgr0) a été désinstallé.\n"
# Si ce script a été lancé avec une option, garder le pilote et désinstaller silencieusement
# sinon, demander quoi faire
if [[ -z "${1}" ]] ; then
  read -p "Désinstaller aussi le pilote de l’imprimante ? [o/N] " oui_non
  if [[ "${oui_non}" == @([oO]|[oO][uU][iI]) ]]  ; then
    sudo rm -f "/usr/share/cups/model/${fichier_ppd}"
    printf "Le pilote de l’imprimante a été désinstallé.\n"
  fi
else
  exit 0
fi
}


expliquer_comment_creer_application_windows () {
cat << EOF
Pour facilement lancer mdp depuis Windows, créer le script « mdp.bat » :
----------- 
@echo off
title mdp
wsl.exe mdp
exit
-----------
Puis ajouter le script au menu Démarrer, en allant dans :
%AppData%\Microsoft\Windows\Start Menu\Programs
Faire un clic droit -> Nouveau -> Raccourci
$(tput bold)Emplacement$(tput sgr0) : cmd.exe /c "\chemin\vers\mdp.bat
$(tput bold)Nom$(tput sgr0) : mdp
Pour changer l’icône, faire un clic droit sur le raccourci -> Propriétés -> Raccourci -> Changer d’icône…
Les icônes systèmes se trouvent dans : %SystemRoot%\System32\imageres.dll
Épingler mdp à la barre des tâches en faisant un clic droit sur son icône dans le menu Démarrer !
EOF
}



###################################
## MENU DE SÉLECTION DES ACTIONS ##
###################################

# Lancer directement l’action si ce script a été lancé avec une option
option="${1}"

# Sinon, afficher le menu
if [[ -z "${1}" ]] ; then
cat << EOF
Installer $(tput bold)mdp$(tput sgr0) pour :
1. Ubuntu, Linux Mint, Debian et dérivés
2. Fedora, CentOS, Red Hat Enterprise Linux, et dérivés
3. WSL (Windows Subsystem for Linux)
                 # # #
4. Je ne sais pas quelle distribution j’utilise
5. Je veux savoir comment ajouter le programme directement à Windows
6. Vérifier la version de mdp installée
7. Désinstaller mdp
EOF
  read -p "Entrer le chiffre correspondant (1/2/3/4/5/6/7) " option
fi

# Lancer l’option sélectionnée
case "${option}" in
  1 )
    installer_prerequis_ubuntu
    installer_pilote
    installer_police_ecriture
    creer_imprimante
    installer_script_mdp
    creer_application
    printf "\nInstallation terminée.\nTaper $(tput bold)mdp$(tput sgr0) dans un terminal ou cliquer sur l’application pour générer un mot de passe, l’imprimer, et le copier dans le presse-papier.\n" ;;
  2 )
    installer_prerequis_fedora
    installer_pilote
    installer_police_ecriture
    creer_imprimante
    installer_script_mdp
    creer_application
    printf "\nInstallation terminée.\nTaper $(tput bold)mdp$(tput sgr0) dans un terminal ou cliquer sur l’application pour générer un mot de passe, l’imprimer, et le copier dans le presse-papier.\n" ;;
  3 )
    installer_prerequis_wsl
    installer_pilote
    installer_police_ecriture
    creer_imprimante
    installer_script_mdp
    expliquer_comment_creer_application_windows ;;
  4 )
    clear
    printf "La distribution installée sur cet ordinateur est :\n"
    cat /etc/*-release 2> /dev/null | grep ^NAME | sed 's/NAME=//' | tr -d \"\'
    printf "\n"
    "${0}" ;;
  5 )
    clear
    expliquer_comment_creer_application_windows ;;
  6 )
    if test -f /usr/local/bin/mdp ; then
      printf "mdp"
      head --lines=3 /usr/local/bin/mdp | tail --lines=+3 | tr -d "#"
    else
      printf "mdp n’est pas installé.\n" >&2
    fi ;;
  7 )
    desinstaller_mdp "${@}" ;;
  * )
    printf "Erreur : option invalide.\n" >&2
    exit 1 ;;
esac
