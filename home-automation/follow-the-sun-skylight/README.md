# Skylight Automation

I wanted to make our old-school LED skylight in the living room follow the sun. This was simply to make my {W|L}ife happy. :-)

This is my first rodeo with home automation; I got into it out of necessity. I used Claude and Gemini extensively to help me with coding and other system setups. It was painful to work with these AI tools at times, as they frequently took me down various rabbit holes. However, with enough patience, I managed to finish the project successfully.

Some of the software components like ESPHome, MQTT Broker, Node-RED, Zigbee2MQTT were deployed using Proxmox Helper Scripts.
Source: https://community-scripts.org

## Hardware Stack

* illume Pro LED Panel (400 x 1200 mm): A high-quality, large-format panel designed to provide skylight-style illumination.
* Mean Well LED Driver (XLG-75-H-AB): Converts AC mains to constant DC power, replacing the existing propriority daisy chain of drivers and other components.
* Zigbee Dimmer (Skydance L1 WZ): The controller. It sits between the driver and the panel to modulate brightness via Zigbee commands.
* M5StickC Plus 1.1: ESP32-based edge node device that hosts the light sensor.
* BH1750 Ambient Light Sensor: A 16-bit digital sensor that measures precise lux values from the external environment.
* Sonoff Zigbee 3.0 USB Dongle Plus: Zigbee mesh network antena that connects the automation server.

## Software Stack

* ESPHome: The firmware framework for the M5Stick. It handles sensor polling, I2C bus management, and Wi-Fi connectivity.
* MQTT (Mosquitto): The messaging broker. It facilitates the transport of lux data from the ESPHome device to the automation engine.
* Node-RED: The logic engine. It processes the lux data, applies mathematical transforms, and manages the lighting state.
* Zigbee2MQTT: The software bridge that translates MQTT commands into Zigbee signals via the Sonoff dongle.

## Integrations and Data Flow

1. [Back courtyard] --(Light)--> BH1750 Sensor.
2. BH1750 --(I2C)--> M5Stick (running ESPHome).
3. M5Stick --(Wi-Fi/MQTT)--> MQTT Broker.
4. MQTT Broker --(Data)--> Node-RED.
5. Node-RED --(Logic/Brightness Command)--> Zigbee2MQTT.
6. Zigbee2MQTT --(Serial)--> Sonoff USB Dongle.
7. Sonoff Dongle --(Zigbee Wireless)--> Zigbee Dimmer.
8. Zigbee Dimmer --(PWM Voltage)--> illume LED Panel.

## Some unorganised, yet important info

### Configure the SMLight SLZB-07p7 USB Zigbee Adapter with Proxmox
On the proxmox host:
```
lsusb | grep -i "Silicon Labs"
# output looks like : Bus 001 Device 003: ID 10c4:ea60 Silicon Labs CP210x UART Bridge

ls -l /dev/serial/by-id/
# output looks like : usb-SMLIGHT_SMLIGHT_SLZB-07p7_3eb4b8eddbd5ef11bafc704b49d2c684-if00-port0 -> ../../ttyUSB0
```

### Use proxmox helper scripts to deploy key components.
Source: https://community-scripts.org/

### Deploy MQTT Broker (Mosquitto)
On the proxmox host:
```
bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/mqtt.sh)"
```

On the MQTT container:
```
# add the password for the device user
mosquitto_passwd -c /etc/mosquitto/passwd z2m_user

vi /etc/mosquitto/conf.d/default.conf
Add listener 1883 0.0.0.0 to listen to all but reject anyone without valid creds

chown mosquitto: /etc/mosquitto/passwd
chmod 600 /etc/mosquitto/passwd

systemctl restart mosquitto

```

### Deploy Zigbee2MQTT
On the proxmox host:
```
bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/zigbee2mqtt.sh)"
```
Confirm if the adapter is visible in the zigbee2mqtt container
```
cat /etc/pve/lxc/155.conf | grep dev0

# output looks like:
dev0: /dev/serial/by-id/usb-SMLIGHT_SMLIGHT_SLZB-07p7_3eb4b8eddbd5ef11bafc704b49d2c684-if00-port0,mode=0666
```
### Integrate Zigbee2MQTT with MQTT
on zigbee2MQTT container: `/opt/zigbee2mqtt/data/configuration.yaml` 
```
homeassistant: false
frontend:
  port: 8080
mqtt:
  base_topic: zigbee2mqtt
  server: 'mqtt://192.168.193.150:1883'
  user: z2m_user
  password: SOME_PASSWORD  
serial:
  port: /dev/serial/by-id/usb-SMLIGHT_SMLIGHT_SLZB-07p7_3eb4b8eddbd5ef11bafc704b49d2c684-if00-port0
  adapter: zstack
  rtscts: false
advanced:
  network_key:
    - 69
    - 174
    - 45
    - 19
    - 152
    - 53
    - 167
    - 188
    - 13
    - 243
    - 192
    - 235
    - 143
    - 138
    - 124
    - 163
  pan_id: 34371
  ext_pan_id:
    - 130
    - 24
    - 24
    - 138
    - 251
    - 189
    - 2
    - 53
```
After saving the file, `systemctl restart zigbee2mqtt`

Then `journalctl -u zigbee2mqtt -f` to test if the serviec is running.


### M5Stick and the lux sensor

Flash the device using https://web.esphome.io/ (MacOS USB passthrough works only with web UI)
