## <big>Software</big>

This doc shares references to resources that helped me setup Klipper, MainSail with my Octopus, RaspberryPi, CANBus build.

Related:
- Topic with set of links https://forum.vorondesign.com/threads/bigtreetech-octopus-v1-0-and-v1-1-information.79/
- Wiring and SW setup walkthrough https://www.youtube.com/watch?v=jgE3XMM9PBk
  - Uses USB-to-CAN ("U2C") Pi Hat, which am not using.  But many of the concepts and steps are related.
- [How to Use CAN Toolhead Boards Connected Directly to Octopus / Octopus Pro on CanBoot](https://klipper.discourse.group/uploads/short-url/oKyxrVja7wW0J8toGB1pqfaGp4z.pdf) shared on Klipper Forum was very helpful.  The .PDF was mentioned in [https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/3](https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/3).

### Klipper Install
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


## CANBus setup

### EBB36 setup
Related :
- https://github.com/bigtreetech/EBB repo contains [user manual](https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/EBB36%20CAN%20V1.1/BIGTREETECH%20EBB36%20CAN%20V1.1%20User%20Manual.pdf), [hardware specs](https://github.com/bigtreetech/EBB/tree/master/EBB%20CAN%20V1.1%20(STM32G0B1)/EBB36%20CAN%20V1.1/Hardware), [pinout](https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/EBB36%20CAN%20V1.1/Hardware/EBB36%20CAN%20V1.1%26V1.2-PIN.png).  Read the docs for the model and version you have...
  - For my EBB 36 v1.2 ...
    - Found Docs https://github.com/bigtreetech/EBB#ebb36--42-can-v12, which are mostly same as v1.1
    - Found Klipper config fragment with pin mappings at https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/sample-bigtreetech-ebb-canbus-v1.2.cfg

- [CAN Bus overview by Teaching Tech (YT)](https://www.youtube.com/watch?v=5pLjeQz9pEI) 
  - https://github.com/meteyou/KlipperMisc

#### Build and Flash CANBoot firmware onto EBB36
- https://maz0r.github.io/klipper_canbus/toolhead/ebb36-42_v1.1.html
- https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/17?u=azab2c


#### Build and Flash CANBoot and Klipper firmware onto Octopus

- https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/5?u=azab2c

https://klipper.discourse.group/t/octopus-pro-canboot-can-bus-bridge/3734/30?u=azab2c

- Created CANBus wire using 24 AWG Cat 5 cable.  
- Tested wire continuity/resistance. 
- Connected and powered up.



- NEED TO BUY:
  - PTFE 4mm+ ID, ~6 OD, maybe high temp silicone?

- TODO:
  - TODO: Change buad rate from 250000 to 500000 (make menuconfig and mainsail config?)
  - TODO: Read https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/2
  - TODO: *Maybe* Read https://github.com/Esoterical/voron_canbus
  - TODO: *Maybe* Read Voron Discord #can_bus_depot https://discord.com/channels/460117602945990666/1076243803947667516
  - Misc conversations suggesting to use U2C (USB to CANBUS adapter) since that'll be more reliable than
  - CANBUS protocol uses 2 wire high-low [Differential_signalling](https://en.wikipedia.org/wiki/Differential_signalling), so twisted pair of stranded wire is best.  AWG22 or thicker??? to carry ~50W (24v at ~2amp) for hot-end, fans, sensors, BL touch, etc...
https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/sample-bigtreetech-ebb-canbus-v1.2.cfg


### CANBus wiring

Was going to use a [stranded Cat-6 Ethernet Patch cable](https://www.amazon.com/gp/product/B01INRUFGK) I have already.  Despite being very popular with ~122,000 reviews, am not going to use after cutting and examining the wires to learn they're just ~26 AWG, or thinner even...

Instead am using Cat 5 24AWG stranded copper.  One pair for CANBus high/low, two pairs for power.  Grounded the final pair with the naive hope of helping shield comms.  Only grounded at end closest to controller

problem: CanBoot scripts failing, ifconfig not listing can0
cause: ???
context:
- Related? https://github.com/Arksine/CanBoot/issues/69

actions:
- Edited ```/etc/rc.local``` per https://github.com/Arksine/CanBoot/issues/72#issuecomment-1501347910
- Looked up what "allow-hotplug" does.  Considered changing to "auto", but am wondering whether lack of can0 indicates EBB and/or Octopus USB-to-CAN bridage CANBus device is not being detected, and/or Klipper printer.cfg isn't configured to enable CAN even if the build is.  Am questioning everything at this point given how long root causing missing can0 is taking.
- Powered off.  Added jumper to EBB's 120R pins.  Powered on.


```
sudo apt-get update
sudo apt-get upgrade
```

cd ~/CanBoot
make clean
make menuconfig
Configure CanBoot to build for Octopus v1.1 :
```
    Micro-controller Architecture (STMicroelectronics STM32)  --->
    Processor model (STM32F446)  --->
    Build CanBoot deployment application (Do not build)  --->
    Clock Reference (12 MHz crystal)  --->
    Communication interface (USB (on PA11/PA12))  --->
    Application start offset (32KiB offset)  --->
    USB ids  --->
()  GPIO pins to set on bootloader entry
[*] Support bootloader entry on rapid double click of reset button
[ ] Enable bootloader entry on button (or gpio) state
[ ] Enable Status LED
```
make
mv out/canboot.bin octopus_canboot.bin

make clean
make menuconfig
Configure CanBoot to buildd for EBB v1.2 :
```
    CanBoot Configuration v0.0.1-43-g10cc588
    Micro-controller Architecture (STMicroelectronics STM32)  --->
    Processor model (STM32G0B1)  --->
    Build CanBoot deployment application (Do not build)  --->
    Clock Reference (8 MHz crystal)  --->
    Communication interface (CAN bus (on PB0/PB1))  --->
    Application start offset (8KiB offset)  --->
(500000) CAN bus speed
()  GPIO pins to set on bootloader entry
[*] Support bootloader entry on rapid double click of reset button
[ ] Enable bootloader entry on button (or gpio) state
[ ] Enable Status LED

```
make clean
make
mv out/canboot.bin ebb_canboot.bin
```

- Added jumper to Octopus boot0, reset Octopus, should go into DFU mode.
- Check Octopus is in DFU mode via ```lsusb```, verify output contains ```0483:df11 STMicroelectronics STM Device in DFU Mode```.  Note ```0483:df11``` is common, but could change.  If you see a different Identifier, be sure to use that instead for the instructions that follow.
- Use dfu-util to upload octopus_canboot.bin and octopus_klipper.bin, follow steps described in https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/5?u=azab2c
  ```
  sudo dfu-util -a 0 -D ~/CanBoot/octopus_canboot.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11
  ```
  ```
  sudo dfu-util -a 0 -D ~/klipper/octopus_klipper.bin --dfuse-address 0x08008000:leave -d 0483:df111
  ```
- Remove Octopus boot0 jumper and reset.
- Query CANBus status, checks can0 interface is working and that CanBoot on Octopus is running...
    ```
    cd ~/CanBoot/scripts
    python3 flash_can.py -q
    ```
- Flash Klipper to Octopus via CanBoot serial command
```
cd ~/CanBoot/scripts
pip3 install pyserial
python3 flash_can.py -f ~/klipper/octopus_klipper.bin -d <serial_device>
```

```
~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0
```

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
- Flash CanBoot firmware to EBB36...
```
sudo dfu-util -a 0 -D ~/CanBoot/ebb_canboot.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11 

!!! Attempt #2 with 250K baud...

sudo dfu-util -a0 -D ~/CanBoot/ebb_250k_canboot.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 0483:df11


```
- <mark>???  Flash Klipper firmware to EBB36...
```
sudo dfu-util -a 0 -D ~/klipper/ebb_klipper.bin --dfuse-address 0x08008000:leave -d 0483:df11
```
- Power down EBB36.  Remove USB-C cable from Pi to EBB.  
- Remove VUSB jumper.  Add 120R jumper.  
- Connect fan to EBB36.  Consider delaying connecting other components to EBB36 until getting fan connected to EBB36 working.
- Connect CANBus cable.
- Ensure USB-C (re)connected from Pi to Octopus
- Reset Octopus
- Verify


**Alternatively... ** try uploading klipper without bootloader to EBB

sudo dfu-util -a 0 -D ~/klipper/ebb_noboot_klipper.bin --dfuse-address 0x08000000:force:mass-erase -d 0483:df11


python3 ~/CanBoot/scripts/flash_can.py -f ~/klipper/ebb_klipper.bin -u 127081e7e3c6


## Futures:
- WaveShare 7" or similar screen
  - Setup info at https://klipper.discourse.group/t/skr-3-ebb-can-bus-klipperscreen-working/4840
