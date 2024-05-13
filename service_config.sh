#! /usr/bin/bash

# creating new service
sudo touch /etc/systemd/system/voltage_monitor.service

# service file content
echo "[Unit]
Description=Voltage Monitor Service
After=multi-user.target

[Service]
Type=simple
User=pi
ExecStart=/bin/bash /home/pi/Projects/voltage_monitor/start.sh
Restart=on-abort

[Install]
WantedBy=multi-user.target
" | sudo tee -a /etc/systemd/system/voltage_monitor.service

# reload systemd
sudo systemctl daemon-reload

# enable on-boot service
sudo systemctl enable voltage_monitor.service

# start the service without requiring a reboot
sudo systemctl start voltage_monitor.service
