#!/usr/bin/bash

# Changer le nom d’hôte
sudo hostnamectl set-hostname ServeurImpression

# Activer Cockpit
sudo systemctl enable --now cockpit.socket
sudo firewall-cmd --permanent --add-service=cockpit # --zone=public
sudo systemctl reload firewalld

# Installer CUPS
sudo dnf install -y cups
sudo systemctl enable --now cups
sudo firewall-cmd --permanent --add-service=ipp
sudo firewall-cmd --reload

# Partager les imprimantes avec Avahi
sudo systemctl enable --now avahi-daemon
#sudo firewall-cmd --permanent --add-port=5353/udp
sudo firewall-cmd --permanent --add-service=mdns
sudo systemctl reload firewalld

# Assigner une IP fixe
sudo tee /etc/sysconfig/network-scripts/ifcfg-eno1 << EOF > /dev/null
# Type d’interface
TYPE=Ethernet
# Désactiver le DHCP et autoriser les IP statiques
BOOTPROTO=none
# IP statique et sous-réseau
IPADDR=10.11.111.10
PREFIX=24
GATEWAY=10.11.111.1
DNS1=10.11.111.1
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
# Désactiver IPV6
IPV6INIT=no
# Matériel
DEVICE=eno1
# Configurer au démarrage
ONBOOT=yes
EOF

# Activer les mises à jour automatiques
sudo sed -i 's/upgrade_type.*/upgrade_type = default/' /etc/dnf/automatic.conf
