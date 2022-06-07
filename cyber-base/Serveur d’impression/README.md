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
- Rajouter deux lignes `Allow 192.168.1.0/24` et `Allow 10.11.111.0/24` après `Order allow,deny` dans les catégories suivantes : `<Location />`, `<Location /admin>`, et `<Location /admin/conf>`.

#### 2. Relancer le servic CUPS :

```bash
sudo systemctl restart cups
```

# 4. Configuratino des imprimantes

Lancer [le script de configuration des imprimantes](https://github.com/at2f/config/blob/main/cyber-base/Serveur%20d%E2%80%99impression/installation_imprimantes.sh)

```bash
( cd $(mktemp -d)
wget https://raw.githubusercontent.com/at2f/config/main/cyber-base/Serveur%20d%E2%80%99impression/installation_imprimantes.sh
bash ./installation_imprimantes.sh) )
```
