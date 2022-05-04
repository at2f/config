# Installation des postes usagers
1. Faire une installation minimale de Ubuntu 22.04 Desktop.
2. Créer l’utilisateur « *administrateur* ».
3. Placer le script [installation_postes_cyber-base.sh](https://github.com/at2f/config/blob/main/cyber-base/Postes%20usagers/installation/installation_postes_cyber-base.sh), ainsi que le dossier `modules` l’accompagnant dans le répertoire personnel de *administrateur* : `/home/administrateur/`.
4. Lancer le script dans un terminal avec la commande suivante : `bash ./installation_pc_cyber-base.sh`.

# Entretien des postes et veille technologique
Exécuter le script au moins une fois par semaine pour mettre à jour le système et synchroniser la session Usager, avec la commande suivante :
```bash
./maintenance_manuelle_hebdomadaire.sh
```

Si des modifications doivent être faites, les rajouter sur GitHub, dans le fichier [corrections.sh](https://github.com/at2f/config/blob/main/cyber-base/Postes%20usagers/divers/corrections.sh). Ce script est appelé par `maintenance_manuelle_hebdomadaire.sh`.

## Configuration des paramètres d’entreprise de Firefox
- Surveiller l’évolution des [options de configuration](https://github.com/mozilla/policy-templates).
- Lorsque des choses doivent être modifiées, le faire sur GitHub, dans le fichier [policies.json](https://github.com/at2f/config/blob/main/cyber-base/Postes%20usagers/firefox/policies.json).
- Le script de maintenance hebdomadaire téléchargera et installera la nouvelle version.

## Grammalecte
Vérifier régulièrement si une nouvelle version de [Grammalecte pour LibreOffice](https://grammalecte.net/#download) est disponible.

## uBlock Origin
- Ouvrir les paramètres de uBlock Origin, régler selon les besoins, puis les « Exporter vers un fichier ».
- Copier/coller le contenu du fichier dans http://raymondhill.net/ublock/adminSetting.html.
- Convertir et récupérer le contenu de « JSON-encoded settings to be used for adminSettings as a JSON string value ».
- Coller le contenu à la suite de `"adminSettings":` dans [uBlock0@raymondhill.net.json](https://github.com/at2f/config/blob/main/cyber-base/Postes%20usagers/firefox/uBlock0%40raymondhill.net.json). (⚠ Attention aux guillemets !)
- Le script de maintenance hebdomadaire téléchargera et installera la nouvelle version.

bash ./installation_pc_cyber-base.sh
## Documentation
- Paramètres d’entreprises de Firefox en français (très succint) : `about:policies#documentation`
- [Bloquer les comportements gênants de certains site](https://www.reddit.com/r/uBlockOrigin/wiki/solutions) (par ex : acceptation des cookies systématique sur Google) avec uBlock Origin.
- [Paramètres d’entreprise de uBlock Origin](https://github.com/gorhill/uBlock/wiki/Deploying-uBlock-Origin).
- [Paramètres des manifests de gestion de stockage de Firefox](https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions/Native_manifests#manifest_de_gestion_de_stockage).
- [Emplacement des manifests de gestion de stockage de Firefox](https://developer.mozilla.org/fr/docs/Mozilla/Add-ons/WebExtensions/Native_manifests#linux).
- [Installer Firefox manuellement](https://ftp.mozilla.org/pub/firefox/releases/latest/README.txt).
