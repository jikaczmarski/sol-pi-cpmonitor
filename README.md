# About
Program for monitoring analog to digital converter channels on the ADCPi and ADCDifferentialPi stack for the ACEP Solar Trailer display. Running `start.sh` will set up the Raspberry Pi Zero to have all required I2C channels initalized and program dependencies installed. It will then start `main.py` which detects which Pi stack is being used (battery or solar PV monitor) and begins publishing to an MQTT broker.

# Setup
Following the below instructions will ensure the program runs as intended,

```{bash}
mkdir ~/Projects
git clone https://github.com/jikaczmarski/sol-pi-cpmonitor.git ~/Projects/voltage_monitor
chmod u+x ~/Projects/voltage_monitor/start.sh
```

# Running the service
## Option 1: Manual start
You can run the monitor from the home directory by creating a symbolic link to the startup script,

```{bash}
ln -s ~/Projects/voltage_monitor/start.sh
```

And call the script
```{bash}
./start.sh
```
## Option 2: Start on boot
You can use systemd to run the service on start so that the monitors begin reporting after reboot. To do this, run the `service_config.sh` file *after* running the commands in [setup](#setup) section,

```
chmod u+x ~/Projects/voltage_monitor/service_config.sh
~/Projects/voltage_monitor/service_config.sh
```

 This file creates a process and enables it on boot.