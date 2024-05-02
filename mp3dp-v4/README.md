﻿Sharing notes/questions for my (likely slow) MP3DP v4 build, will periodically update as I make progress.  Appreciate all the info people have been sharing, hoping my aggregated notes here helps others.  This'll be a lagged snapshot of what I'm frequently pushing to [github](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4).


# <big>MP3DP v4 (aka Repeat v2)</big> <small>— 3D Printed, CNC'd CoreXY 3D Printer</small>

Tracking plan/tasks/actions in my [build Log](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4/build-log.md).  Intending this doc to end up evolving into fleshed out structured notes.

See Official V1E [MP3DP V4 Docs](https://docs.v1e.com/mp3dp), they reference :
-  [*Repeat V2* forum thread](https://forum.v1e.com/t/repeat-v2/33330) containing design process/updates/feedback. 
- [Fusion 360 hosted Design](https://myhub.autodesk360.com/ue29a24ab/g/shares/SH35dfcQT936092f0e43b20f88cb61d3441a), export/download and print these parts for latest greatest design.  Related forum post is [here](https://forum.v1engineering.com/t/repeat-v2/33330/85?u=vicious1).
  - *IF* you open/import the model in Fusion 360 desktop app, you will be looking at a snapshot.  The imported snapshot will not get updated if/when Ryan makes additional updates.  So, you may need to reimport every so often if you're wanting to absorb latest edits, and then make dimension/design changes for your build.
  - Created [export-components.py](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4/scripts/export-components.py) Python script, and topic showing [How to Bulk Export parts to .STL files](https://forum.v1e.com/t/fusion-360-bulk-export-parts-to-stl-files-oriented-for-3d-printing-via-python/37217).  ~~Included a snapshot of exported .STLs in the [/models](https://github.com/aaronse/v1engineering-mods/tree/main/mp3dp-v4/models) subfolder.~~  
    - As-is models will need orienting before splicing and printing.
- [Printable](https://www.printables.com/model/282346) .STL files will be stable, but not latest.

<mark style=opacity:0.4>&nbsp;**Note:** Until full Official v4 docs are available, reading through v3 docs (albeit a different design) for general guidance will help.  For example v3 [printed parts docs](https://docs.v1e.com/mp3dp/version3index/#printed-parts) has info that applies to v4 too.</mark>

<table style="width:100%" border=0><tr>
<td with="33%">

![image](https://docs.v1e.com/img/mp3dpv4/mp3dpv4_1.jpg)

</td>
<td width="33%">

![image](https://docs.v1e.com/img/mp3dpv4/mp3dpv4_3.webp)

</td>

<td width="33%">

![image](https://docs.v1e.com/img/mp3dpv4/MP3DP%20v4%20v52.png)

</td>
</tr>
<tr>
<td colspan=3 style="text-align:right">

Pics from [V1E.com](https://docs.v1e.com/mp3dp)

</td>
</tr>
</table>

## Pics / Gallery
- 23-01-30 Ryan's pics https://forum.v1e.com/t/mp3dp-v4-bom/35315/40?u=azab2c



## <big>WHY BUILD ONE?</big>
Mostly Fun, and, maybe profit.  Have an Ender 3 Max, great machine but has limited speed/quality/temps.  Want something faster and capable of other printing other materials, not just higher temp ASA/ABS/PC, but TPU will be easier with direct drive instead of bowden.  CoreXY frame/motion has [misc benefits](https://www.google.com/search?q=cartesian+versus+corexy+3d+printer) over my Cartesian Ender 3 design.

Super secret goal, arguably the most important one...  is to inspire and lure the kids into 3D printing, a gateway to becoming a Maker...

### Why others built one...
- Dan/SupraGuy perspective @ https://forum.v1e.com/t/mp3dp-v2/37092/7?u=azab2c
- [Misc perspectives, great Q's from @ orob and others](https://forum.v1e.com/t/v3-vs-v4-3dp-build-part-list/37014)

### Low Cost (Parts, not labor...)

TBD...

### Quality / Speed / Reliablity
Ryan/V1E relies on these to run his business, so that says a lot.

Related:
- Kirk's speed testing https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967/7?u=azab2c


### Alternatives considered :
- https://vorondesign.com/ too $$$, $1800-$2000
  - [Voron Trident Manual](https://raw.githubusercontent.com/VoronDesign/Voron-Trident/main/Manual/Assembly_Manual_Trident.pdf), comprehensive 319 pages!
- https://us.ratrig.com/3d-printers/v-core.html too $$, $1100
- [https://bambulab.com/en/x1](https://bambulab.com/en/x1) easy to use $$ + closed bambu x1 carbon
  - [Specs](https://us.store.bambulab.com/products/x1-carbon-combo)
  - Build Volume (W×D×H)
    256 × 256 × 256 mm³
  - Physical Dimensions
    389 × 389 × 457mm
  - Frame overhead 133 x 133 x 201
- https://www.pantheondesign.com
  - [Marga Cipta acrylic](https://www.margacipta.com/)
- [RailCore](https://railcore.org/) too $$$
  - [BOM](https://docs.google.com/spreadsheets/d/1sxKl6h23SXfuNM7hNiX35rIrpISw8AruEEcNl2Fvibk/edit)



All that said, am biased toward building MP3DP v4 largely because of the V1E community support.  To me, the V1E mindset is focused on getting great quality results for great value.  This resonates with me more than paying a significant premium for something that pushes the limits, and may involve lots of maintenance.  Creating, experimenting and extending is more fun than maintaining.

# <big>SIZING</big>
- Default design is for 200mm x 200mm x200mm (not common).
  - Smaller builds like this are more rigid, so better-quality/faster.

- Sizing related thoughts/considerations:
  - [Dan](https://forum.v1e.com/t/mp3dp-v4-bom/35315/66)... _200mm^3 is good all-purpose, but linear rails may be easier to source for 250mm^3_ 

- Calculate dimensions for your build using A) Math and/or B) Fusion 360 parameters:
  - A) MP3DP v4 dimensions math...

    <mark>TODO: Clarify</mark>

      ```javascript
      Linear Rail X = Usable X + 100mm
      Linear Rail Y = Usable Y + 50mm
      Linear Rail Z = Usable Z + ~50mm (**)
      
      Extrusion Frame Length X = Usable X + 170mm
      Extrusion Frame Length Y = Usable Y + 145mm
      Extrusion Frame Length Z = Usable Z + ~145mm

      Linear Rail Cut list...

      Extrusion Cut list...

      3 x Extrusion Frame Length X
      8 x Extrusion Frame Length Y
      3 x Extrusion Frame Length Z

      Belt Cut List...

      e.g. Buy 5m for Usable 300mm^3
  
      3 x (Usable Z + 150mm ) +
      1 x (4 x (Usable X + 200mm)) + (4 x (Usable X + 50))

      ```

      (**) Z dimension is approximate, can vary depending on bed mounting thickness.

      References: [Dan](https://forum.v1e.com/t/mp3dp-v4-bom/35315/17?u=azab2c)

  - B) Change dimensions Use Change [model parameters](https://forum.v1e.com/t/repeat-v2/33330/163?u=azab2c)





# <big>BOM / PARTS</big>

**Read:** https://forum.v1e.com/t/mp3dp-v4-bom/35315/79?u=azab2c

Related:
- [MP3DP v4 BOM](https://forum.v1e.com/t/mp3dp-v4-bom/35315/79) forum topic

### PARTS
Related:
- Ryan's BOM https://forum.v1e.com/t/repeat-v2/33330/85?u=azab2c
- Voron part sourcing guide https://vorondesign.com/sourcing_guide?model=V2.4.  Sections below are inspired by [Voron generated BOM](misc/voron_generated_bom.csv).


Solved the MP3DP v4 BOM Puzzle thanks to folks in [this Topic](https://forum.v1e.com/t/mp3dp-v4-bom/35315/79?u=azab2c).  Using the following info:
- MP3DP v4 [Forum Topic](https://forum.v1e.com/t/repeat-v2/33330/121) | [Fusion 360 model](https://myhub.autodesk360.com/ue29a24ab/g/shares/SH35dfcQT936092f0e43b20f88cb61d3441a)
- [MP3DP v4 Pics of Ryan's builds](https://forum.v1e.com/t/mp3dp-v4-bom/35315/40)
- [V1E Shop 3D Printer Parts](https://www.v1e.com/collections/3dprinter-parts)
- [MP3DP v4 community builds](https://forum.v1e.com/t/mp3dp-v4-azas-build/37251#bv4b-builds-24) have stumbled across.
- MP3DP v3 [Forum Topic](https://forum.v1e.com/t/new-printer-time/28127) | [Fusion 360 model](https://a360.co/381SaiQ) | [Docs / Parts](https://docs.v1e.com/mp3dp/version3index/#specialty-parts)


## V1E Shop Parts
Parts listed for purchase from V1E Shop.  Alternative links provided incase parts out of stock, and/or you're purchasing from other place(s).

|QTY  |Description             |Comment                          |Link                        | 
|-----|------------------------|---------------------------------|----------------------------|
|1    |** SKR Pro 1.2 Control Board           |6 driver minimum (for 5 motion steppers + 1 direct drive extruder)                |[Shop][sh1] – [Amazon][az1]|
|6    |TMC 2209|Buy 6 drivers if not supplied with Controller board|[Shop](https://www.v1e.com/products/trinamic-tmc-2209-v1-2-uart-drivers?_pos=2&_sid=5072eafe8&_ss=r)|
|5    |Steppers, Nema17 |76OZ/in, e.g. KL17H248-15-4A               |[Shop][sh2] – [Amazon][az2]|
|5    |*** Pulleys 16T 10mm        |10mm GT2 16 Tooth                |[Shop][sh4] – [Amazon][az4]|
|6    |*** Idlers w/Teeth 20T      |20T w/Teeth 5mm Bore             |[Shop][sh5] – [Amazon][az5]|
|8    |*** Idlers Smooth 20T       |20T Smooth 5mm Bore              |[Shop][sh6] – [Amazon][az6]|
|5m for 300m^3</mark>    |**** Belt GT2 10mm           | **No steel** belt |[Shop][sh7] – [Amazon][az7]|
|2|Omron Limit switch, endstop         |Use Omron or red rollers     |[Shop][sh8] – [Amazon][az8]|
|3|Springs                 |For bed, silicon tube will work  |[Shop][sh11] – [Amazon][az11]|
|*    |Thread locker           |Optional for grubs screws        |[Shop][sh15] – [Amazon][az15]|
|*    |Lube                    |Optional for idlers              |[Shop][sh16] – [Amazon][az16]|
|*    |PTFE Tube               |Optional Extruder to filament    |[Shop][sh17] – [Amazon][az17]|
|*    |Print Fan               |Optional fits hemera mount       |[Shop][sh18] – [Amazon][az18]|
|6|Stick on Stepper temp gauge|Optional| [Shop](https://www.v1e.com/collections/3dprinter-parts/products/stick-on-temp-gauge)
|1| ESP-01s ESP3D headless|Optional  Wifi dongle for SKR Pro 1.2| [Shop](https://www.v1e.com/collections/3dprinter-parts/products/esp-01s-esp3d-espui-headless)
|6| 3/8" wire sleeve| Optional| [Shop](https://www.v1e.com/collections/3dprinter-parts/products/wire-sleeve)
|1| 50mm PTFE liner|Optional, need more if building bowden setup|[Shop](https://www.v1e.com/collections/3dprinter-parts/products/ptfe-liner)


[sh1]: https://www.v1e.com/collections/3dprinter-parts/products/skr-pro1-2-6x-2209-drivers-tft35-e3-v3
[sh2]: https://www.v1e.com/collections/3dprinter-parts/products/nema-17-76oz-in-steppers
[sh4]: https://www.v1e.com/collections/3dprinter-parts/products/pulley-16-tooth-gt2-10mm
[sh5]: https://www.v1e.com/products/idler-10mm-20t-5mm-bore
[sh6]: https://www.v1e.com/collections/3dprinter-parts/products/20t-idler-gt2-10mm
[sh7]: https://www.v1e.com/collections/3dprinter-parts/products/gt2-10mm-belt
[sh8]: https://www.v1e.com/products/limit-switch-endstop
[sh9]: https://www.v1e.com/collections/zenxy/products/v-wheel
[sh11]: https://www.v1e.com/collections/3dprinter-parts/products/spring
[sh13]: https://hobbyking.com/en_us/carbon-fibre-square-tube-20-x-20-x-800mm.html
[sh15]: https://www.v1e.com/collections/3dprinter-parts/products/0-5ml-threadlocker-242
[sh16]: https://www.v1e.com/collections/3dprinter-parts/products/super-lube-silicone-lubricating-grease-with-syncolon-ptfe
[sh17]: https://www.v1e.com/collections/3dprinter-parts/products/ptfe-liner?variant=39521587331187
[sh18]: https://www.v1e.com/collections/3dprinter-parts/products/5015-12v-fan-blower


[az1]: https://amzn.to/3mp6nOk
[az2]: https://amzn.to/3FcxGlE
[az4]: https://amzn.to/3n9mUGM
[az5]: https://amzn.to/31HTnwa
[az6]: https://amzn.to/3JXAXJi
[az7]: https://amzn.to/3u5imW6
[az8]: https://amzn.to/396oRzi
[az9]: https://amzn.to/33WT0yo
[az11]: https://amzn.to/3G9HFcG
[az13]: https://amzn.to/34HCnHL
[az15]: https://amzn.to/3GhaKmx
[az16]: https://amzn.to/31H7yS6
[az17]: https://amzn.to/3f5Ml7E
[az18]: https://amzn.to/3Fq3Vy1


As an Amazon Associate Ryan earns from qualifying purchases.

** Personally, am using [Octopus 1.1](https://biqu.equipment/collections/control-board/products/bigtreetech-octopus-pro-v1-0-chip-f446?variant=39585170096226) instead of SKR 1.2 for my build, will have more Mod options, but will be more work to setup.  SKR 1.2 and Rambo have better Community support.

*** Pulley/Idler break down :
  - 6 Pulleys 16T 10mm.  
    - 6 = 6 x 1 per Stepper.
  - 6 Idlers w/Teeth 20T
    - 4 = 2 x 2 per Left/Right rear corner
    - 2 = 2 x 1 per XY Left/Right
  - 8 Idlers Smooth 20T
    - 6 = 3 x 2 per Z post
    - 2 = 2 x 1 per XY Left/Right

**** Belt Calculations, cut list :
- 3 x (Usable Z + 150mm )
- 1 x ( (4 x (Usable X + 200mm) ) + (4 x (Usable X + 50) ) )


## Parts not listed on V1E Shop

### Fasteners
Related
- Dan's Frame Assembly [describes bolts/nuts/corners used](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/8?u=azab2c)


|QTY  |Description             |Comment                          |Link                        | 
|-----|------------------------|---------------------------------|----------------------------|
|
|???|M3x8|- Linear rails all use M3x8<br/>&nbsp;&nbsp;- (x+100+(2 * (y+ 50) + 3 * (z + 50)) / 25<br/>&nbsp;&nbsp;- Excel...  =(A1+100+2*(B1+50)+3*(C1+50))/25<br/>&nbsp;&nbsp;- e.g. 62 for 200mm^3<br/>- One stepper mount marked with an "8"||
|
|???|M2.5x12|- Endstops||
|
|???|M3x10mm|||
|~113|M3 or M5 Button head by 8+ mm|- 4 x 25 Side/Back/Bottom Panels<br/>- 13 Front lower Panel<br/>- [(M5's will have less wiggle room)](https://forum.v1e.com/t/mp3dp-v4-bom/35315/101?u=azab2c)<br/>- 8mm for 1/8" panels, 10mm for 5.5mm+ (e.g. 1/4")<br/>- Measure/check length needed for panel thickness|Panel bolts||
|???|M5x30mm|||
|???|M5 Slide in Nuts|- Use slide-in nuts, [rotating T-Nuts are horrible](https://forum.v1e.com/t/repeat-v2/33330/246?u=azab2c)|[amzn](https://www.amazon.com/KOOTANS-Thread-Aluminum-Extrusions-Profiles/dp/B07PNV8SWZ)|




### Motion
Related
- Ryan/ @ Barry99705 reco [filastruder](https://forum.v1e.com/t/new-printer-time/28127/634?u=azab2c)
- @ Barry99705 reco [LDO Linear Rails](https://forum.v1e.com/t/new-printer-time/28127/633?u=azab2c)
- MP3DP v3 reco [Amazon](https://amzn.to/3HLM85I)
- Ryan reco [CHUANGNENG MGN12H](https://forum.v1e.com/t/mp3dp-v4-bom/35315/123?u=azab2c)
  - Dimensions:
  ![Image](https://m.media-amazon.com/images/I/71ey3qJw1tL._SL1500_.jpg)

|QTY  |Description             |Comment                          |Link                        | 
|-----|------------------------|---------------------------------|----------------------------|
|1  | X Linear rail MGN       | Usable X + 100mm MGN12H|[Fila][sh12] – [Amazon][az12] (select correct dimensions)|
|2  | Y Linear rails MGN       | Usable Y + 50mm MGN12H|[Fila][sh12] – [Amazon][az12] (select correct dimensions)|
|3  | Z Linear rails MGN       | Usable Z + ~50mm MGN12H|[Fila][sh12] – [Amazon][az12] (select correct dimensions)|

[sh12]: https://www.filastruder.com/products/ldo-linear-rails?variant=31796304150599
[az12]: https://amzn.to/3FSNAoj


### Electronics
|QTY  |Description             |Comment                          |Link                        | 
|-----|------------------------|---------------------------------|----------------------------|
|1    |Extruder or other tool   |Hemera,example, match voltage, 24V is good.<br/>BIQU H2 or BIQU H2S REVO    |[Fila][sh3] – [Amazon][az3]|
|1    |Power Supply            |Match voltage to your setup <br/>e.g. MEANWELL LRS-350-24|[Fila][sh14] – [Amazon][az14]|
|1    |Heated Bed              |Style and Size will vary         |[Shop][sh10] – [Amazon][az10]
|1    |BL Touch Probe|||
|1    |Pi 4 or at least 3+|Klipper/OctoPi controller|Good luck!|
|1    |Micro SD||
|1    |Display|BIGTREETECH TFT35 E3 V3.0.1|[BIQU](https://biqu.equipment/collections/latest-deal/products/btt-tft35-e3-v3-0-display-touch-screen-two-working-modes?variant=40099686318178) – [Amzn](https://www.amazon.com/BIGTREETECH-TFT35-E3-V3-0-1-Motherboard/dp/B08182XHZZ)|
|1    |Adaptor Board|BigTreeTech EBB 36/42 Can Bus<br/>[BIQU](https://biqu.equipment/products/bigtreetech-ebb-36-42-can-bus-for-connecting-klipper-expansion-device) – 

[sh3]: https://www.filastruder.com/collections/e3d-hemera/products/e3d-hemera?variant=39486550507591
[sh10]: https://www.v1e.com/collections/3dprinter-parts/products/mk3-aluminum-heated-bed
[sh14]: https://www.filastruder.com/products/meanwell-lrs-350-24-psu?_pos=3&_sid=4a733ffaa&_ss=r

[az3]: https://amzn.to/3tdtnE9
[az10]: https://amzn.to/3FgVRPM
[az14]: https://amzn.to/31OsAOY




### BuildPlate
- Triangle'sh Bed Support Plate is supported by each Z Post,
  - 1/4" MDF https://forum.v1e.com/t/mp3dp-v4-bom/35315/116?u=azab2c
Alu?
https://forum.v1e.com/t/mp3dp-v4-bom/35315/116?u=azab2c

### Frame


- Consider Zyltech, Ryan(and others?) [had bad experience](https://forum.v1e.com/t/repeat-v2/33330/129?u=azab2c) with Amzn extrusion.
  - Reco for [Zyltech Alu Extrusion kit](https://forum.v1e.com/t/repeat-v2/33330/243?u=azab2c)
  - https://www.zyltech.com/10x-1m-2020-t-slot-aluminum-extrusion-kit-w-hardware-brackets-screws-nuts/?sku=EXT-2020-REG-COMBO

- Corner Brackets [Forum reco Jeffeb](https://forum.v1e.com/t/mp3dp-v4-bom/35315/46?u=azab2c)


### Panels
Related
- Matt reco [overcut finger joint corners for snug fit](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/5?u=azab2c)

- Material options
  - 6mm /1/4" Plywood
  - Acrylic/Polycarbonate
  - [ACM](https://forum.v1e.com/t/mp3dp-v4-bom/35315/52?u=azab2c) (aluminium-plastic-aluminium sandwich) great stable material, but $$$.
    - [Reco](https://forum.v1e.com/t/mp3dp-v4-bom/35315/109?u=azab2c) for piedmontplastics.com
  - [Sheet Metal?](https://forum.v1e.com/t/cutting-sheet-metal/7878/12?u=azab2c)
    - ~0.2mm thin, so need M3 x 6mm Button Flanged bolts to fasten.
  - [IPA degrades Acrylic](https://forum.v1e.com/t/first-layer-issues/37289/18?u=azab2c), so consider Polycarbonate.


### Cables

???

### Vibration Management

???

### Misc

???


### Extruder Options
- #### Hemera 
  [amzn](https://www.amazon.com/Genuine-E3D-Hemera-1-75mm-Direct/dp/B0829DHHPK) or BiQU H2 V2 (170g lighter)

- Octopus 
  - MP3DP needs 6 drivers/steppers, Octopus is oversized with 8 drivers, am using because 1) am familiar with the board already, 2) will have 2 more slots for mods.

  #### BIQU H2
  https://www.youtube.com/watch?v=zyKH05bBs4Q
  https://github.com/bigtreetech/H2-Series
  - Related 3D Models
    - MJLaverty's https://forum.v1e.com/t/mp3dp-repeat-h2-build/32485

  #### BIQU H2S Revo
  - Teaching Tech review https://www.youtube.com/watch?v=4X1F-dLVT3gt=214 
  - V1E MP3DP to BIQU H2S Adaptors/Carriage mounts
    - 2023/08/09 @probrwr's https://www.printables.com/model/544033-mp3dp-v4-rail-mount-for-biqu-h2vs-revo
    - 2023/04/14 @probrwr's https://www.printables.com/model/452491-mount-to-adapt-biqu-h2-revo-to-hemera-mount
  - BTT's H2 V2S Revo 4020 fan duct @
    https://github.com/bigtreetech/H2-Series/blob/master/H2%20V2s%20Revo/H2%20V2S%20Revo%204020%20fan%20duct.STL
  - Related 3D Models, see Printables, [search for BIQU Revo](https://www.printables.com/search/models?q=Biqu%20revo)
    - Nice detailed BIQU H2 V2S REVO model https://www.printables.com/model/578825-biqu-h2-v2s-revo-hyper-detail/files
    - Fan Ducts/Shrouds :
      - https://www.printables.com/model/396716-biqu-h2-revo-part-cooler-5015-bl-touch-mount
        - Supports Fan and BL Touch Probe, leaves extruder fan clear enabling easier removal when clogged.
      - Fan Duct suggestions by Teaching Tech video
        - https://www.thingiverse.com/thing:4749419
        - https://www.thingiverse.com/thing:4682915
    - Radial Fan 5015 model https://www.printables.com/model/264959-5015-radial-fan-3d-model-for-conception-step-stl-f/files

  - @probrwr has [BiQU H2S Revo](https://biqu.equipment/collections/extruder-hotend-heatsink-j-heat/products/biqu-h2-v2s-revo-extruder) and @gpagnozzi has [BIQU H2 V2.0](https://biqu.equipment/products/biqu-h2-v2-0-extruder?variant=39821278347362)?


#### E3D Hemera<br/>
![image](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4/img/e3d-hemera-dimensions.png?raw=true)

#### BIQU H2 V2.0<br/>
![image|409x500](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4/img/biqu-h2-v2.jpeg?raw=true)


#### BIQU H2 V2S REVO [Manual](https://cdn.shopify.com/s/files/1/1619/4791/files/H2V2S_Revo_User_Manual.pdf?v=1662011632)<br/>
![image|302x500](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4/img/biqu-h2-v2s-e3d-revo.jpeg?raw=true)



  $120 https://www.aliexpress.us/item/3256804514365855.html

  Octopus
  https://www.aliexpress.us/item/3256802425039425.html

  TMC2209
  https://www.aliexpress.us/item/2251832860926249.html

 

 


### 3D PRINTED PARTS
- Used PETG (like Dan), may reprint with ASA using MP3DP v4.  Ryan prints with PLA.
- Using Overture Transparent Red PETG](https://www.amazon.com/gp/product/B07YCNCZ5J
  - My Cura Settings: 0.6noz, 3 wall, 35% gyroid infill.
  - Ryan says [40% is probably really good](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/82?u=azab2c).
  - Dan's used [0.5mm Noz, 2 walls, 30% adaptive cubic infill](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/83?u=azab2c)


# <big>Assembly</big>
<mark>TODO:</mark>
Related
- Until v4 docs available, reading through [v3 Assembly doc](https://docs.v1e.com/mp3dp/version3assm/) will help.
- Ryan ["Backplate is the reference"](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/149?u=azab2c)

### Frame Assembly
- Dan's Frame Assembly [describes bolts/nuts/corners used](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/8?u=azab2c)



###
https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/9?u=azab2c

#### Z Post Assembly

![image](upload://wNtXJrqrnPfOYQm5U0xML6a7TkA.jpeg)

![image](https://us2.dh-cdn.net/uploads/db5587/original/3X/c/2/c25f261c6faacd4306bf5eb2a19b477418a57efc.jpeg)


### Squaring/Aligning rails
- See Matt's build @ https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/153?u=azab2c

### Wiring
Related :
- [Voron V2 Octopus Wiring guide](https://docs.vorondesign.com/build/electrical/v2_octopus_wiring.html).
- [Klipper Octopus config template]https://github.com/Klipper3d/klipper/blob/master/config/generic-bigtreetech-octopus.cfg

https://github.com/bigtreetech/BIGTREETECH-OCTOPUS-V1.0/blob/master/Hardware/BIGTREETECH%20Octopus%20-%20PIN.pdf



- [Dan recos](https://forum.v1e.com/t/repeat-v2/33330/374?u=azab2c) routing wiring to Z Post M Steppers along the Bed Support Plate, use misc holes in the plate to secure wiring, including providing strain relief for heater bed wiring.
- [Stepper motor to driver slots mapping](https://forum.v1e.com/t/not-another-mp3dp-v4/37429/133?u=azab2c)

#### Wiring Raspberry PI

- For my build, am using a small [LCD TFT 3.5" (320x480) GeeekPi Touch Screen](https://www.amazon.com/gp/product/B083C12N57/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1), may upgrade to larger higher res later...
  - [Specs and pinouts](http://www.lcdwiki.com/3.5inch_RPi_Display) and [Specs](wiki.52pi.com/index.php?title=K-0403)
  - [Driver](https://github.com/goodtft/LCD-show)
  - Adhere heat sinks with thermal paste.  Check sufficient clearance between heatsink, fan and TFT.
  - Mount Fan, TFT screen, and standoffs to support TFT screen.
  - Install/configure driver, see product [page](https://www.amazon.com/gp/product/B083C12N57/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1) and/or manual.
  - Check temp ```vcgencmd measure_temp```

#### Wiring Endstops
- Related:
  - [Ryan - Use signal and ground for endstops, do **NOT** use power](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/172?u=azab2c)


### Bed Assembly

Steve's Builds shows how to prep and adhere heater bed and magnet layers to Alu plate
https://www.youtube.com/watch?v=dnAZ1nw6Euk&t=13194s

# <big>Software</big>

Stock MP3DP v4 builds use Marlin and straight forward separate bundle of wiring from the Controller board, to all the hotend components, e.g. Hot End, extruder, Thermister, Fan(s), BL Touch, etc...  

For my build, am instead going use this opportunity to learn about Klipper and CANBus.  I want to benefit from the kinematic support, and reduce wiring/weight to the hotend.  So, am investing significant additional time and effort into digging into those areas.  Given what's involved am sharing details/notes in a separate [klipper-with-canbus](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4/sw-klipper-with-canbus.md) doc.


#### Pre/Post Print GCODE configuration changes

- Edit Post print config to Power down and/or resets will cause bed to crash down.  See ["gcode needs to park the z axis at zmax"](https://forum.v1e.com/t/repeat-v2/33330/45?u=azab2c)

### Done!

Print something, consider sharing your build details, build journey, and claim a [MP3DP serial number](https://forum.v1e.com/t/mp3dp-repeat-serial-number-log/29525) for posterity's sake.


# <big>Troubleshooting Printing Issues</big>
Some troubleshooting related topics/posts:
- https://forum.v1e.com/t/mp3dp-v4-build/36437/475?u=azab2c



# <big>MP3DP v4 V1E Community builds / builders</big>

Some of the [Community MP3DP Build Logs](https://forum.v1e.com/search?expanded=true&q=%23mostly-printed-3d-printer-mp3dp%3Ayour-builds-mp3dp%20order%3Alatest_topic) that helped me.

### <b>v4</b> builds

- @SupraGuy 200/235mm^3 ??? https://forum.v1e.com/t/mp3dp-v4-build-plog/36010?u=azab2c
    - Extrusion [Cut List](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/8?u=azab2c) :
      - 4x 345mm frame upright pieces
      - 4x 345mm frame Y axis pieces
      - 3x 370mm frame X axis pieces
      - 3x 305mm Z axis upright rails
    - [E3D Hemera hotend](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/33?u=azab2c)
    - [Dan's parts](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/3?u=azab2c)
    - [Dan's rails](https://forum.v1e.com/t/mp3dp-v4-bom/35315/21?u=azab2c), Y = Z = 300mm, X = 350mm
    - [5mm plywood Bed Support Plate, 1/2" foam](https://forum.v1e.com/t/mp3dp-v4-bom/35315/117?u=azab2c)
    - [24V](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/11?u=azab2c)
    - [Drag Chain](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/110?u=azab2c), used 10x10, but recommends 15x10, mount on [Printables](https://www.printables.com/model/395108-drag-chain-mounts-for-mp3dpv4)
- @ MattMed 200mm^3 ??? https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/142?u=azab2c
    - [E3D Hemera Direct Kit](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/213?u=azab2c)
    - Nice [Prusa slicer settings](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/221?u=azab2c) from Ryan
    - [Camera mount setup](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/231?u=azab2c) 
- @ Jonathjon 300x300x400mm https://forum.v1e.com/t/mp3dp-v4-build/36437
    - [E3D Hemera](https://forum.v1e.com/t/mp3dp-v4-build/36437/74?u=azab2c)
    - [120V 750W hot plate](https://forum.v1e.com/t/mp3dp-v4-build/36437/43?u=azab2c)
    - [120V 750W Heating Plate/Silicone Mat + Thermistor, Bed Foam foil insulation](https://forum.v1e.com/t/mp3dp-v4-bom/35315/118?u=azab2c)
- @ Kgleason's 235mm^3 https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967
    - Glass on Alu Bed
    - [E3D Hemera](https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967/5?u=azab2c)
    - [MP3DP Mod - Z Moto Brake, prevent free fall](https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967/6?u=azab2c)
    - [Belt pulling out from X carriage](https://forum.v1e.com/t/top-belt-keep-pulling-out-from-the-x-carriage-v4/37870)
- @ aali0101's 250mm^3 https://forum.v1e.com/t/repeat-v2/33330/251?u=azab2c
- @ probrwr's 235mm x 235mm x ??? https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238
    - [ZYLTech Extrusion](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/2?u=azab2c)
    - [120v Heat Pad](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/6?u=azab2c)
    - [Manta M8P, EBB36](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/25?u=azab2c)
    - [MP3DP Mod - Adapter Carrier-to-H2, with EBB36 mount](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/24?u=azab2c)
    - [BIQU H2S Revo](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/34?u=azab2c)
    - [Alu plate 6061 1/4" 12"x12" SEUNMUK](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/39?u=azab2c) from [Amzn](https://www.amazon.com/dp/B096W1L1WX?ref=ppx_pop_mob_ap_share)
    - [PEI spring steel 120vac](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/42?u=azab2c)
    - [DIN rails, 40A SSR, 120VAC 500W bed heater](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/47?u=azab2c)
    - [Parts on Printables](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/49?u=azab2c)
    - [Hemera to H2 Mount](https://forum.v1e.com/t/mp3dp-v4-extruder-hot-ends-combos-and-heated-bed-options/37331/9?u=azab2c)
    - [Cat6 flexible stranded for CAN bus](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/69?u=azab2c)
    - [Manta and EBB36 CAN Bus setup](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/80?u=azab2c)
- @ OBI's https://forum.v1e.com/t/time-to-start/36783
- @ Heath_H 300mm^3 https://forum.v1e.com/t/heaths-mp3dp-repeat-akron-oh/34817
  - 3 in 1 (multicolor, 1 nozzle/hot-end, 3 extruders)
  - [Octopus](https://forum.v1e.com/t/heaths-mp3dp-repeat-akron-oh/34817?u=azab2c)
- @ gpagnozzi https://forum.v1e.com/t/mp3dp-repeat-v3-to-v4-1-upgrade/38096
    - [Manta M8P V1.0 (No CAN) U2C and EBB42 and the H2 V2.0](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/33?u=azab2c)
    - [BIQU H2 V2.0](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/34?u=azab2c)
    - [Manta M8P Klipper config, printer.cfg](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/31?u=azab2c)
    - [Klipper print speed config](https://forum.v1e.com/t/mp3dp-repeat-v3-to-v4-1-upgrade/38096/17?u=azab2c)
    - [Start gcode with prime line, from printer.cfg](https://forum.v1e.com/t/mp3dp-v2-build/31040/127?u=azab2c)
    - [MP3DP Mod - Extruder carrier for H2, 2x 5015 fans, EBB42](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/26?u=azab2c)
- @ niget2002 300mm^3 https://forum.v1e.com/t/not-another-mp3dp-v4/37429 
    - Hemera, SKR 1.2 + TFT, BLTouch
    - [Alu 12 x 12 1/4 bed, 310 x 310 120vac 750w heating plate](https://forum.v1e.com/t/what-build-plate-to-get/36216/38?u=azab2c)
    - [DIN rail mounted Circuit breaker, Distribution, Bed heater SSR, Enclosure heater SSR, 5V PS, Pi](https://forum.v1e.com/t/not-another-mp3dp-v4/37429/129?u=azab2c)
    - [Wiring, Stepper motor to driver slots mapping](https://forum.v1e.com/t/not-another-mp3dp-v4/37429/133?u=azab2c)
    - [Heated Chamber, with Exhaust fan(s)](https://forum.v1e.com/t/not-another-mp3dp-v4/37429/171?u=azab2c)
    - [PTFE Tube Holder](https://forum.v1e.com/t/not-another-mp3dp-v4/37429/218?u=azab2c)
      - .STL model https://www.thingiverse.com/thing:5968992
      - Parts: 2x M3x12mm, M6 tube holders.  Will need M6 tap to create threads.
    - [Interior spool mount](https://forum.v1e.com/t/not-another-mp3dp-v4/37429/218?u=azab2c)
      - .STL model https://www.thingiverse.com/thing:767317/files
      - 
- @ orob https://forum.v1e.com/t/v3-vs-v4-3dp-build-part-list/37014

### <b>v3</b> builds

- @ RootsMedia's 310x310x280mm https://forum.v1e.com/t/mp3dp-repeat-take-two/33215
    - Repeat v1 with sweet ACM/PolyCarb enclosure, complete with logo engraved panels.
      - 24v Mean Well
      - Textured PEI magnetic build plate

### <b>v2</b> builds
- Dan's costs https://forum.v1e.com/t/mp3dp-v2/37092/3?u=azab2c


# <big>STATUS</big>

  ```javascript

// PRINT PARTS...
    // DONE - sort by print order
  │     2 x Z Post.3mf    2.3hrs
        Z Post M.3mf      2.3hrs
        XY Left.3mf       2.3hrs
        XY Right.3mf      2.3hrs
        Left Stepper.3mf  2hrs
        Right Stepper.3mf 2hrs
        X Carrier.3mf 4.25
        Back Corner Left.3mf  1.75hr
        Back Corner Right.3mf 1.75hrs
        2 x Tension Block XY.3mf   1hr
        6 x Z Belt Holder.3mf  6 x 0.5hr, 3hrs

        mods\probrwr-h2-mount\BIQU H2 BLTouch Mount V2.3mf
        mods\probrwr-h2-mount\H2 to Hemera Adapter v7.3mf

    // INPROGRESS

    // TODO
    
    ├───Misc 2020 clips and parts
        2020 Corner Bracket.3mf
        cable tie Wire Hanger.3mf
        Power supply bracket.3mf
        Wire Clip 90 degree.3mf
        Wire Hanger TapeTrick.3mf

    ├───MP3DP V4.1
        Bed Washer.3mf
        filament Rev Bowden Holder.3mf
        Rail Aligner.3mf

    └───TFT E3 V3
        TFT CASE V3.STL
        TFT Holder.3mf
```

## PARTS - Decisions and purchases

### HAVE / BOUGHT:
- Probe : Have unused BL Touch
- Frame: Have Black/Silver extrusion leftovers
- Wifi: Have Pi (will Klipper/OctoPi)
- Controller: Octopus v1.1
- Drivers: 5+ TMC2209 (EBB 36 has TMC2209 onboard that can drive Nema 14 in BIQU H2S V2 REVO)
- Display:  Bigtreetech TFT E3 V3.0.1
- Linear motion:  Iverntech, chose because deliver fastest and best seller...  Wasn't reco'd by forum, so could be mistake, will find out...
- Fasteners:  Rummaged, purchased, delivery pending.  Guaranteed to need more parts.
- Power Supply: MEAN WELL LRS-
350-24, enough/too-many Watts?
- Extruder: BIQU H2S V2 REVO - Paying premium for REVO to reduce effort for kids/me to change nozzle.
- Nozzle: REVO 0.6mm (for now)
- CAN Bus controller: EBB 36
- DIN Rail, bought wago 210-504 from local electrical supplier (Platt Electric Supply), cheaper/faster than online.
  - Solid State Relay (SSR) if using 120vac bed heater.
- M10 PTFE Fittings?  Check stock?
- Heater Bed with Thermistor : 
  - My current Ender 3 Max has 24v 310mm x 320mm, 4mm thick Carborundum Glass, 3mm Alu, 3mm Foam.
- Wiring

### NEED TO BUY:
- Foam gasket for panels
- Amass xt60H and/or xt30 connectors for quick release of heater bed (xt60) and CAN BUS (xt30) Power?

### NEED TO DECIDE, THEN BUY:
- Chamber fan?

###  Fastener BOM break down:
Related:
- Dan reco [fasteners](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/8?u=azab2c)

Fastener and mount parts:
- 4 M2.5 x 12mm Bolts
  - 4 = 2 x 2 Endstops
- 40 ??? M3 x 8mm Bolts (8mm for extrusion, maybe 10mm for wood/plastic panels with inserts)
  - 6 = 6 x 1 per Z Belt Holder
  - 20 = 5  x 4 per Y and Z Linear Rails (~100mm spacing)
  - 4 = 2 x 2 per Tension Block
  - 10 = 5 x 2 per Motor Block
- 44 M5 x 10mm Bolts 
  - 12 = 6 x 2 per Right Angle Corners (Z Mid extrusion)
  - 32 = 4 x 4 corner brackets x 2 nuts per Z Corner extrusion
- ??? M5 x 30mm Bolts Pan Head (reco Philips)
  - v3 required 29
- ??? M5 x Nylock Nuts
  - v3 required 29
- 30 M3 Sliding T Nuts [amzn](https://www.amazon.com/gp/product/B07PNV8SWZ)
  - 6 = 6 x 1 per Z Belt Holder
  - 20 = 5 x 4 per Y and Z Linear Rails (~100mm spacing)
  - ?? = X Linear Rails?
  - 4 = 2 x 2 per Tension Block
- 44 M5 Slide in Nuts [amzn](https://www.amazon.com/gp/product/B07PQ13LCQ)
  - 12 = 3 x 2 corner brackets x 2 nuts per Z Mid extrusion
  - 32 = 4 x 4 corner brackets x 2 nuts per Z Corner extrusion
- 20 ??? Corner Bracket Right Angle
  - 6 = 3 x 2 per Z Mid extrusion
    14 = 7 x 2 per Z Corner extrusion
- Order M5 slide in nuts
- ??? M3 12mm Button **Flange** for 1/4" (6.35mm) external panels.


- ??? M3 x 6mm Button Flanged bolts
  - 20 per Sheet Metal Panel ~0.2mm

- TODO:
  - Stepper?
  - Board Mount?
  - Fans?
  - Hot end?
  - Cable mounts/brackets?
  - PSU?
  - Panel design
    - For builds without bottom panel helping square X and Y extrusion, consider adding slotted holes (dimensioned for 2020 Corner brackets) for where bottom Y Axis extrusion meets back X extrusion.
    - Review all panels, ensure sufficient number of perimeter holes to securely fasten panel.  Perimeter bolts should be no more than 100mm apart, ideally much closer.
    - Ensure side panel perimeter holes line up with sheet metal slotted holes.
    - Doc M5 x 10mm if 2mm panel 
    - Doc M3 x 10mm if 2mm panel
  - Doors?
  - LID?

DONE:
- Model changes
  - Added top|bottom Z Belt Holders to rear, so holes can be projected onto sketch for interior rear panel.

TODO:
- Model Design changes
  - Rear panel slotted holes need to move towards center by at least __IntSidePanelsThickness
  - Front Right Corner
    - Move hole for fastening to Y axis needs move over by __IntSidePanelsThickness
    - Remove chamfer/profile following 2020, sharp 90
    - Reduce Tab depth
  - Side panel holes for stepper mounts should be slotted.  Stepper mounts need to slide to help enable adjusting belt tension.
  - 

USER PARAMETERS:
 - Usable_Depth = 250mm
 - Usable_Height = 250mm
 - Usable_Width = 250mm

PARTS:
 - 4x Frame Z corner uprights, Front|Rear Left|Right 395mm
   - Actually cut 500mm and 600mm for uprights, added 100mm below for all uprights to accomodate wiring, also added 100mm for rear upright to accomodate lid.

 - 4x Frame Y Top|Bottom Left|Right 395mm
 - 3x Frame Z Mid Left|Rear|Right 355mm
 - 3x Frame X Front|Rear Top|Bottom 420mm
 
 - 1x MGN12 X Rail  350mm
 - 2x MGN12 Y Rail  300mm
 - 3x MGN12 Z Rail  300mm
 

## Mods

### Assimilated Voron Parts 
- [Voron Trident GNU License](https://github.com/VoronDesign/Voron-Trident/blob/main/LICENSE)
- [Voron Trident Manual](https://github.com/VoronDesign/Voron-Trident/raw/main/Manual/Assembly_Manual_Trident.pdf)

<mark>
C:\Projects(NAS)\Make.V1E_RepeatV2\alt\Assembly_Manual_Trident.pdf
</mark>

- DIN Rails assembly, see "DIN RAILS" in manual.
  - [Voron-Trident > STLs > ElectronicsBay](https://github.com/VoronDesign/Voron-Trident/tree/main/STLs/ElectronicsBay)
    - DIN_frame_mount_x4.stl
      - 8 total, M5 x 16mm x 2 per mount
      - 4 total, M3 x 8mm x 1 per mount
    
### Assimilated SnakeOil XY Parts

- Used/remixed SnakeOil XY's Panel Clips, details at [mods/panel-clips/SnakeOil-XY/README.md](mods/panel-clips/SnakeOil-XY/README.md)


# <big>Assembly Notes</big>
Am following misc v4 forum topics, and MP3DP v3 [assembly docs](https://docs.v1e.com/mp3dp/version3assm/) since v4 docs unavailable.

## General Notes
- M3's bolt heads and nuts are easy to strip during assembly if too little (driver slips/grinds head), or too much, pressure applied (for [example](https://forum.v1e.com/t/not-another-mp3dp-v4/37429/127)).

### Assemble Rear Corners
- Recommend M3 x 12mm, holds better than 10mm.


### Assemble Front Stepper Mounts with Tension Block XY
- See [v3 Docs](https://docs.v1e.com/mp3dp/version3assm/#stepper-mounts)
  - Secure the steppers with M3x10 screws.

- Tension Block
https://forum.v1e.com/t/mp3dp-v4-azas-build/37251/73?u=azab2c

### Assembling Z Posts/Trucks
[Related post](https://forum.v1e.com/t/mp3dp-v4-azas-build/37251/81)

### Bed Support Plate — Decide, Cut, Paint and Assemble
[Related post](https://forum.v1e.com/t/mp3dp-v4-azas-build/37251/83)

### Assemble X Axis and XY Blocks
[Related post](https://forum.v1e.com/t/mp3dp-v4-azas-build/37251/84)

Do not mount X Core to X linear rail carriage just yet.  Wait until frame is fully built.  Reason is the hotend is fragile, and it's easier to mount a fully assembled Core to the linear rail carriage.

### Square frame


Wiring, mount endstops
Hotend assembly, ...

[Dan, how to tension Z belts?](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/18?u=azab2c)

[Matt, reco feet to square and avoid scratches](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/20?u=azab2c)


- https://en.wikipedia.org/wiki/19-inch_rack
  -  https://en.wikipedia.org/wiki/19-inch_rack#/media/File:19_inch_rack_dimensions.svg


### Assemble Belts to Z Belt Holders
Related:
- https://forum.v1e.com/t/repeat-v2/33330/186?u=azab2c
  - Ensure correct print orientation.


## Enclosure Box

Features:
- Exhaust Heat pumped into chamber
- Reuse/Lower TCO for  Encapsulated Compute, PSU, auxilary components, Reusable
- Fast build/replacement, integration into other projects

### Enclosure Frame Assembly

Parts:
- M5 6mm grub screws
- 2020 Internal corners, M5 holes


### Din Rail

Parts:
- 8x M5x16mm Button Bolt, 4 DIN mounts, 2 per DIN mount    

Parts:
 - Mean Well RS-25-5
 - 2x M3x6mm, see Voron Trident p211


### Assembly, Mount PSU to enclosurepn

- Created 2080-brace-mean-well-hlg-240h
  - 4x M5x10mm Bolts, 2 per brace
  - 2x M4x12mm Bolts, 1 per brace
  - 2x M4 Nyloc Nut, 1 per brace

### Assembly, mount Controller, SSR, 5V PSU, WAGO housings, etc...

- ### Mount Octopus Controller
  - Used DIN Octopus rail mounts/brackets for Voron Trident.
  - Alternatives:
    - M3 bolts based DIN Rail bracket for Octopus
      - https://github.com/VoronDesign/VoronUsers/tree/master/printer_mods/sse018/Octopus_DIN_Rail_bracket

  - Parts: 
    - 4x M2x8mm (or 10mm?) self tapping screw

- ### Mount WAGO housing
  - WAGO 221 415 Lever Nuts (3x housing)
    - 2x M5x10mm Button Bolts


### Assembly, H2 Revo HotEnd

- H2 Revo comes with 2x M3x16mm for attaching 35x35x10 Fan to HotEnd body, too short imo.  If using the fan, consider 2x M3x20mm instead. 



### Belting the XY Gantry
- Related / Tips:
  - [v3 Belting the gantry](https://docs.v1e.com/mp3dp/version3assm/#belting-the-gantry)
  - [Dan's XY belts](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/18?u=azab2c)
  - [Niget's belt](https://forum.v1e.com/t/not-another-mp3dp-v4/37429/116?u=azab2c)
  - [Ryan - start with belts a bit looser than you'd expect](https://forum.v1e.com/t/mp3dp-v4-build/36437/62?u=azab2c)
  - [Ryan - X rail should move smoothly](https://forum.v1e.com/t/mp3dp-v4-build/36437/166?u=azab2c)
  - [MattMed's belt squaring and tensioning adventures](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/148?u=azab2c)
  - [Barry - Belt tension affects squareness, tighten upper and lower belts to strum at same frequency](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/164?u=azab2c)
  - [Ryan - use needle nose pliers to help insert/push locking belt piece into place](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/165?u=azab2c)
# <big>Firmware</big>


https://forum.v1e.com/t/repeat-v2/33330/172?u=azab2c

# <big>Cost</big>

~$60 TAP Plastics, panels, adhesive



<span style=display:block>
TASKS: TODO:
  - Design Edits:
    - Frame
      - Y Panels
        - Add Slots enabling Z Belt Holder height/tension adjustment.
        - Add 3.5 holes along bottom Y extrusion to help square frame, and secure panel.
    - Enclosure Box
      - 2020 External Bracket
        - Mod design
          - Remove 45 angle, allow tight sitting connectors.
          - Increase thickness for 3mm panels
        

  - What components are needed?
- Power distribution
- M10 PTFE Fittings?  Check stock?
-  80mm exhaust fan?



 - PI Cam?  ESP32 Cam
 - Power plug and distribution block? https://us2.dh-cdn.net/uploads/db5587/original/3X/b/2/b2d14f84805cf260d9c1c2208ad2db44043677e6.jpeg


Couldn't figure out slim PSU-Controller-Components in one box layout with LRS-350-24 oriented in a way where fan extracted heat can be dissipated.  This is 250x250 usable, would've been easier to layout in a 300x300 build.

![image|690x411](upload://GhRE8HWHCYEmJI8s1tQPNvJZ7O.jpeg)

Found an unused slimmer 240W PSU among my scraps, so trying that out.

PSU Options
- Mean Well HLG-240H-24
  - Spec https://www.meanwell.com/Upload/PDF/HLG-240H/HLG-240H-SPEC.PDF
  - Temp -40c to 90c
- Mean Well LRS-350-24
  - Spec https://www.meanwell.com/productPdf.aspx?i=459
  - Temp -25c to 70c 

</span>



# <big>Future improvements :</big>
- Filament run out sensor


### Assembly, mount plate Drag Chain

Parts :
- https://www.amazon.com/gp/product/B07WJ4CPF5/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&th=1
  - Specs :
<table width=50%><tr><td>

  ![](https://m.media-amazon.com/images/I/61gg+al37kL._SX522_.jpg)

</td></tr></table>

- TODO:  Design Updates
  - Update Design for my Mod of Z Post
    - Larger hole for idler to fit.
    - Larger hol for spanner around
    - Increase clearance for Stepper bolt 1.5mm near middle T-nut
  - Ensure panels removable, fixed panels make assembly/servicing PITA
  - Update Rear interior panel design
    - Add holes for mounting drag chain, + 2x 3.5mm spaced 12mm, or leave cutout to allow misc drag chain dimensions. 

- Front Panel, consider adding Octopus Boot Loader switch?  Needed to reset Octopus to DFU for bootloader firmware updates

Specs:
- E3D REVO Heater core within BIQU H2 https://e3d-online.zendesk.com/hc/en-us/articles/6536212118173

Pi+TFT enclosure design
- Sliding lip+clip
 - Inner lip dia 5.7
 - Outer clip dia 7.2
 - ClipThickness 2.5
 - Notch/Rib
  - Inset 2.6
  - RibHeight 0.5
  - RibWidth 2.1
  - M2.5 hole 2.6mm, outer 4.2 +

Related:
- Prusa MK3 LCD
 - https://github.com/prusa3d/Original-Prusa-i3/blob/MK3S/Printed-Parts/STL/LCD-cover-ORIGINAL-MK3.stl
 - MK3/4 Display mount, clips into 2020 https://www.printables.com/model/81026-prusa-display-mk3-mk4/files
 - Used M2.5 sized nubs/boss from https://github.com/prusa3d/Original-Prusa-i3/blob/MK3S/Printed-Parts/STL/rpi-zero-frame.stl


## Gratuitous Lighting
Picked up [Adafruit NeoDriver - I2C to NeoPixel Driver Board - Stemma QT](https://www.adafruit.com/product/5766) during Adafruit's recent weekly [50% discount product of the week live stream](https://www.youtube.com/watch?v=rn2l9tPTrg0).

Planning to have lighting that doesn't change with high frequency, need to inject power, so may as well use this board connected to Pi's I2C.

Related:
  - https://hackaday.com/2022/02/01/did-you-know-that-the-raspberry-pi-4-has-more-spi-i2c-uart-ports/#:~:text=We've%20gotten%20used%20to,on%20its%2040%2Dpin%20header.
  - https://blog.stabel.family/raspberry-pi-4-multiple-spis-and-the-device-tree/
  - 

# Configuration
See [MP3DP v4 - Configs and Slicer Profiles](https://forum.v1e.com/t/mp3dp-v4-configs-and-slicer-profiles/40066/1) for examples of configs other V1E community members are using.

## Klipper Config
- My Klipper Config's @ https://github.com/aaronse/v1engineering-mods/tree/main/mp3dp-v4/klipper/printer.cfg
  - Includes comments with links and info.
- Snapshot of Mike's @ https://github.com/aaronse/v1engineering-mods/tree/main/mp3dp-v4/klipper/probrwr/printer.cfg
  
## Slicer Config
- work in progress, will share after getting good quality large print...
  

