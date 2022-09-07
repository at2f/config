#!/usr/bin/bash

# Créer le timer d’exécution du service d’extinction
sudo tee /etc/systemd/system/systemctl_poweroff.timer << EOF > /dev/null
[Unit]
Description=Extinction automatique du serveur d’impression

[Timer]
OnCalendar=Mon,Wed,Thu,Fri,Sat *-*-* 19:00:00
OnCalendar=Tue *-*-* 21:00:00
OnCalendar=Sun *-*-* 08:30:00

[Install]
WantedBy=timers.target
EOF


# Créer le service d’extinction
sudo tee /etc/systemd/system/systemctl_poweroff.service << EOF > /dev/null
[Unit]
Description=Extinction du serveur d’impression

[Service]
ExecStart=systemctl poweroff
EOF


# Activer le timer
sudo systemctl enable --now systemctl_poweroff.timer
