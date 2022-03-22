#!/usr/bin/bash

### À rajouter pour la prochaine version ###
# Les scripts Rassembler les images sélectionnées dans un PDF & Compresser et aplatir les PDFs sélectionnés & Rogner les images sélectionnées
# Désactiver les notifications pour Ubuntu Pro




###################
### PRÉPARATION ###
###################


### Avant tout, faire une installation minimale de Ubuntu 20.04 Desktop
### Créer un utilisateur « administrateur » (/!\ le nom est important, ne pas en mettre un autre !)
### Ensuite, placer ce script, ainsi que les fichiers l’accompagnant dans le répertoire personnel de administrateur (/home/administrateur/)
### Enfin, lancer le script dans un terminal avec la commande suivante :
### sh ./installation_pc_cyber-base.sh




##############################
### CONFIGURATION MANUELLE ###
##############################


## Lancer l’application « Pilotes additionnels » pour rechercher si des pilotes propriétaires supplémentaires sont nécessaires, et les installer si disponibles.


## Activer le verouillage numérique s’il ne l’est pas déjà.


## LibreOffice
# Désactiver les conseils au démarrage de LibreOffice
# Activer l’interface en onglets pour tous les logiciels de la suite : Affichage -> Interface utilisateur -> Onglets


## Firefox
# Ajouter le bouton « Prendre une capture d’écran » à la barre d’outils
# Mettre à jour les filtres uBlock Origin


## Configuration des DNS « Cloudflare for families » (ignorer cette section si la solution Téïcée ProxyEPN + Tic'nCube est déployée
# Paramètres -> Réseau -> Filaire :
# IPv4 -> DNS : 1.1.1.3,1.0.0.3
# IPv6 -> DNS : 2606:4700:4700::1113,2606:4700:4700::1003
# Plus de renseignements à cette adresse https://community.cloudflare.com/t/community-tip-best-practices-for-1-1-1-1-for-families/160496


## Finaliser la configuration
# Une fois que la configuration manuelle est faite, redémarrer et lancer le script de maintenance manuelle pour synchroniser les modifications.




###################################################
### ENTRETIEN DES POSTES & VEILLE TECHNOLOGIQUE ###
###################################################


### Penser à exécuter le script au moins une fois par semaine pour mettre à jour le système et synchroniser la session Usager.
### Pour cela, lancer Firefox, mettre à jour les filtres uBlock Origin, puis fermer toutes les fenêtres, ouvrir le terminal et taper :
### ./maintenance_manuelle_hebdomadaire.sh


## Configurer les paramètres d’entreprise de Firefox
# Surveiller l’évolution des options de configuration à cette adresse : https://github.com/mozilla/policy-templates
# Lorsque des choses doivent être modifiées, le faire sur GitHub : https://github.com/at2f/config/blob/main/cyber-base/etc/firefox/policies/policies.json
# Le script de maintenance hebdomadaire téléchargera et installera la nouvelle version


## Vérifier régulièrement les nouvelles versions de Grammalecte pour LibreOffice : https://grammalecte.net/#download


## Configurer les paramètres d’entreprise de uBlock Origin
# Ouvrir les paramètres de uBlock Origin, régler selon les besoins, puis « Exporter vers un fichier »
# Copier/coller le contenu du fichier dans http://raymondhill.net/ublock/adminSetting.html
# Convertir et récupérer le contenu de « JSON-encoded settings to be used for adminSettings as a JSON string value »
# Coller le contenu à la suite de « "adminSettings": » dans https://github.com/at2f/config/blob/main/cyber-base/usr/lib/mozilla/managed-storage/uBlock0%40raymondhill.net.json (/!\ Attention aux guillemets !)
# Le script de maintenance hebdomadaire téléchargera et installera la nouvelle version


## Documentation
# Paramètres d’entreprises de Firefox en français (très succin) : about:policies#documentation
# Bloquer les comportements gênants de certains site (par ex : acceptation des cookies systématique sur Google) avec uBlock Origin : https://www.reddit.com/r/uBlockOrigin/wiki/solutions
# Paramètres d’entreprise de uBlock Origin : https://github.com/gorhill/uBlock/wiki/Deploying-uBlock-Origin
# Paramètres des manifests de gestion de stockage de Firefox : https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions/Native_manifests#manifest_de_gestion_de_stockage
# Emplacement des manifests de gestion de stockage de Firefox : https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions/Native_manifests#linux




#################################
### CONFIGURATION AUTOMATIQUE ###
#################################


## Explorateur de fichiers ##
# Cacher le répertoire « snap » situé dans le dossier home
grep -qx snap ~/.hidden &> /dev/null || echo snap >> ~/.hidden
# Supprime le répertoire « Public »
rmdir ~/Public
# Toujours afficher les vignettes d’aperçu des images/documents (y compris sur les périphériques externes)
gsettings set org.gnome.nautilus.preferences show-image-thumbnails always
# Afficher les vignettes pour les documents faisant 4 Go au maximum (au lieu de 512 Mo par défaut)
gsettings set org.gnome.nautilus.preferences thumbnail-limit 4096
# Lors d’une recherche, chercher dans les sous-dossiers également
gsettings set org.gnome.nautilus.preferences recursive-search always
# Toujours afficher le nombre de fichiers dans un dossier
gsettings set org.gnome.nautilus.preferences show-directory-item-counts always
# En mode liste, afficher les colonnes Nom, Taille, Type, Dernière modification, et Favori
gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'date_modified', 'starred']"


## Gestionnaire de paquets ##
# Désactiver les notifications de nouvelles mises à jour
gsettings set com.ubuntu.update-notifier no-show-notifications true
gsettings set com.ubuntu.update-notifier regular-auto-launch-interval 14
# Désactiver les mises à jour automatiques
sudo sed -i 's/"1"/"0"/g' /etc/apt/apt.conf.d/20auto-upgrades
# Activer les dépots partenaires Canonical
sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
# Mettre à jour la liste des paquets disponibles
sudo apt update
# Mettre à jour les paquets
sudo apt upgrade -y
# Installer les paquets propriétaires (codecs multimédias, pilotes wi-fi, etc.)
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
sudo apt install -y ubuntu-restricted-extras
# Installer le support des DVD
sudo DEBIAN_FRONTEND=noninteractive apt install -y libdvd-pkg
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure libdvd-pkg
# Installer le gestionnaire de tâches htop
sudo apt install -y htop
# Installer LibreOffice
sudo apt install -y libreoffice
# Installer le lecteur multimédia Celluloid
sudo apt install -y celluloid
# Installer GIMP
sudo apt install -y gimp
# Installer les paquets de traduction manquants
sudo apt install -y $(check-language-support)
# Supprimer quelques paquets inutiles pour les postes publics
sudo apt purge -y whoopsie apport ubuntu-report popularity-contest
# Supprimer les paquets obsolètes
sudo apt autoremove -y


## Interface ##
# Activer le fuseau horaire automatique
gsettings set org.gnome.desktop.datetime automatic-timezone true
# Afficher le jour de la semaine dans l’horloge
gsettings set org.gnome.desktop.interface clock-show-weekday true
# Désactiver l’historique d’utilisation des applications
gsettings set org.gnome.desktop.privacy remember-app-usage false
# Désactiver la possibilité de verrouiller l’écran
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
# Désactiver la possibilité de se déconnecter
gsettings set org.gnome.desktop.lockdown disable-log-out true
# Désactiver la possibilité de changer d’utilisateur
gsettings set org.gnome.desktop.lockdown disable-user-switching true
# Désactiver la mise en veille
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
# Ne rien faire lorsque le bouton d’alimentation est enfoncé
gsettings set org.gnome.settings-daemon.plugins.power power-button-action nothing
# Désactiver le verrouillage de la session lors de l’économie d’écran
gsettings set org.gnome.desktop.screensaver lock-enabled false
# Régler le nombre d’espaces de travail sur le mode fixe
gsettings set org.gnome.mutter dynamic-workspaces false
# Régler le nombre d’espaces de travail à 1
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
# Activer le verrouillage numérique
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true
# Se souvenir de l’état du verrouillage numérique à l’ouverture de la session
gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true
# Créer le bouton d’extinction
sudo tee /usr/share/applications/eteindre.desktop << EOF > /dev/null
[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Éteindre
Comment=Éteindre et fermer la session.
Exec=/usr/local/bin/eteindre.sh
Icon=system-shutdown-symbolic.svg
Terminal=true
EOF
# Télécharger le script d’extinction des postes
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/usr/local/bin/eteindre.sh
# Installer le script
sudo cp eteindre.sh /usr/local/bin/
rm eteindre.sh
# Rendre le script exécutable
sudo chmod 755 /usr/local/bin/eteindre.sh
# Télécharger le fond d’écran
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/home/dot_local/share/backgrounds/fond_ecran_postes_usagers_cyber-base.png
# Crée le répertoire des fonds d’écran
mkdir ~/.local/share/backgrounds
# Envoyer le fond d’écran dans ~/.local/share/backgrounds
cp fond_ecran_postes_usagers_cyber-base.png ~/.local/share/backgrounds/
rm fond_ecran_postes_usagers_cyber-base.png
# Changer le fond d’écran
gsettings set org.gnome.desktop.background picture-uri ~/.local/share/backgrounds/fond_ecran_postes_usagers_cyber-base.png
# Définir les favoris dans « Dash to Dock » (barre latérale)
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'libreoffice-startcenter.desktop', 'eteindre.desktop']"


## Sécurité & confidentialité ##
# Activer le pare-feu
sudo ufw enable
# Supprimer les fichiers temporaires & dans la corbeille chaque jour
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy old-files-age 1
# Supprimer les fichiers récents chaque jour
gsettings set org.gnome.desktop.privacy recent-files-max-age 1
# Désactiver l’envoi des statistiques d’usage des logiciels
gsettings set org.gnome.desktop.privacy send-software-usage-stats false


## Performances ##
# Augmenter la taille du swap à 4 Go
sudo swapoff /swapfile
sudo rm /swapfile
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile


## Bureau ##
# Ne pas afficher le dossier personnel sur le bureau
gsettings set org.gnome.shell.extensions.desktop-icons show-home false
# Ne pas afficher la corbeille sur le bureau
gsettings set org.gnome.shell.extensions.desktop-icons show-trash false
# Ne pas afficher le bureau dans les raccourcis
gsettings set org.gnome.desktop.background show-desktop-icons false
## À faire pour se débarasser complètement du Bureau :
# Désactiver l’extension du bureau
#gsettings set org.gnome.shell disabled-extensions "['desktop-icons@csoriano']"
# Supprimer le répertoire « Bureau »
#rmdir ~/Bureau
## Les commandes suivantes ne semblent pas nécessaires, mais pourraient le devenir :
# Désactiver la création automatique d’un répertoire « Bureau »
#sudo sed -i '/^DESKTOP/s/^/#/' /etc/xdg/user-dirs.defaults
#sed -i '/^XDG_DESKTOP/s/^/#/' ~/.config/user-dirs.dirs


## Téïcée ##
# Installer le navigateur web en ligne de commande Lynx, nécessaire pour déconnecter les usagers à l’extinction du poste via le script « eteindre.sh »
sudo apt install -y lynx
# Régler le problème de fenêtre intempestive avec le filtrage réseau Téïcée
sudo tee -a /etc/NetworkManager/NetworkManager.conf << EOF > /dev/null

[connectivity]
enabled=false
EOF


## Firefox ##
notify-send --hint int:transient:1 "LibreOffice" "Installer Grammalecte pour LibreOffice, puis fermer Firefox."
printf "%s\n" "Installer Grammalecte pour LibreOffice, puis fermer Firefox."
# Ouvrir Firefox sur la page de téléchargement de Grammalecte pour LibreOffice
firefox https://grammalecte.net/#download &
# Attendre que Firefox soit fermé avant de continuer
wait $(pidof firefox)
# Identifier le répertoire du profil principal de Firefox
fichier_preferences="$(find ${HOME}/.mozilla/firefox -iname *default-release*)/prefs.js"
# Définir les préférences à modifier
preferences=(
  # Désactiver l’extension Pocket
  'user_pref("extensions.pocket.enabled", false);'
  # Utiliser les paramètres du système d’exploitation pour la locale
  'user_pref("intl.regional_prefs.use_os_locales", true);'
  # Désépingler les moteurs de recherche
  'user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned", "amazon");'
  # Ne pas afficher les raccourcis sponsorisés dans les nouveaux onglet
  'user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);'
  # Protection renforcée contre le pistage = Standard
  'user_pref("browser.contentblocking.category", standard);'
  # Autoriser Firefox à envoyer des rapports de plantage en attente en votre nom
  'user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", true);'
  # Ne pas afficher la barre de titre
  'user_pref("browser.tabs.inTitlebar", 1);'
  # Désépingler les raccourcis dans les nouveaux onglets
  #'user_pref("browser.newtabpage.pinned", []);'
)
# Vérifier chaque paramètre un à un
for ligne in "${preferences[@]}" ; do
  # Enregistrer l’intitulé nu des paramètres dans la variable « option »
  option=$(printf "${ligne}" | cut -d'"' -f2)
  # Chercher quelles options existent déjà dans le fichier de configuration
  option_existe=$(grep -sc "${option}" "${fichier_preferences}")
  # Si une option existe déjà, alors remplacer la ligne…
  if [[ "${option_existe}" -ne 0 ]] ; then
    sed -i 's/*${option}*/${ligne}/' "${fichier_preferences}"
    # … sinon, la créer
  else
    echo "${ligne}" >> "${fichier_preferences}"
  fi
done
# Enlever le bouton « Importer les marques-pages d’un autre navigateur dans Firefox. »
sed -i 's/\\"import-button\\",//' "${fichier_preferences}"
# Désépingler les raccourcis dans les nouveaux onglets
sed -i 's/browser.newtabpage.pinned//' "${fichier_preferences}"
# Télécharger un modèle préconfiguré pour les paramètres d’entreprise
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/etc/firefox/policies/policies.json
# Créer le répertoire de destination
sudo mkdir /etc/firefox/policies
# Installer le fichier de configuration
sudo cp policies.json /etc/firefox/policies/
rm policies.json
# Créer le répertoire de configuration des addons Firefox (manifest de gestion de stockage)
sudo mkdir -p /usr/lib/mozilla/managed-storage
# Télécharger le fichiers de configuration de uBlock Origin
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/usr/lib/mozilla/managed-storage/uBlock0%40raymondhill.net.json
# Installer le fichier de configuration de uBlock Origin
sudo cp uBlock0@raymondhill.net.json /usr/lib/mozilla/managed-storage/
rm uBlock0@raymondhill.net.json


## Configuration de l’imprimante ##
# Télécharger l’archive des pilotes de l’imprimante
wget -O "KMbeuUXv1_24_multi_language.tar.gz" "https://dl.konicaminolta.eu/fr?tx_kmanacondaimport_downloadproxy[fileId]=79da0f659ac2191cf88560aee21df50d&tx_kmanacondaimport_downloadproxy[documentId]=128230&tx_kmanacondaimport_downloadproxy[system]=KonicaMinolta&tx_kmanacondaimport_downloadproxy[language]=FR&type=1558521685"
# Extraire l’archive
tar -xf KMbeuUXv1_24_multi_language.tar.gz
# Rentrer dans le répertoire des pilotes
cd KMbeuUXv1_24_multi_language/
# Copier le fichier ppd dans le répertoire de configuration de CUPS
sudo cp KMbeuC360iux.ppd /usr/share/cups/model/
# Copier les filtres dans le répertoire des filtres de CUPS
sudo cp KMbeuEmpPS.pl /usr/lib/cups/filter/
sudo cp KMbeuEnc.pm /usr/lib/cups/filter/
# Revenir au dossier parent
cd ..
# Nettoyer les fichiers
rm -r KMbeuUXv1_24_multi_language*
# Redémarrer le service de cups
sudo systemctl restart cups


## Création du compte usager ##
# Créer un utilisateur « usager » dont le /home se trouve sur un tmpfs
sudo useradd -m -d /dev/shm/usager -s /bin/bash usager
# Supprimer le mot de passe de l’utilisateur usager
sudo passwd -d usager
# Créer le service pour recréer automatiquement le home de usager au démarrage de l’ordinateur
sudo tee /etc/systemd/system/mkhomedir_helper.service << EOF > /dev/null
[Unit]
Description=Lance le service mkhomedir_helper pour créer un répertoire home pour usager à partir du modèle skel.

[Service]
ExecStart=/usr/sbin/mkhomedir_helper usager

[Install]
WantedBy=graphical.target
EOF
# Lancer le service
sudo systemctl enable --now mkhomedir_helper


## Configuration du partage Samba pour le répertoire de destination des scans ##
# Créer le répertoire « Scans »
sudo mkdir /mnt/Scans
# Changer le propriétaire du répertoire vers l’utilisateur usager
sudo chown -R usager:usager /mnt/Scans
# Ajouter un raccourci vers le répertoire Scans dans le /home
ln -s /mnt/Scans ~
# Monter /mnt/Scans dans un tmpfs au démarrage
echo 'tmpfs           /mnt/Scans      tmpfs   defaults,users,size=100M                  0       0' | sudo tee -a /etc/fstab > /dev/null
# Installer SAMBA
sudo apt install -y samba
# Autoriser Samba dans le pare-feu
sudo ufw allow samba
# Ajouter l’utilisateur usager au groupe sambashare
sudo usermod -aG sambashare usager
# Autoriser les utilisateurs à créer des partages même s’ils ne sont pas propriétaires du répertoire
sudo sed -i '/\[global\]/a usershare owner only = false' /etc/samba/smb.conf
# Créer le fichier de configuration de partage du répertoire Scans
sudo tee /var/lib/samba/usershares/scans << EOF > /dev/null
#VERSION 2
path=/mnt/Scans
comment=
usershare_acl=S-1-1-0:F
guest_ok=y
sharename=Scans
EOF
# Changer le propriétaire du fichier de configuration vers l’utilisateur usager
sudo chown usager:usager /var/lib/samba/usershares/scans


## Création du « skel », modèle de création du /home de usager ##
# Créer la liste des fichiers & répertoires à ne pas synchroniser
cat << EOF > rsync_ignorer
.bash_history
.cache
.lock
.ssh
.sudo_as_admin_successful
bookmarks
maintenance_manuelle_hebdomadaire.sh
rsync_ignorer
sessionstore-backups
Trash
EOF
# Synchroniser les fichiers du répertoire /home/administrateur dans /etc/skel
sudo rsync -avz --delete --exclude-from=rsync_ignorer /home/administrateur/ /etc/skel


## Création du script de maintenance hebdomadaire À LANCER AU MOINS UNE FOIS PAR SEMAINE ! ##
# Créer le script
cat << EOF > maintenance_manuelle_hebdomadaire.sh
#!/bin/bash
# Synchroniser la liste des paquets
sudo apt update
# Télécharger et mettre à jour les paquets
sudo apt upgrade -y
# Supprimer les paquets obsolètes
sudo apt autoremove -y
# Mettre à jour les snaps
sudo snap refresh
# Télécharger le fichier de configuration de Firefox
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/etc/firefox/policies/policies.json
# Installer le fichier de configuration de Firefox
sudo cp policies.json /etc/firefox/policies/
rm policies.json
# Télécharger le fichier de configuration de uBlock Origin
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/usr/lib/mozilla/managed-storage/uBlock0%40raymondhill.net.json
# Installer le fichier de configuration de uBlock Origin
sudo cp uBlock0@raymondhill.net.json /usr/lib/mozilla/managed-storage/
rm uBlock0@raymondhill.net.json
# Ouvrir la page des filtres de uBlock Origin pour les mettre à jour
notify-send --hint int:transient:1 'Vider le cache et mettre à jour les filtres de uBlock Origin.'
firefox moz-extension://153f4b36-279b-47d1-a5e7-f7e8a09dc7e4/dashboard.html#3p-filters.html
# Attendre que Firefox soit fermé avant de continuer
wait $(pidof firefox)
# Synchroniser le répertoire skel
sudo rsync -avz --delete --exclude-from=rsync_ignorer /home/administrateur/ /etc/skel
EOF
# Rendre le script exécutable
chmod 755 maintenance_manuelle_hebdomadaire.sh
# Lancer le script
bash ./maintenance_manuelle_hebdomadaire.sh
