#!/bin/sh

# Run this script inside docker container instance to build firmware image
ESP_IDF_USER=$(whoami);
if [ $ESP_IDF_USER = root ]; then
	echo "[!] Root user detected.";
	echo "[/] Run script as user: $ESP_IDF_USER";
	exit 0;
fi;

export IDF_PATH=/home/$ESP_IDF_USER/esp/esp-idf-v4.4.3;
. /home/$ESP_IDF_USER/esp/esp-idf-v4.4.3/export.sh;
cd /home/$ESP_IDF_USER/esp/ESP32-Wi-Fi-Penetration-Tool-1.1;
idf.py build;
cp -r /home/$ESP_IDF_USER/esp/ESP32-Wi-Fi-Penetration-Tool-1.1 /tmp;
cd /home/$ESP_IDF_USER/esp
