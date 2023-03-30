Sharing notes/questions for my (likely slow) MP3DP v4 build, will periodically update as I make progress.  Appreciate all the info people have been sharing, hoping my aggregated notes here helps others.  This'll be a lagged snapshot of what I'm frequently pushing to [github](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4).


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

![image](upload://sKmcR0DILU7sQ4IPn4FrIQifLq0.jpeg)

</td>
<td width="33%">

![image](https://docs.v1e.com/img/mp3dpv4/mp3dpv4_3.webp)

</td>

<td width="33%">

![image](https://docs.v1e.com/img/mp3dpv4/mp3dpv4_4.webp)

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
- https://us.ratrig.com/3d-printers/v-core.html too $$, $1100
- [https://bambulab.com/en/x1](https://bambulab.com/en/x1) easy to use $$ + closed bambu x1 carbon


All that said, am biased toward building MP3DP v4 largely because of the V1E community support.  To me, the V1E mindset is focused on getting great quality results for great value.  This resonates with me more than paying a significant premium for something that pushes the limits, and may involve lots of maintenance.  Creating, experimenting and extending is more fun than maintaining.

## <big>SIZING</big>
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
      
      Extrusion Frame Length X = Linear Rail X + 70mm
      Extrusion Frame Length Y = Linear Rail Y + 95mm
      Extrusion Frame Length Z = Linear Rail Z + 95mm

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





## <big>BOM / PARTS</big>

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
|1    |Adaptor Board|BigTreeTech EBB 36/42 Can Bus<br/>- [CAN Bus overview by Teaching Tech (YT)](https://www.youtube.com/watch?v=5pLjeQz9pEI) |[BIQU](https://biqu.equipment/products/bigtreetech-ebb-36-42-can-bus-for-connecting-klipper-expansion-device) – 

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

### Cables

???

### Vibration Management

???

### Misc

???


### Extruder Options
- Hemera [amzn](https://www.amazon.com/Genuine-E3D-Hemera-1-75mm-Direct/dp/B0829DHHPK) or BiQU H2 V2 (170g lighter)

- Octopus 
  - MP3DP needs 6 drivers/steppers, Octopus is oversized with 8 drivers, am using because 1) am familiar with the board already, 2) will have 2 more slots for mods.

  BIQU H2
  https://www.youtube.com/watch?v=zyKH05bBs4Q

  BIQU H2S Revo
  https://www.youtube.com/watch?v=4X1F-dLVT3g
  - Fan Duct https://youtu.be/4X1F-dLVT3g?t=214 by eight_heads

  - @probrwr has [BiQU H2S Revo](https://biqu.equipment/collections/extruder-hotend-heatsink-j-heat/products/biqu-h2-v2s-revo-extruder) and @gpagnozzi has [BIQU H2 V2.0](https://biqu.equipment/products/biqu-h2-v2-0-extruder?variant=39821278347362)?



#### BIQU H2 V2.0<br/>
![image|409x500](upload://u0wf0tdH6X2pHFKVAgbQxwT2hNE.jpeg)


#### BIQU H2 V2S REVO [Manual](https://cdn.shopify.com/s/files/1/1619/4791/files/H2V2S_Revo_User_Manual.pdf?v=1662011632)<br/>
![image|302x500](upload://pPbS6XHgoReTCtmmhyuXGF7SGuk.jpeg)


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


## <big>Assembly</big>
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
- [Dan recos](https://forum.v1e.com/t/repeat-v2/33330/374?u=azab2c) routing wiring to Z Post M Steppers along the Bed Support Plate, use misc holes in the plate to secure wiring, including providing strain relief for heater bed wiring.

### Software

#### GCODE configuration
Power down and/or resets will cause bed to crash down. So, ["gcode needs to park the z axis at zmax"](https://forum.v1e.com/t/repeat-v2/33330/45?u=azab2c)


## <big>MP3DP v4 V1E Community builds / builders</big>

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
- @ MattMed 200mm^3 ??? https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/142?u=azab2c
  - [E3D Hemera Direct Kit](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/213?u=azab2c)
  - Nice [Prusa slicer settings](https://forum.v1e.com/t/matts-mp3dp-repeat-build/30859/221?u=azab2c) from Ryan 
- @ Jonathjon 300x300x400mm https://forum.v1e.com/t/mp3dp-v4-build/36437
  - [E3D Hemera](https://forum.v1e.com/t/mp3dp-v4-build/36437/74?u=azab2c)
  - [120V 750W hot plate](https://forum.v1e.com/t/mp3dp-v4-build/36437/43?u=azab2c)
  - [120V 750W Heating Plate/Silicone Mat + Thermistor, Bed Foam foil insulation](https://forum.v1e.com/t/mp3dp-v4-bom/35315/118?u=azab2c)
- @ Kgleason's 235mm^3 https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967
  - Glass on Alu Bed
  - [E3D Hemera](https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967/5?u=azab2c)
  - [MP3DP Mod - Z Moto Brake, prevent free fall](https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967/6?u=azab2c)
- @ aali0101's 250mm^3 https://forum.v1e.com/t/repeat-v2/33330/251?u=azab2c
- @ probrwr's 235mm x 235mm x ??? https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238
  - [ZYLTech Extrusion](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/2?u=azab2c)
  - [120v Heat Pad](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/6?u=azab2c)
  - [Manta M8P, EBB36](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/25?u=azab2c)
  - [MP3DP Mod - Adapter Carrier-to-H2, with EBB36 mount](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/24?u=azab2c)
  - [BIQU H2S Revo](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/34?u=azab2c)
  - [Alu plate 6061 1/4" 12"x12" SEUNMUK](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/39?u=azab2c) from [Amzn](https://www.amazon.com/dp/B096W1L1WX?ref=ppx_pop_mob_ap_share)
  - [PEI spring steel 120vac](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/42?u=azab2c)

- @ OBI's https://forum.v1e.com/t/time-to-start/36783
- @ Heath_H 300mm^3 https://forum.v1e.com/t/heaths-mp3dp-repeat-akron-oh/34817
  - 3 in 1 (multicolor, 1 nozzle/hot-end, 3 extruders)
  - [Octopus](https://forum.v1e.com/t/heaths-mp3dp-repeat-akron-oh/34817?u=azab2c)
- @ gpagnozzi
  - [Manta M8P V1.0 (No CAN) U2C and EBB42 and the H2 V2.0](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/33?u=azab2c)
  - [BIQU H2 V2.0](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/34?u=azab2c)
  - [Klipper config](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/31?u=azab2c)
  - [MP3DP Mod - Extruder carrier for H2, 2x 5015 fans, EBB42](https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238/26?u=azab2c)
- @ niget2002 300mm^3 https://forum.v1e.com/t/not-another-mp3dp-v4/37429 
  - Hemera, SKR 1.2 + TFT, BLTouch
  - [Alu 12 x 12 1/4 bed, 310 x 310 120vac 750w heating plate](https://forum.v1e.com/t/what-build-plate-to-get/36216/38?u=azab2c)

- @ orob https://forum.v1e.com/t/v3-vs-v4-3dp-build-part-list/37014

### <b>v3</b> builds

- @ RootsMedia's 310x310x280mm https://forum.v1e.com/t/mp3dp-repeat-take-two/33215
  - Repeat v1 with sweet ACM/PolyCarb enclosure, complete with logo engraved panels.
    - 24v Mean Well
    - Textured PEI magnetic build plate

### <b>v2</b> builds
- Dan's costs https://forum.v1e.com/t/mp3dp-v2/37092/3?u=azab2c


#### STATUS

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

    // INPROGRESS


    // TODO
    ───Hemera
        Hemera Fan Shroud.3mf

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

    ├───SKR Pro
        SKR Pro Cover.3mf
        SKR Pro Wire tie.3mf

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
  - Power Supply: MEAN WELL LRS-350-24, enough/too-many Watts?

### NEED TO BUY:
  - Extruder: BIQU H2S V2 REVO - Paying premium for REVO to reduce effort for kids/me to change nozzle.
  - Nozzle: REVO 0.6mm (for now)
  - CAN Bus controller: EBB 36

### NEED TO DECIDE:
  - Heater Bed with Thermistor : 
    - My current Ender 3 Max has 24v 310mm x 320mm, 4mm thick Carborundum Glass, 3mm Alu, 3mm Foam.
  - Wiring: Same as above.


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

- TODO:
  - Stepper?
  - Board Mount?
  - Fans?
  - Hot end?
  - Cable mounts/brackets?
  - PSU?
  - Panels / doors?

