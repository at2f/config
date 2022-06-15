#!/usr/bin/bash

############################################
## INSTALLATION DU PILOTE DE L’IMPRIMANTE ##
############################################

# Installation de Perl, nécessaire sous CentOS
sudo dnf install -y perl
# Nom du pilote, sans « .tar.gz »
nom_pilote='KMbeuUXv1_24_multi_language'
url_telechargement='https://dl.konicaminolta.eu/fr?tx_kmanacondaimport_downloadproxy[fileId]=79da0f659ac2191cf88560aee21df50d&tx_kmanacondaimport_downloadproxy[documentId]=128230&tx_kmanacondaimport_downloadproxy[system]=KonicaMinolta&tx_kmanacondaimport_downloadproxy[language]=FR&type=1558521685'
## Pour obtenir l’adresse de téléchargement, télécharger l’archive sur le centre
## de téléchargement de Konica Minolta, ouvrir le menu des téléchargements, et
## faire un clic droit sur l’archive, puis sélectionner « Copier l’adresse
## d’origine du téléchargement ».
# Se déplacer dans le répertoire temporaire
( cd "$(mktemp -d)" || exit 1
# Télécharger l’archive des pilotes de l’imprimante
wget -O "${nom_pilote}.tar.gz" "${url_telechargement}"
# Extraire l’archive
tar -xf "${nom_pilote}".tar.gz
# Copier le fichier ppd dans le répertoire de configuration de CUPS
sudo cp "./${nom_pilote}/KMbeuC360iux.ppd" /usr/share/cups/model/
sudo chmod 644 /usr/share/cups/model/KMbeuC360iux.ppd
# Copier les filtres dans le répertoire des filtres de CUPS
sudo cp "./${nom_pilote}/KMbeuEmpPS.pl" /usr/lib/cups/filter/
sudo cp "./${nom_pilote}/KMbeuEnc.pm" /usr/lib/cups/filter/ )
# Redémarrer le service CUPS
sudo systemctl restart cups



##############################
## CRÉATION DES IMPRIMANTES ##
##############################

creer_imprimante () {
sudo lpadmin \
  -p "${nom_de_l_imprimante}" \
  -D "${description_de_l_imprimante}" \
  -L "${emplacement_de_l_imprimante}" \
  -E \
  -v "${uri_imprimante}" \
  -m "${fichier_ppd}" \
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
  -o KMAccPass=${mot_de_passe_imprimante} \
  -o Combination=${combinaison} \
  -o Fold=${pliage}
}

# Paramètres communs
## Lister les options disponibles avec la commande ci-dessous ##
# lpoptions -p $nom_de_l_imprimante -l
# Attention, l’imprimante doit déjà être installée avec le PPD correspondant.
read -rp 'Mot de passe noir & blanc de l’imprimante ? ' mot_de_passe_imprimante_nb
read -rp 'Mot de passe couleur de l’imprimante ? ' mot_de_passe_imprimante_couleur
uri_imprimante='socket://10.11.111.50'
fichier_ppd='KMbeuC360iux.ppd'
emplacement_de_l_imprimante='Cyber-Base'
# Options installées
sources_papier='PC416'
unite_de_finition='FS536'
unite_de_perforation='None'
kit_couture='SD511'
storage='HDD'
modele='C250i'
# Account Track
suivi_de_volume_ekc='True'


### NOIR RECTO/VERSO ###
## Options de l’imprimante ##
nom_de_l_imprimante='1_Noir_Recto_Verso' # Max 127 caractères, pas de caractères spéciaux ni d’espaces
description_de_l_imprimante='1 Noir Recto/Verso'
# General
format_papier='A4'
# Finishing Options
type_d_impression='2Sided' # 1Sided = recto | 2Sided = recto/verso
combinaison='None' # Options possibles : None Booklet
pliage='None' # Options possibles : None Stitch HalfFold TriFold
# Quality
selectionner_couleur='Grayscale' # Options possibles : Auto Color Grayscale
image_quality_setting='Document' # Options possibles : Document-Photo Document Photo CAD
# Account Track
mot_de_passe_imprimante="Custom.${mot_de_passe_imprimante_nb}" # Options possibles : None Custom.$mot_de_passe_imprimante_couleur Custom.$mot_de_passe_imprimante_nb
creer_imprimante

### NOIR RECTO ###
## Options de l’imprimante ##
nom_de_l_imprimante='2_Noir_Recto' # Max 127 caractères, pas de caractères spéciaux ni d’espaces
description_de_l_imprimante='2 Noir Recto'
# General
format_papier='A4'
# Finishing Options
type_d_impression='1Sided' # 1Sided = recto | 2Sided = recto/verso
combinaison='None' # Options possibles : None Booklet
pliage='None' # Options possibles : None Stitch HalfFold TriFold
# Quality
selectionner_couleur='Grayscale' # Options possibles : Auto Color Grayscale
image_quality_setting='Document' # Options possibles : Document-Photo Document Photo CAD
# Account Track
mot_de_passe_imprimante="Custom.${mot_de_passe_imprimante_nb}" # Options possibles : None Custom.$mot_de_passe_imprimante_couleur Custom.$mot_de_passe_imprimante_nb
creer_imprimante

### COULEUR RECTO/VERSO ###
## Options de l’imprimante ##
nom_de_l_imprimante='3_Couleur_Recto_Verso' # Max 127 caractères, pas de caractères spéciaux ni d’espaces
description_de_l_imprimante='3 Couleur Recto/Verso'
# General
format_papier='A4'
# Finishing Options
type_d_impression='2Sided' # 1Sided = recto | 2Sided = recto/verso
combinaison='None' # Options possibles : None Booklet
pliage='None' # Options possibles : None Stitch HalfFold TriFold
# Quality
selectionner_couleur='Auto' # Options possibles : Auto Color Grayscale
image_quality_setting='Document-Photo' # Options possibles : Document-Photo Document Photo CAD
# Account Track
mot_de_passe_imprimante="Custom.${mot_de_passe_imprimante_couleur}" # Options possibles : None Custom.$mot_de_passe_imprimante_couleur Custom.$mot_de_passe_imprimante_nb
creer_imprimante

### COULEUR RECTO ###
## Options de l’imprimante ##
nom_de_l_imprimante='4_Couleur_Recto' # Max 127 caractères, pas de caractères spéciaux ni d’espaces
description_de_l_imprimante='4 Couleur Recto'
# General
format_papier='A4'
# Finishing Options
type_d_impression='1Sided' # 1Sided = recto | 2Sided = recto/verso
combinaison='None' # Options possibles : None Booklet
pliage='None' # Options possibles : None Stitch HalfFold TriFold
# Quality
selectionner_couleur='Auto' # Options possibles : Auto Color Grayscale
image_quality_setting='Document-Photo' # Options possibles : Document-Photo Document Photo CAD
# Account Track
mot_de_passe_imprimante="Custom.${mot_de_passe_imprimante_couleur}" # Options possibles : None Custom.$mot_de_passe_imprimante_couleur Custom.$mot_de_passe_imprimante_nb
creer_imprimante

### LIVRET A4 COULEUR ###
## Options de l’imprimante ##
nom_de_l_imprimante='5_Livret_Couleur' # Max 127 caractères, pas de caractères spéciaux ni d’espaces
description_de_l_imprimante='5 Livret Couleur'
# General
format_papier='A4'
# Finishing Options
type_d_impression='1Sided' # 1Sided = recto | 2Sided = recto/verso
combinaison='Booklet' # Options possibles : None Booklet
pliage='Stitch' # Options possibles : None Stitch HalfFold TriFold
# Quality
selectionner_couleur='Color' # Options possibles : Auto Color Grayscale
image_quality_setting='Document-Photo' # Options possibles : Document-Photo Document Photo CAD
# Account Track
mot_de_passe_imprimante="Custom.${mot_de_passe_imprimante_couleur}" # Options possibles : None Custom.$mot_de_passe_imprimante_couleur Custom.$mot_de_passe_imprimante_nb
creer_imprimante

### LIVRET A5 NOIR & BLANC ###
## Options de l’imprimante ##
nom_de_l_imprimante='6_Livret_Noir' # Max 127 caractères, pas de caractères spéciaux ni d’espaces
description_de_l_imprimante='6 Livret Noir'
# General
format_papier='A4'
# Finishing Options
type_d_impression='1Sided' # 1Sided = recto | 2Sided = recto/verso
combinaison='Booklet' # Options possibles : None Booklet
pliage='Stitch' # Options possibles : None Stitch HalfFold TriFold
# Quality
selectionner_couleur='Grayscale' # Options possibles : Auto Color Grayscale
image_quality_setting='Document' # Options possibles : Document-Photo Document Photo CAD
# Account Track
mot_de_passe_imprimante="Custom.${mot_de_passe_imprimante_nb}" # Options possibles : None Custom.$mot_de_passe_imprimante_couleur Custom.$mot_de_passe_imprimante_nb
creer_imprimante
