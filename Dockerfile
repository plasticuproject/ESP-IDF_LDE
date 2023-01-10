FROM ubuntu:22.04

# Set username environment variable
ARG ESP_IDF_USER

# Switch to root user
USER root

# Run privileged command
RUN \
  apt-get update && \
  apt-get install -y sudo

# Set user and group
RUN useradd -d /home/$ESP_IDF_USER -m $ESP_IDF_USER
RUN adduser $ESP_IDF_USER sudo
RUN echo "$ESP_IDF_USER ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to user
USER $ESP_IDF_USER

# Copy firmware source files
COPY ./esp/ /home/$ESP_IDF_USER/esp/

# Run non-privileged commands
RUN \
  sudo apt-get install -y git vim wget flex bison gperf python3 python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 unzip python3-pip && \
  export PATH=$PATH:/home/$ESP_IDF_USER/.local/bin && \
  python3 -m pip install --upgrade pip && \
  python3 -m pip install virtualenv && \
  cd /home/$ESP_IDF_USER/esp && \
  git clone -b v4.4.3 --recursive https://github.com/espressif/esp-idf.git esp-idf-v4.4.3 && \
  cd esp-idf-v4.4.3/ && \
  chmod +x install.sh && \
  ./install.sh esp32s2 && \
  export IDF_PATH=/home/$ESP_IDF_USER/esp/esp-idf-v4.4.3 && \
  . /home/$ESP_IDF_USER/esp/esp-idf-v4.4.3/export.sh && \
  cd /home/$ESP_IDF_USER/esp/ESP32-Wi-Fi-Penetration-Tool-1.1 && \
  idf.py set-target esp32s2

# Copy over start_build.sh script
COPY ./start_build.sh /home/$ESP_IDF_USER/esp/
