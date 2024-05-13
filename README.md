# About

Program for monitoring analog to digital converter channels on the ADCPi and ADCDifferentialPi stack for the ACEP Solar Trailer display. Running `start.sh` will set up the Raspberry Pi Zero to have all required I2C channels initalized and program dependencies installed. It will then start `main.py` which detects which Pi stack is being used (battery or solar PV monitor) and begins publishing to an MQTT broker.

# First Time Setup

Following the below instructions will ensure the program runs as intended,

```
~ $ mkdir ~/Projects
~ $ git clone https://github.com/jikaczmarski/sol-pi-cpmonitor.git ~/Projects/voltage_monitor
~ $ chmod u+x ~/Projects/voltage_monitor/start.sh
~ $ ln -s ~/Projects/voltage_monitor/start.sh
```

The program can then be initailized by running

```
~ $ ./start.sh
```
