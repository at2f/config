#!/usr/bin/bash

## Configuration des DNS « Cloudflare for families » (ignorer cette section si la solution Téïcée ProxyEPN + Tic'nCube est déployée
# Paramètres -> Réseau -> Filaire :
# IPv4 -> DNS : 1.1.1.3,1.0.0.3
# IPv6 -> DNS : 2606:4700:4700::1113,2606:4700:4700::1003
# Plus de renseignements à cette adresse https://community.cloudflare.com/t/community-tip-best-practices-for-1-1-1-1-for-families/160496



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
