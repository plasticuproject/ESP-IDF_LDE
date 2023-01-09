#!/bin/sh

# Check for and update existing build environment image
echo "[/] Checking for existing esp_idf_env docker image...";
if [ ! -z $(docker images | grep esp_idf_env | head -n 1 | cut -d " " -f 1) ]; then
	echo "[!] esp_idf_env image found..."
	echo "[/] Removing image...";
        docker rmi esp_idf_env;
	echo "";
fi;

# Set username and build image
echo "[/] Building new esp_idf_env docker image...";
ESP_IDF_USER=$USER;
if [ $USER = root ]; then
	ESP_IDF_USER=esp_idf_user;
fi;
docker build --build-arg ESP_IDF_USER=$ESP_IDF_USER -t esp_idf_env .
