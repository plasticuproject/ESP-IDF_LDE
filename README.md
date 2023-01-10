# ESP-IDF Linux Development Environment for Espressif ESP32-S2

Everything needed to modify, develop, and build the [ESP32-Wi-Fi-Penetration-Tool](https://github.com/FroggMaster/ESP32-Wi-Fi-Penetration-Tool) firmware for the ESP32-S2 [Flipper Wi-Fi Debugger Module](https://docs.flipperzero.one/development/hardware/wifi-debugger-module).

- **Toolchain** to compile code for ESP32-S2
- **Build tools** - CMake and Ninja to build a full Application for ESP32-S2
- **ESP-IDF** that essentially contains API (software libraries and source code) for ESP32-S2 and scripts to operate the Toolchain
- **ESP32-Wi-Fi-Penetration-Tool** source code 

![what-you-need](/images/what-you-need.png)

Clone this repository:
- `git clone --recurse-submodules https://github.com/plasticuproject/ESP-IDF_LDE.git`

Make any desired firmware modifications to the source files in `./ESP-IDF_LDE/esp/ESP32-Wi-Fi-Penetration-Tool-1.1/`

Run:
- `./build_image.sh` to build the Ubuntu development environment docker image.
- `./start_container.sh` to run the disposable docker container with an interactive shell.
- `./start_build.sh` inside the container to compile and build firmware.

The full firmware source code and build files will be exported to `/tmp/` of your host machine. Install [Esptool.py](https://docs.espressif.com/projects/esptool/en/latest/esp32/) and then flash the firmware to your device using the command:
- `esptool.py -p /dev/<PORT, e.g. ACM0> -b 115200 --after hard_reset write_flash --flash_mode dio --flash_freq 40m --flash_size detect 0x8000 /tmp/ESP32-Wi-Fi-Penetration-Tool-1.1/build/partition_table/partition-table.bin 0x1000 /tmp/ESP32-Wi-Fi-Penetration-Tool-1.1/build/bootloader/bootloader.bin 0x10000 /tmp/ESP32-Wi-Fi-Penetration-Tool-1.1/build/esp32-wifi-penetration-tool.bin`
