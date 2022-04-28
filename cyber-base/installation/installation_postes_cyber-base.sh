#!/usr/bin/bash

###################
### PRÉPARATION ###
###################

### Avant tout, faire une installation minimale de Ubuntu 22.04 Desktop
### Créer un utilisateur « administrateur »
### Ensuite, placer ce script, ainsi que les fichiers l’accompagnant dans le répertoire personnel de administrateur (/home/administrateur/)
### Enfin, lancer le script dans un terminal avec la commande suivante :
### bash ./installation_pc_cyber-base.sh



###################################################
### ENTRETIEN DES POSTES & VEILLE TECHNOLOGIQUE ###
###################################################

## Penser à exécuter le script au moins une fois par semaine pour mettre à jour le système et synchroniser la session Usager.
## Pour cela, lancer Firefox, mettre à jour les filtres uBlock Origin, puis fermer toutes les fenêtres, ouvrir le terminal et taper :
## ./maintenance_manuelle_hebdomadaire.sh


## Si des modifications doivent être faites, les rajouter sur GitHub, dans le fichier corrections.sh : https://github.com/at2f/config/blob/main/cyber-base/corrections.sh


## Configurer les paramètres d’entreprise de Firefox
# Surveiller l’évolution des options de configuration à cette adresse : https://github.com/mozilla/policy-templates
# Lorsque des choses doivent être modifiées, le faire sur GitHub : https://github.com/at2f/config/blob/main/cyber-base/policies.json
# Le script de maintenance hebdomadaire téléchargera et installera la nouvelle version


## Vérifier régulièrement les nouvelles versions de Grammalecte pour LibreOffice : https://grammalecte.net/#download


## Configurer les paramètres d’entreprise de uBlock Origin
# Ouvrir les paramètres de uBlock Origin, régler selon les besoins, puis « Exporter vers un fichier »
# Copier/coller le contenu du fichier dans http://raymondhill.net/ublock/adminSetting.html
# Convertir et récupérer le contenu de « JSON-encoded settings to be used for adminSettings as a JSON string value »
# Coller le contenu à la suite de « "adminSettings": » dans https://github.com/at2f/config/blob/main/cyber-base/uBlock0%40raymondhill.net.json (/!\ Attention aux guillemets !)
# Le script de maintenance hebdomadaire téléchargera et installera la nouvelle version


## Documentation
# Paramètres d’entreprises de Firefox en français (très succint) : about:policies#documentation
# Bloquer les comportements gênants de certains site (par ex : acceptation des cookies systématique sur Google) avec uBlock Origin : https://www.reddit.com/r/uBlockOrigin/wiki/solutions
# Paramètres d’entreprise de uBlock Origin : https://github.com/gorhill/uBlock/wiki/Deploying-uBlock-Origin
# Paramètres des manifests de gestion de stockage de Firefox : https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions/Native_manifests#manifest_de_gestion_de_stockage
# Emplacement des manifests de gestion de stockage de Firefox : https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions/Native_manifests#linux
# Installer Firefox manuellement : https://ftp.mozilla.org/pub/firefox/releases/latest/README.txt



#################################
### CONFIGURATION AUTOMATIQUE ###
#################################

# Créer un répertoire temporaire et s’y déplacer
cd $(mktemp -d)



# Créer le mot de passe du partage SAMBA
read -rp 'Entrer le mot de passe du partage SAMBA pour recevoir les scans : ' mdp_samba



## Gestionnaire de paquets ##
# Désactiver les notifications de nouvelles mises à jour
gsettings set com.ubuntu.update-notifier no-show-notifications true
# Désactiver les mises à jour automatiques
sudo sed -i 's/"1"/"0"/g' /etc/apt/apt.conf.d/20auto-upgrades
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
# En mode liste, afficher les colonnes Nom, Taille, Type, et Dernière modification
gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'date_modified']"
## Ajouter des scripts au menu contextuel de l’explorateur de fichiers
# Créer le répertoire
mkdir -p ~/.local/share/nautilus/scripts/
# Télécharger et installer les scripts
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/scripts_nautilus/Compresser%20et%20aplatir%20les%20PDFs%20s%C3%A9lectionn%C3%A9s
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/scripts_nautilus/Rassembler%20les%20images%20s%C3%A9lectionn%C3%A9es%20dans%20un%20PDF
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/scripts_nautilus/Rogner%20les%20contours%20des%20images%20s%C3%A9lectionn%C3%A9es
cp 'Compresser et aplatir les PDFs sélectionnés' ~/.local/share/nautilus/scripts/
cp 'Rassembler les images sélectionnées dans un PDF' ~/.local/share/nautilus/scripts/
cp 'Rogner les contours des images sélectionnées' ~/.local/share/nautilus/scripts/
# Les rendre exécutables
chmod +x ~/.local/share/nautilus/scripts/*



## Interface ##
# Ouvrir les nouvelles fenêtres au centre de l’écran
gsettings set org.gnome.mutter center-new-windows true
# Activer le fuseau horaire automatique
gsettings set org.gnome.desktop.datetime automatic-timezone true
# Afficher le jour de la semaine dans l’horloge
gsettings set org.gnome.desktop.interface clock-show-weekday true
# Désactiver l’historique d’utilisation des applications
gsettings set org.gnome.desktop.privacy remember-app-usage false
# Désactiver la possibilité de verrouiller l’écran
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
# Désactiver la mise en veille
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
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
Comment=Éteindre l’ordinateur.
Exec=/usr/local/bin/eteindre.sh
Icon=system-shutdown-symbolic.svg
Terminal=true
EOF
# Télécharger le script d’extinction des postes
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/eteindre.sh
# Installer le script
sudo cp -f eteindre.sh /usr/local/bin/
# Rendre le script exécutable
sudo chmod 755 /usr/local/bin/eteindre.sh
# Télécharger le fond d’écran
wget https://github.com/at2f/config/raw/main/cyber-base/fond_ecran_postes_usagers_cyber-base.png
# Créer le répertoire des fonds d’écrans
sudo mkdir -p /usr/share/backgrounds
# Copier le fond d’écran dans /usr/share/backgrounds
sudo cp fond_ecran_postes_usagers_cyber-base.png /usr/share/backgrounds/
# Changer le fond d’écran
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/fond_ecran_postes_usagers_cyber-base.png
# Définir les favoris dans « Dash to Dock » (barre latérale)
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'libreoffice-startcenter.desktop', 'eteindre.desktop']"
# Ne pas afficher le dossier personnel sur le bureau
gsettings set org.gnome.shell.extensions.ding show-home false
# Ne pas afficher le bureau dans les raccourcis
gsettings set org.gnome.desktop.background show-desktop-icons false



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



## Téïcée ##
# Installer le navigateur web en ligne de commande Lynx, nécessaire pour déconnecter les usagers à l’extinction du poste via le script « eteindre.sh »
sudo apt install -y lynx
# Créer le script de déconnexion du compte Téïcée
sudo tee /usr/local/sbin/deconnexion_teicee.sh << EOF > /dev/null
#!/usr/bin/bash

# Liste les liens existants sur la page de connexion Téïcée
lynx -listonly -nonumbers -dump https://at2f.ticncube.com |\\
# Filtre les liens pour ne garder que celui vers le bouton de déconnexion
grep logout |\\
# Ouvre le lien du bouton de déconnexion avec lynx, et cache la sortie avec nohup
nohup lynx -dump -accept_all_cookies - &> /dev/null &
# Ajouter un délai pour laisser le temps à lynx d’atteindre la page de déconnexion
sleep 5
EOF
# Rendre le script exécutable
sudo chmod 755 /usr/local/sbin/deconnexion_teicee.sh
# Créer le service qui lancera le script de déconnexion à l’extinction de l’ordinateur
sudo After=network.targettee /etc/systemd/system/deconnexion_teicee.service << EOF > /dev/null
[Unit]
Description=Lance le script de déconnexion du compte Téïcée
After=network.target

[Service]
Type=oneshot
RemainAfterExit=true
ExecStop=/usr/local/sbin/deconnexion_teicee.sh

[Install]
WantedBy=multi-user.target
EOF
# Démarrer le service
sudo systemctl enable deconnexion_teicee
# Régler le problème de fenêtre intempestive avec le filtrage réseau Téïcée
sudo tee -a /etc/NetworkManager/NetworkManager.conf << EOF > /dev/null

[connectivity]
enabled=false
EOF



## Firefox ##
# Supprimer le snap de Firefox
sudo snap remove firefox
# Télécharger la dernière version de Firefox
wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=fr"
# Extraire l’archive
tar -xjvf firefox.tar.bz2
# Créer le répertoire de Firefox
sudo mkdir -p /usr/local/bin/Firefox
# Mettre à jour Firefox
sudo rsync -av --delete ./firefox/* /usr/local/bin/Firefox/
# Changer le propriétaire du répertoire vers l’utilisateur root
sudo chown -R root:root /usr/local/bin/Firefox
# Créer un lien symbolique pour pouvoir lancer Firefox depuis un Terminal
sudo ln -s /usr/local/bin/Firefox/firefox-bin /usr/local/bin/firefox
# Télécharger le fichier d’application
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/firefox/firefox.desktop
# Installer le fichier d’application
sudo cp firefox.desktop /usr/share/applications/
# Définir Firefox comme navigateur par défaut
xdg-settings set default-web-browser firefox.desktop
# Ouvrir Firefox sur la page de téléchargement de Grammalecte pour LibreOffice
firefox https://grammalecte.net/#download &
notify-send --hint int:transient:1 'LibreOffice - Grammalecte' 'Installer Grammalecte pour LibreOffice, puis fermer Firefox.'
printf "Installer Grammalecte pour LibreOffice, puis fermer Firefox."
# Attendre que Firefox soit fermé avant de continuer
wait $(pidof firefox)
# Supprimer le fichier d’installation de Grammalecte
rm -f ~/Téléchargements/Grammalecte*
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
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/firefox/policies.json
# Créer le répertoire de destination
sudo mkdir -p /etc/firefox/policies
# Installer le fichier de configuration
sudo cp policies.json /etc/firefox/policies/
# Créer le répertoire de configuration des addons Firefox (manifest de gestion de stockage)
sudo mkdir -p /usr/lib/mozilla/managed-storage
# Télécharger le fichiers de configuration de uBlock Origin
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/firefox/uBlock0%40raymondhill.net.json
# Installer le fichier de configuration de uBlock Origin
sudo cp uBlock0@raymondhill.net.json /usr/lib/mozilla/managed-storage/



## Configuration manuelle ##
notify-send --hint int:transient:1 'LibreOffice' 'Activer l’interface en onglets pour tous les logiciels de la suite : Affichage -> Interface utilisateur -> Onglets'
libreoffice --writer
wait $(pidof libreoffice)
notify-send --hint int:transient:1 'Firefox' 'Ajouter le bouton de capture d’écran à la barre d’outils & vérifier le moteur de recherche.'
firefox about:preferences#search
wait $(pidof firefox)



## Création du compte usager ##
# Créer un utilisateur « usager » dont le /home se trouve sur un tmpfs
sudo useradd usager -m -d /dev/shm/usager -c Usager -s /bin/bash
# Générer un mot de passe aléatoire
mdp_usager=$(printf "$(date)${RANDOM}" | md5sum | cut -d' ' -f1)
# Assigner ce mot de passe
echo "$usager:${mdp_usager}" | chpasswd
# Activer la connexion automatique
sudo sed -i 's/.*AutomaticLoginEnable =.*/AutomaticLoginEnable = true/' /etc/gdm3/custom.conf
sudo sed -i 's/.*AutomaticLogin =.*/AutomaticLogin = usager/' /etc/gdm3/custom.conf
# Interdire le changement de mots de passe pour tout le monde sauf root
sudo chmod u-s /usr/bin/passwd
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
# Installer SAMBA
sudo apt install -y samba
# Autoriser Samba dans le pare-feu
sudo ufw allow samba
# Ajouter l’utilisateur usager au groupe sambashare
sudo usermod -aG sambashare usager
# Assigner le mot de passe « choson » au compte SAMBA « usager »
echo -ne "${mdp_samba}\n${mdp_samba}\n" | sudo smbpasswd -as usager
# Créer le répertoire « Scans »
mkdir -p ~/Scans
# Autoriser les utilisateurs à créer des partages même s’ils ne sont pas propriétaires du répertoire
#sudo sed -i '/\[global\]/a usershare owner only = false' /etc/samba/smb.conf
# Créer le fichier de configuration de partage du répertoire Scans
sudo tee /var/lib/samba/usershares/scans << EOF > /dev/null
#VERSION 2
path=/dev/shm/usager/Scans
comment=
usershare_acl=S-1-1-0:F
guest_ok=n
sharename=Scans
EOF
# Changer le propriétaire du fichier de configuration vers l’utilisateur usager
sudo chown usager:usager /var/lib/samba/usershares/scans



## Création du script de maintenance hebdomadaire À LANCER AU MOINS UNE FOIS PAR SEMAINE ! ##
# Créer le script
cat << EOF > ~/maintenance_manuelle_hebdomadaire.sh
#!/bin/bash

# Créer un répertoire temporaire et s’y déplacer
cd \$(mktemp -d)

# Appliquer les modifications présentes dans le script « corrections.sh »
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/corrections.sh
chmod +x corrections.sh
./corrections.sh

# Synchroniser la liste des paquets
sudo apt update
# Télécharger et mettre à jour les paquets
sudo apt upgrade -y
# Supprimer les paquets obsolètes
sudo apt autoremove -y
# Mettre à jour les snaps
sudo snap refresh

## Mettre à jour Firefox
# Télécharger la dernière version de Firefox
wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=fr"
# Extraire l’archive
tar -xjvf firefox.tar.bz2
# Mettre à jour Firefox
sudo rsync -av --delete ./firefox/* /usr/local/bin/Firefox/
# Changer le propriétaire du répertoire vers l’utilisateur root
sudo chown -R root:root /usr/local/bin/Firefox

# Télécharger le fichier de configuration de Firefox
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/firefox/policies.json
# Installer le fichier de configuration de Firefox
sudo cp policies.json /etc/firefox/policies/
# Télécharger le fichier de configuration de uBlock Origin
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/firefox/uBlock0%40raymondhill.net.json
# Installer le fichier de configuration de uBlock Origin
sudo cp uBlock0@raymondhill.net.json /usr/lib/mozilla/managed-storage/
# Ouvrir la page des filtres de uBlock Origin pour les mettre à jour
notify-send --hint int:transient:1 'uBlock Origin' 'Vider le cache et mettre à jour les filtres.'
firefox
# Attendre que Firefox soit fermé avant de continuer
wait \$(pidof firefox)
# Télécharger la liste des fichiers/répertoires à ne pas synchroniser avec rsync
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/rsync_ignorer
# Synchroniser le répertoire skel
sudo rsync -avz --delete --exclude-from=rsync_ignorer "${HOME}/" /etc/skel
EOF
# Rendre le script exécutable
chmod 755 ~/maintenance_manuelle_hebdomadaire.sh
# Lancer le script
~/maintenance_manuelle_hebdomadaire.sh











################################
### ANCIENNES CONFIGURATIONS ###
################################

# Quitter le script avant de lancer les commandes ci-dessous
exit 0



## Configuration des DNS « Cloudflare for families » (ignorer cette section si la solution Téïcée ProxyEPN + Tic'nCube est déployée
# Paramètres -> Réseau -> Filaire :
# IPv4 -> DNS : 1.1.1.3,1.0.0.3
# IPv6 -> DNS : 2606:4700:4700::1113,2606:4700:4700::1003
# Plus de renseignements à cette adresse https://community.cloudflare.com/t/community-tip-best-practices-for-1-1-1-1-for-families/160496



# Créer la commande « oust » qui permet de se déconnecter
sudo tee /usr/local/bin/oust << EOF > /dev/null
#!/usr/bin/bash
session_id=\$(loginctl list-sessions | awk '{print \$1}' | head -n2 | tail -n1)
loginctl kill-session \${session_id}
EOF
# Lui donner les droits d’exécution
sudo chmod 755 /usr/local/bin/oust



# Supprimer tous les snaps installés
for paquet in $(snap list | awk {'print $1'}) ; do
  sudo snap remove "${paquet}"
done

sudo systemctl disable --now snapd

sudo apt purge -y snapd

