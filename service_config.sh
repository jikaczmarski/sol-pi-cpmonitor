#! /usr/bin/bash

# creating new service
sudo touch /etc/systemd/system/voltage_monitor.service  > /dev/null 2>&1

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
" | sudo tee -a /etc/systemd/system/voltage_monitor.service  > /dev/null 2>&1

# reload systemd
sudo systemctl daemon-reload  > /dev/null 2>&1

# enable on-boot service
sudo systemctl enable voltage_monitor.service  > /dev/null 2>&1

# start the service without requiring a reboot
sudo systemctl start voltage_monitor.service  > /dev/null 2>&1

echo "Finished setting up the service. The monitor has started and may take some time to initialize."
