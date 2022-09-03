#!/usr/bin/bash

# Supprimer le snap de Firefox
sudo snap remove firefox
# Se déplacer dans un dossier temporaire et ouvrir un subshell
( cd "$(mktemp -d)"
# Télécharger la dernière version de Firefox
wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-esr-latest&os=linux64&lang=fr"
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
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/firefox/firefox.desktop
# Installer le fichier d’application
sudo cp firefox.desktop /usr/share/applications/
# Fermer le subshell
)
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
fichier_preferences="$(find ${HOME}/.mozilla/firefox -iname *default-esr*)/prefs.js"
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
  # Enregistrer l’intitulé nu des paramètres dans la variable « option »
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
# Enlever le bouton « Importer les marques-pages d’un autre navigateur dans Firefox. »
sed -i 's/\\"import-button\\",//' "${fichier_preferences}"
# Désépingler les raccourcis dans les nouveaux onglets
sed -i 's/browser.newtabpage.pinned//' "${fichier_preferences}"
# Se déplacer dans un dossier temporaire et ouvrir un subshell
( cd "$(mktemp -d)"
# Télécharger un modèle préconfiguré pour les paramètres d’entreprise
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/firefox/policies.json
# Créer le répertoire de destination
sudo mkdir -p /etc/firefox/policies
# Installer le fichier de configuration
sudo cp policies.json /etc/firefox/policies/
# Créer le répertoire de configuration des addons Firefox (manifest de gestion de stockage)
sudo mkdir -p /usr/lib/mozilla/managed-storage
# Télécharger le fichiers de configuration de uBlock Origin
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Postes%20usagers/firefox/uBlock0%40raymondhill.net.json
# Installer le fichier de configuration de uBlock Origin
sudo cp uBlock0@raymondhill.net.json /usr/lib/mozilla/managed-storage/
# Fermer le subshell
)
