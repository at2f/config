#!/usr/bin/bash

# Changer le nom d’hôte
sudo hostemctl set-hostname ServeurImpression

# Activer Cockpit
sudo systemctl start --now cockpit
sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload

# Installer CUPS
sudo dnf install -y cups
sudo systemctl enable --now cups
sudo firewall-cmd --permanent --add-service=ipp
sudo firewall-cmd --reload

# Assigner une IP fixe
sudo tee /etc/sysconfig/network-scripts/ifcfg-eno1 << EOF > /dev/null
# Type d’interface
TYPE=Ethernet
# Désactiver le DHCP et autoriser les IP statiques
BOOTPROTO=none
# IP statique et sous-réseau
IPADDR=192.168.1.138
PREFIX=24
GATEWAY=192.168.1.1
DNS1=192.168.1.1
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
sudo sed -i 's/*upgrade_type*/upgrade_type = default/' /etc/dnf/automatic.conf
