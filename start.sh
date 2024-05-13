#! /usr/bin/bash

# This bash script is for intiializing ADC Pi's to operate as clients for an MQTT broker.
cd /home/pi/Projects/voltage_monitor/

# Enable the I2C to allow ADC Pi to interface
echo "Checking for I2C capability..."
if command sudo raspi-config nonint get_i2c | grep -q '0'; then
	echo "I2C Operational"
else
	echo "I2C Not Operational. Adjusting I2C..."
	sudo raspi-config nonint do_i2c 0
	if command sudo raspi-config nonint get_i2c | grep -q '1'; then
		echo "I2C failed to initialize."
		exit 1
	else
		echo "I2C is now operational."
	fi
fi

# Check for dependencies and install them if missing
echo "Checking for python and mosquitto dependencies. This may take time if dependencies are being installed..."
sudo apt-get install -y mosquitto-clients > /dev/null
echo "Successfully found all dependencies"

# Setting up virtual environment
echo "Building a virtual environment..."
python -m venv venv > /dev/null
. venv/bin/activate
echo "Downloading ADC Pi Python libraries..."
git clone https://github.com/abelectronicsuk/ABElectronics_Python_Libraries.git > /dev/null 2>&1
cd ABElectronics_Python_Libraries/
echo "Installing ADC Pi Python libraries..."
sudo /home/pi/Projects/voltage_monitor/venv/bin/python setup.py install > /dev/null 2>&1
echo "Installing paho-mqtt..."
pip install paho-mqtt > /dev/null 2>&1
echo "Installing smbus..."
pip install smbus2 > /dev/null 2>&1

echo "The ADC Pi is now operational. Beginning voltage publication..."

# Start the program
cd ..
python main.py
