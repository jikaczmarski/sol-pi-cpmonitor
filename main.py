# import required packages
import socket
import paho.mqtt.client as mqtt
from ADCPi import ADCPi
from ADCDifferentialPi import ADCDifferentialPi

# initialize the hardware
adc_pi = ADCPi(0x68, 0x69, 18)
adc_pi_diff = ADCDifferentialPi(0x6a, 0x6b, 18)

# mqtt broker information
broker_hostname = "192.168.8.121"
broker_port = 1883

# identify the device (PV or Battery)
if socket.gethostname() == "sol-pi0-0":
    hardware_indicator = "battery"
    print("detected battery monitor")
    # battery
    broker_topic_voltage = "battery/voltage"
    broker_topic_current = "battery/current"
    broker_topic_power = "battery/power"

    # adc pi calibration
    adc_pi_f = 5.94

    # adc differential pi calibration
    adc_pi_diff_f = 1728.9099526066


elif socket.gethostname() == "sol-pi0-1":
    hardware_indicator = "pv"
    print("detected pv monitor")
    # photovoltaic
    broker_topic_voltage = "pv/voltage"
    broker_topic_current = "pv/current"
    broker_topic_power = "pv/power"

    # adc pi calibration
    adc_pi_f = (65.2 / 3.367)

    # adc differential pi calibration
    adc_pi_diff_f = 1367.27272727272727272727

# voltage measurement
def adjust_voltage(raw_voltage, calibration_factor):
    return (raw_voltage * calibration_factor)

# mqtt client setup
client = mqtt.Client(callback_api_version = mqtt.CallbackAPIVersion.VERSION2)
print("mqtt client setup")

client.connect(host = broker_hostname, port = broker_port)
print("mqtt client connected")

# program
if __name__ == "__main__":
        print("publishing data to {topic_1}, {topic_2}, and {topic_3}...".format(topic_1 = broker_topic_voltage, topic_2 = broker_topic_current, topic_3 = broker_topic_power))
        while True:
                client.publish(topic = broker_topic_voltage, payload = adjust_voltage(adc_pi.read_voltage(1), adc_pi_f))
                client.publish(topic = broker_topic_current, payload = adjust_voltage(adc_pi_diff.read_voltage(1), adc_pi_diff_f))
                client.publish(topic = broker_topic_power, payload = (adjust_voltage(adc_pi_diff.read_voltage(1), adc_pi_diff_f) * adjust_voltage(adc_pi.read_voltage(1), adc_pi_f)))
