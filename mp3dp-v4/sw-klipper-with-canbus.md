## <big>Software</big>

This doc mainly shares notes/resources on getting Klipper, MainSail installed and configured with my Octopus, RaspberryPi, CANBus setup.

### Klipper Install
Related:
- https://github.com/bigtreetech/EBB repo contains documentation.  Read the docs for the model and version you have...
  - For my EBB 36 v1.2 ...
    - Found Docs https://github.com/bigtreetech/EBB#ebb36--42-can-v12, which are mostly same as v1.1
    - Found Klipper config fragment with pin mappings at https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/sample-bigtreetech-ebb-canbus-v1.2.cfg

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
- TODO:
  - TODO: Change buad rate from 250000 to 500000 (make menuconfig and mainsail config?)
  - TODO: Read https://klipper.discourse.group/t/setup-ebb36-v1-2-connected-to-octopus-pro/6617/2
  - TODO: *Maybe* Read https://github.com/Esoterical/voron_canbus
  - TODO: *Maybe* Read Voron Discord #can_bus_depot https://discord.com/channels/460117602945990666/1076243803947667516
  - Misc conversations suggesting to use U2C (USB to CANBUS adapter) since that'll be more reliable than
  - CANBUS protocol uses 2 wire high-low [Differential_signalling](https://en.wikipedia.org/wiki/Differential_signalling), so twisted pair of stranded wire is best.  AWG22 or thicker??? to carry ~50W (24v at ~2amp) for hot-end, fans, sensors, BL touch, etc...
https://github.com/bigtreetech/EBB/blob/master/EBB%20CAN%20V1.1%20(STM32G0B1)/sample-bigtreetech-ebb-canbus-v1.2.cfg

- [CAN Bus overview by Teaching Tech (YT)](https://www.youtube.com/watch?v=5pLjeQz9pEI) 
  - https://github.com/meteyou/KlipperMisc
