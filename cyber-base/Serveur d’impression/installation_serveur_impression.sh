#!/usr/bin/bash

# Changer le nom d’hôte
sudo systemctl set-hostname ServeurImpression

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
sudo tee /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF > /dev/null
DEVICE=eth0
BOOTPROTO=none
ONBOOT=yes
PREFIX=24
IPADDR=192.168.1.230
EOF

# Activer les mises à jour automatiques
sudo sed -i 's/*upgrade_type*/upgrade_type = default/' /etc/dnf/automatic.conf
