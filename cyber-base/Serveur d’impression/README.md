# 1. Installation du système d’exploitation
Installer [Centos Stream](https://www.centos.org/), avec les réglages suivants :
- Source d’installation : Sur le réseau -> Miroir le plus proche
- Sélection logiciel : Server
- Security Profile : ANSII-BP-028 (minimal)
- Création utilisateur : cocher « Faire de cet utilisateur un administrateur »
- Ne **pas** créer de mot de passe administrateur

# 2. Lancement du script de post-installation
Lancer [le script de configuration du serveur d’impression](https://github.com/at2f/config/blob/main/cyber-base/Serveur%20d%E2%80%99impression/installation_serveur_impression.sh)
```bash
( cd $(mktemp -d)
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Serveur%20d%E2%80%99impression/installation_serveur_impression.sh
bash ./installation_serveur_impression.sh )
```

# 3. Configuration manuelle de CUPS

#### 1. Modifier quelques paramètres dans `/etc/cups/cupsd.conf` :
(avec `sudo nano /etc/cups/cupsd.conf`)
- Remplacer `Listen localhost:631` par `Listen 631`
- Rajouter `Allow @LOCAL` après `Order allow,deny` dans les catégories `<Location />` & `<Location /admin>`.

#### 2. Relancer le servic CUPS :

```bash
sudo systemctl restart cups
```

# 4. Configuration des imprimantes

Lancer [le script de configuration des imprimantes](https://github.com/at2f/config/blob/main/cyber-base/Serveur%20d%E2%80%99impression/installation_imprimantes.sh)

```bash
( cd $(mktemp -d)
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Serveur%20d%E2%80%99impression/installation_imprimantes.sh
bash ./installation_imprimantes.sh )
```

# 5. Redémarrer le serveur d’impression

```bash
sudo reboot
```

# 6. Configurer l’allumage/extinction automatique du serveur

## Extinction automatique

Lancer [le script de configuration de l’extinction automatique du serveur](https://github.com/at2f/config/blob/main/cyber-base/Serveur%20d%E2%80%99impression/activation_extinction_automatique.sh).

```bash
( cd $(mktemp -d)
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Serveur%20d%E2%80%99impression/activation_extinction_automatique.sh
bash ./activation_extinction_automatique.sh
```

## Allumage automatique

Régler les paramètres suivants dans le BIOS (Advanced -> Power) :

Wake System from S5

Recurrence = Daily

Puis choisir l’heure de démarrage (Wakeup Hour, Wakeup Minute, Wakeup Second).


# 7. Accéder au serveur d’impression

Interface CUPS :
https://10.11.111.10:631

Cockpit :
https://10.11.111.10:9090
