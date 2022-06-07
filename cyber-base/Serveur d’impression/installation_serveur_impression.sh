#!/usr/bin/bash

# Activer Cockpit
sudo systemctl start --now cockpit
sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload

# Installer CUPS
sudo dnf install -y cups
sudo systemctl enable --now cups
sudo firewall-cmd --permanent --add-service=ipp
sudo firewall-cmd --reload

# IP fixe
