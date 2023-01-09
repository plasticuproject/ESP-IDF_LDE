#!/bin/sh

# Run this script after start_build.sh to launch esp_idf_env instance
ESP_IDF_USER=$USER;
if [ $USER = root ]; then
	ESP_IDF_USER=esp_idf_user;
fi;
docker run --user $ESP_IDF_USER -v /tmp:/tmp -w /home/$ESP_IDF_USER/esp -it --rm esp_idf_env:latest sh
