# <big>Software</big>

This doc shares references to resources that helped me setup Klipper, MainSail with my Octopus, RaspberryPi, CANBus build.

Related:
- Topic with set of links https://forum.vorondesign.com/threads/bigtreetech-octopus-v1-0-and-v1-1-information.79/
- Wiring and SW setup walkthrough https://www.youtube.com/watch?v=jgE3XMM9PBk
  - Uses USB-to-CAN ("U2C") Pi Hat, which am not using.  But many of the concepts and steps are related.
- [How to Use CAN Toolhead Boards Connected Directly to Octopus / Octopus Pro on Katapult](https://klipper.discourse.group/uploads/short-url/oKyxrVja7wW0J8toGB1pqfaGp4z.pdf) shared on Klipper Forum was very helpful.  The .PDF was mentioned in [https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/3](https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/3).

## Klipper Install
Related:
- [2022/8 Chris Riley YT - Klipper Firmware - Install - 2022 - Chris's Basement](https://www.youtube.com/watch?v=qS1TC7zVXYw)
- [2022/8 Chris Riley YT - Klipper, Mainsail, Fluidd - 2022 - Chris's Basement](https://www.youtube.com/watch?v=FjMZzW_WVQ8)
  - Follow latest docs, or info in this video if they still apply.  In short, you'll probably...
    - Use [Pi imager](https://www.raspberrypi.com/software/) to create MainSail flavored Pi OS image (will contain Klipper snapshot).
    - Boot up and connect to your Pi, called mine _repeat.local_
    - Configure, build and copy Klipper firmware to Octopus/Controller
      - Configured using ```make menuconfig``` and followed some relevant details in Voron [Build Firmware Image](https://docs.vorondesign.com/build/software/octopus_klipper.html#build-firmware-image).
      - Also used https://github.com/bigtreetech/BIGTREETECH-OCTOPUS-V1.0/blob/master/Firmware/Klipper/README.md#basic-configuration
      - Example Voron Trident Klipper Octopus v1.1 (STM32F446) [printer.cfg](https://github.com/VoronDesign/Voron-Trident/blob/main/Firmware/Octopus/Trident_Octopus_Config.cfg).  Has similar hardware to V1E MP3DP v4, but each line needs reviewing, e.g. diff end stops setup.
      - Build klipper firmware via ```make klipper```
      - Copy to built klipper.bin to firmware.bin on SD card for Octopus/Controller
- [2021/10 Steve Builds (Voron Trident creator) - Voron Trident Build Hang out](https://www.youtube.com/live/zXFGQMVvHrs?feature=share)
  - [31:15](https://www.youtube.com/live/zXFGQMVvHrs?feature=share&t=1875) KlipperScreen setup/config of TFT mounted to Pi.
- [Klipper Docs - CANBUS](https://www.klipper3d.org/CANBUS.html?h=menuconfig)

### Klipper WebCam setup
For download, install and configure info, see [Klipper - Multiple Cameras - Mainsail - Fluidd - Chris's Basement - 2023](https://www.youtube.com/watch?v=PAQ1lkUC-nM).  Shows how to setup 1-many WebCam.

Ensure camera interface is enabled... ```sudo raspi-config```
Test the camera works... ```raspistill -o test.jpg.``` download and view image, can use winscp or similar.

If logs contain dependency errors, e.g. streamer lib not install, then may need to install/build crowsnest...

```
cd crowsnest
sudo make install
```

If ```mjpg-streamer``` dependency is missing for some reason... 
```
sudo apt update
sudo apt install mjpg-streamer
```

Discover id for USB Cams via...
```
dir /dev/v4l/by-id

```

Edit, save, and restart Klipper, maybe restart Pi host even
```
[crowsnest]
log_path: /home/661wls/printer_data/logs/crowsnest.log
log_level: verbose                      # Valid Options are quiet/verbose/debug
delete_log: true                       # Deletes log on every restart, if set to true
no_proxy: false

[cam 1]
mode: ustreamer                         # ustreamer - Provides mjpg and snapshots. (All devices)
                                        # camera-streamer - Provides webrtc, mjpg and snapshots. (rpi + Raspi OS based only)
enable_rtsp: false                      # If camera-streamer is used, this enables also usage of an rtsp server
rtsp_port: 8554                         # Set different ports for each device!
port: 8081                              # HTTP/MJPG Stream/Snapshot Port
device: /dev/v4l/by-id/usb-Microsoft_Microsoft®_LifeCam_Cinema_TM_-video-index0  # AZA , was /dev/video0 
resolution: 640x480                     # widthxheight format
max_fps: 15                             # If Hardware Supports this it will be forced, otherwise ignored/coerced.
```

Browse camera via...

```
http://repeat/webcam2/?action=stream
```

Logs...
```
/home/661wls/printer_data/logs/crowsnest.log
```


### Klipper CANBus setup

Related :
- https://github.com/bigtreetech/EBB repo contains [user manual](https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/EBB36%20CAN%20V1.1/BIGTREETECH%20EBB36%20CAN%20V1.1%20User%20Manual.pdf), [hardware specs](https://github.com/bigtreetech/EBB/tree/master/EBB%20CAN%20V1.1%20(STM32G0B1)/EBB36%20CAN%20V1.1/Hardware), [pinout](https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/EBB36%20CAN%20V1.1/Hardware/EBB36%20CAN%20V1.1%26V1.2-PIN.png).  Read the docs for the model and version you have...
  - For my EBB 36 v1.2 ...
    - Found Docs https://github.com/bigtreetech/EBB#ebb36--42-can-v12, which are mostly same as v1.1
    - Found Klipper config fragment with pin mappings at https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/sample-bigtreetech-ebb-canbus-v1.2.cfg

- [CAN Bus overview by Teaching Tech (YT)](https://www.youtube.com/watch?v=5pLjeQz9pEI) 
  - https://github.com/meteyou/KlipperMisc

#### Build and Flash Katapult firmware onto EBB36
- https://maz0r.github.io/klipper_canbus/toolhead/ebb36-42_v1.1.html
- https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/17?u=azab2c


#### Build and Flash Katapult and Klipper firmware onto Octopus

- https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/5?u=azab2c

https://klipper.discourse.group/t/octopus-pro-canboot-can-bus-bridge/3734/30?u=azab2c

- Created CANBus wire using 24 AWG Cat 5 cable.  
- Tested wire continuity/resistance. 
- Connected and powered up.



- NEED TO BUY:
  - PTFE 4mm+ ID, ~6 OD, maybe high temp silicone?

- TODO:
  - TODO: Read https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/2
  - TODO: *Maybe* Read https://github.com/Esoterical/voron_canbus
  - TODO: *Maybe* Read Voron Discord #can_bus_depot https://discord.com/channels/460117602945990666/1076243803947667516
  - Misc conversations suggesting to use U2C (USB to CANBUS adapter) since that'll be more reliable than
  - CANBUS protocol uses 2 wire high-low [Differential_signalling](https://en.wikipedia.org/wiki/Differential_signalling), so twisted pair of stranded wire is best.  AWG22 or thicker??? to carry ~50W (24v at ~2amp) for hot-end, fans, sensors, BL touch, etc...
https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/sample-bigtreetech-ebb-canbus-v1.2.cfg


#### CANBus wiring

Was going to use a [stranded Cat-6 Ethernet Patch cable](https://www.amazon.com/gp/product/B01INRUFGK) I have already.  Despite being very popular with ~122,000 reviews, am not going to use after cutting and examining the wires to learn they're just ~26 AWG, or thinner even...

Instead am using Cat 5 24AWG stranded copper.  One pair for CANBus high/low, two pairs for power.  Grounded the final pair with the naive hope of helping shield comms.  Only grounded at end closest to controller

problem: Katapult scripts failing, ifconfig not listing can0
cause: ???
context:
- Related? https://github.com/Arksine/Katapult/issues/69

#### Config, Build and Upload Firmware to Octopus and EBB:
Based on info at https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/5?u=azab2c

- Edited ```/etc/rc.local``` per https://github.com/Arksine/Katapult/issues/72#issuecomment-1501347910
- Looked up what "allow-hotplug" does.  Considered changing to "auto", but am wondering whether lack of can0 indicates EBB and/or Octopus USB-to-CAN bridage CANBus device is not being detected, and/or Klipper printer.cfg isn't configured to enable CAN even if the build is.  Am questioning everything at this point given how long root causing missing can0 is taking.
- Powered off.  Added jumper to EBB's 120R pins.  Powered on.

#### Configure Raspberry Pi interface

Based on https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/17?u=azab2c

```
sudo nano /etc/network/interfaces.d/can0
```

```
allow-hotplug can0
iface can0 can static
    bitrate 1000000
    up ifconfig $IFACE txqueuelen 1024
    pre-up ip link set can0 type can bitrate 1000000
    pre-up ip link set can0 txqueuelen 1024
```

```
sudo reboot
```

#### Config and Build Katapult

```
sudo apt-get update
sudo apt-get upgrade
```

```
git clone https://github.com/Arksine/katapult
cd ~/katapult
git pull
```

Configure settings to build Katapult for Octopus v1.1 :
```
make clean
make menuconfig
```

```
    Micro-controller Architecture (STMicroelectronics STM32)  --->
    Processor model (STM32F446)  --->
    Build Katapult deployment application (Do not build)  --->
    Clock Reference (12 MHz crystal)  --->
    Communication interface (USB (on PA11/PA12))  --->
    Application start offset (32KiB offset)  --->
    USB ids  --->
()  GPIO pins to set on bootloader entry
[*] Support bootloader entry on rapid double click of reset button
[ ] Enable bootloader entry on button (or gpio) state
[ ] Enable Status LED
```


Build, move and rename Katapult binary (built for Octopus) for flashing later on.
```
make
mv out/katapult.bin octopus_katapult.bin
```

Configure settings to build Katapult for EBB v1.2 :
```
make clean
make menuconfig
```

```
    Katapult Configuration v0.0.1-61-gec4df2e-dirty
    Micro-controller Architecture (STMicroelectronics STM32)  --->
    Processor model (STM32G0B1)  --->
    Build Katapult deployment application (Do not build)  --->
    Clock Reference (8 MHz crystal)  --->
    Communication interface (CAN bus (on PB0/PB1))  --->
    Application start offset (8KiB offset)  --->
(1000000) CAN bus speed
()  GPIO pins to set on bootloader entry
[*] Support bootloader entry on rapid double click of reset button
[ ] Enable bootloader entry on button (or gpio) state
[*] Enable Status LED
(PA13)  Status LED GPIO Pin
```

Build, move and rename Katapult binary (built for EBB) for flashing later on.
```
make
mv out/katapult.bin ebb_katapult.bin
```


#### Config and Build Klipper

```
sudo apt-get update
sudo apt-get upgrade
```

```
cd ~/klipper
git pull
```

Configure settings to build Klipper for Octopus v1.1 :
```
make clean
make menuconfig
```

```
                         Klipper Firmware Configuration
[*] Enable extra low-level configuration options
    Micro-controller Architecture (STMicroelectronics STM32)  --->
    Processor model (STM32F446)  --->
    Bootloader offset (32KiB bootloader)  --->
    Clock Reference (12 MHz crystal)  --->
    Communication interface (USB to CAN bus bridge (USB on PA11/PA12))  --->
    CAN bus interface (CAN bus (on PD0/PD1))  --->
    USB ids  --->
(1000000) CAN bus speed
()  GPIO pins to set at micro-controller startup
```


Build, move and rename Klipper binary (built for Octopus) for flashing later on.
```
make
mv out/klipper.bin octopus_klipper.bin
```


Configure settings to build Klipper for EBB :
```
make clean
make menuconfig
```

```
                         Klipper Firmware Configuration
[*] Enable extra low-level configuration options
    Micro-controller Architecture (STMicroelectronics STM32)  --->
    Processor model (STM32G0B1)  --->
    Bootloader offset (8KiB bootloader)  --->
    Clock Reference (8 MHz crystal)  --->
    Communication interface (CAN bus (on PB0/PB1))  --->
(1000000) CAN bus speed
()  GPIO pins to set at micro-controller startup
```


Build, move and rename Klipper binary (built for EBB) for flashing later on.
```
make
mv out/klipper.bin ebb_klipper.bin
```



- Added jumper to Octopus boot0, reset Octopus, should go into DFU mode.
- Check Octopus is in DFU mode via ```lsusb```, verify output contains ```0483:df11 STMicroelectronics STM Device in DFU Mode```.  Note ```0483:df11 STMicroelectronics STM Device in DFU Mode``` is common, but could change.  If you see a different Identifier, be sure to use that instead for the instructions that follow.
- Use dfu-util to upload octopus_katapult.bin and octopus_klipper.bin, follow steps described in https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/5?u=azab2c
  ```
  sudo dfu-util -a 0 -D ~/katapult/octopus_katapult.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11
  ```
- Check Octopus is still in DFU mode.  Previous flash step may have take controller out of DFU mode.  Press reset button to re-enter DFU again.  Ensure ```lsusb``` is still listing device with ```0483:df11 STMicroelectronics STM Device in DFU Mode``` or whatever identifier your Controller board type normally returns.
  ```
  sudo dfu-util -a 0 -D ~/klipper/octopus_klipper.bin --dfuse-address 0x08008000:leave -d 0483:df111
  ```
- Remove Octopus boot0 jumper and reset.


- Ensure correct baud rate specified in Klipper printer.cfg, edit [mcu] section, [https://www.klipper3d.org/Config_Reference.html?h=mcu+baud#mcu](https://www.klipper3d.org/Config_Reference.html?h=mcu+baud#mcu).

- Query CANBus status, checks can0 interface is working and that Katapult on Octopus is running...
    ```
    cd ~/katapult/scripts
    python3 ~/kanBoot/scripts/flash_can.py -q
    ```

- Get Octopus Serial Id
```
ls /dev/serial/by-id
```

- Flash Klipper to Octopus via Katapult serial command
```
cd ~/katapult/scripts
pip3 install pyserial
python3 flash_can.py -f ~/klipper/octopus_klipper.bin -d <serial_device>

For example...

python3 flash_can.py -f ~/klipper/octopus_klipper.bin -d /dev/serial/by-id/usb-katapult_stm32f446xx_2A0005001850344D30353320-if00
```

ifconfig should list can0

List CAN Bus UUIDs for Octopus and EBB36...
```
cd ~/katapult/scripts
~/klippy-env/bin/python flash_can.py -i can0 -q

```

Example output
```
Resetting all bootloader node IDs...
Checking for Katapult nodes...
Detected UUID: f7a5fa2b8bf6, Application: Katapult
Query Complete
```

<mark>~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0</mark>

Returned canbus identifiers for Octopus and EBB36 just once.  After that they were not displayed.  Spent many many hours trying to figure out why the ~~"devices are not being listed, so they must be broken"~~, well...  Turns out I didn't RT*M the scattered docs enough, 🤦‍♂️, [Klipper Docs > CANBus](https://github.com/Klipper3d/klipper/blob/master/docs/CANBUS.md) says... 
- *"Note that the canbus_query.py tool will only report uninitialized devices - if Klipper (or a similar tool) configures the device then it will no longer appear in the list."*

So, if the devices not being displayed means they're working, or, maybe that they're not connected...  Not ideal.  So, am verifying CANBus is connected and configured by exercising end-to-end functionality, testing stepper motion, and EBB36 connected hotend/fan/extruder motion.

- Power down EBB36.  Ensure power is only provided by USB-C, i.e. ensure CANBus cable not connected.  Add jumper to VUSB header.
- Power up EBB.  Boot EBB36 into DFU mode (press and hold BOOT and RESET buttons, then release RESET before releasing BOOT).
- Check Pi can see EBB36 is connected, and in DFU mode using ```lsusb```.  Output should include something like...
  - ```
    0483:df11 STMicroelectronics STM Device in DFU Mode
    ```
  -  Note the ```0483:df11```, use/substitute that identifier in the following steps.
- Flash Katapult firmware to EBB36...

```
sudo dfu-util -a 0 -D ~/katapult/ebb_katapult.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11 
```

- Flash Klipper firmware to EBB36...

<mark>2024/1/23 DID NOT WORK with offset 0x08008000 (ie. 32kb)!  Edited to 0x08002000 but haven't tried, next time...🤷‍♂️  ENDED UP USING Katapult upload mentioned later in this doc</mark>

```
sudo dfu-util -a 0 -D ~/klipper/ebb_klipper.bin --dfuse-address 0x08002000:leave -d 0483:df11
```

- Power down EBB36.  Remove USB-C cable from Pi to EBB.  
- Remove VUSB jumper.  Add 120R jumper.  
- Connect fan to EBB36.  Consider delaying connecting other components to EBB36 until getting fan connected to EBB36 working.
- Connect CANBus cable.
- Ensure USB-C (re)connected from Pi to Octopus
- Reset Octopus
- Verify


Upload Klipper to EBB via Katapult over CAN Bus

```

python3 ~/katapult/scripts/flash_can.py -f ~/klipper/ebb_klipper.bin -u f7a5fa2b8bf6
```

Upload  Klipper onto Octopus over CAN Bus...
```
python3 ~/katapult/scripts/flash_can.py -f ~/klipper/octopus_klipper.bin -u 642f53509351
```

Example Output...

```
661wls@repeat:~/katapult/scripts $ python3 ~/katapult/scripts/flash_can.py -f ~/klipper/ebb_klipper.bin -u f7a5fa2b8bf6
Sending bootloader jump command...
Resetting all bootloader node IDs...
Attempting to connect to bootloader
Katapult Connected
Protocol Version: 1.0.0
Block Size: 64 bytes
Application Start: 0x8002000
MCU type: stm32g0b1xx
Verifying canbus connection
Flashing '/home/661wls/klipper/ebb_klipper.bin'...

[##################################################]

Write complete: 14 pages
Verifying (block count = 426)...

[##################################################]

Verification Complete: SHA = A2A405AB42F65688BDDCA68A24FAC8B5B644308C
Flash Success
```

## Futures:
- WaveShare 7" or similar screen
  - Setup info at https://klipper.discourse.group/t/skr-3-ebb-can-bus-klipperscreen-working/4840
