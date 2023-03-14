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

![image](https://docs.v1e.com/img/mp3dpv4/mp3dpv4_2.jpg)

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
Mostly Fun, and, maybe profit.  Have an Ender 3 Max, great machine but has limited speed/quality/temps.  Want something faster and capable of other printing other materials, not just higher temp ASA/ABS/PC, TPU will be easier with direct drive instead of bowden.  

Super secret goal, arguably the most important one...  is to inspire and lure the kids into 3D printing, a gateway to becoming a Maker...

### Why others built one...
- Dan/SupraGuy perspective @ https://forum.v1e.com/t/mp3dp-v2/37092/7?u=azab2c


### Low Cost (Parts, not labor...)

- Dan's costs https://forum.v1e.com/t/mp3dp-v2/37092/3?u=azab2c

### Quality / Speed / Reliablity
Related:
- Kirk's speed testing https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967/7?u=azab2c

Ryan/V1E relies on these to run his business, so that says a lot.

### Alternatives considered :
- https://vorondesign.com/ too $$$, $1800-$2000
- https://us.ratrig.com/3d-printers/v-core.html too $$, $1100
- https://bambulab.com/en/x1 easy to use $$ + closed bambu x1 carbon

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
      ```

      (**) Z dimension is approximate, can vary depending on bed mounting thickness.

      References: [Dan](https://forum.v1e.com/t/mp3dp-v4-bom/35315/17?u=azab2c)

  - B) Change dimensions Use Change [model parameters](https://forum.v1e.com/t/repeat-v2/33330/163?u=azab2c)


## <big>BOM / PARTS</big>
Related:
- [MP3DP v4 BOM](https://forum.v1e.com/t/mp3dp-v4-bom/35315/21?u=azab2c) forum topic
- [Dan's parts](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/3?u=azab2c)
  - [Dan's rails](https://forum.v1e.com/t/mp3dp-v4-bom/35315/21?u=azab2c), Y = Z = 300mm, X = 350mm


### PARTS
Related:
- Ryan's BOM https://forum.v1e.com/t/repeat-v2/33330/85?u=azab2c
- Voron part sourcing guide https://vorondesign.com/sourcing_guide?model=V2.4.  Sections below are inspired by [Voron generated BOM](misc/voron_generated_bom.csv).

V1E Shop sells bunch of https://www.v1e.com/collections/3dprinter-parts, will source what I can from Ryan.


#### Fasteners

- M3x8 (plus the one stepper mount marked with an “8”.) 
- M2.5x12 for the endstops
- M3x10 
- M5x30 
- M5 Slide in Nuts [amzn](https://www.amazon.com/KOOTANS-Thread-Aluminum-Extrusions-Profiles/dp/B07PNV8SWZ)
  - Use slide-in nuts, [rotating T-Nuts are horrible](https://forum.v1e.com/t/repeat-v2/33330/246?u=azab2c).

#### Motion
MGN9H

#### Electronics
- Hemera [amzn](https://www.amazon.com/Genuine-E3D-Hemera-1-75mm-Direct/dp/B0829DHHPK) or BiQU H2 V2 (170g lighter)
 
- Meanwell ???
- Octopus 
  - MP3DP needs 6 drivers/steppers, Octopus is oversized with 8 drivers, am using because 1) am familiar with the board already, 2) will have 2 more slots for mods.

 

#### Vibration Management

#### Frame

- Consider Zyltech, Ryan(and others?) [had bad experience](https://forum.v1e.com/t/repeat-v2/33330/129?u=azab2c) with Amzn extrusion.
  - https://www.zyltech.com/10x-1m-2020-t-slot-aluminum-extrusion-kit-w-hardware-brackets-screws-nuts/?sku=EXT-2020-REG-COMBO

- Corner Brackets [Forum reco Jeffeb](https://forum.v1e.com/t/mp3dp-v4-bom/35315/46?u=azab2c)

#### Misc

#### Cables

#### Panels
Material options
- 6mm /1/4" Plywood
- Acrylic/Polycarbonate
- [ACM](https://forum.v1e.com/t/mp3dp-v4-bom/35315/52?u=azab2c) (aluminium-plastic-aluminium sandwich) great stable material, but $$$.


#### BuildPlate

 


### 3D PRINTED PARTS
- Used PETG (like Dan), may reprint with ASA using MP3DP v4.  Ryan prints with PLA.
- Using Overture Transparent Red PETG](https://www.amazon.com/gp/product/B07YCNCZ5J
  - Cura Settings: 0.6noz, 3 wall, 35% gyroid infill.  Ryan says [40% is probably really good](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/82?u=azab2c).


## <big>Assembly</big>
<mark>TODO:</mark>


## <big>MP3DP v4 V1E Community builds / builders</big>

Some of the [Community MP3DP Build Logs](https://forum.v1e.com/search?expanded=true&q=%23mostly-printed-3d-printer-mp3dp%3Ayour-builds-mp3dp%20order%3Alatest_topic) that helped me.

### <b>v4</b> builds

- @SupraGuy 200/235mm^3 ?? https://forum.v1e.com/t/mp3dp-v4-build-plog/36010?u=azab2c
- @ Jonathjon ?mm^3 https://forum.v1e.com/t/mp3dp-v4-build/36437
- @ Kgleason's 235mm^3 https://forum.v1e.com/t/mp3dp-repeat-v2-aka-v4-z-steppers/35967
- @ aali0101's 250mm^3 https://forum.v1e.com/t/repeat-v2/33330/251?u=azab2c
- @ probrwr's https://forum.v1e.com/t/mp3dp-v4-build-sw-virginia/37238
- @ OBI's https://forum.v1e.com/t/time-to-start/36783
- @ Heath_H 300mm^3 https://forum.v1e.com/t/heaths-mp3dp-repeat-akron-oh/34817
  - 3 in 1 (multicolor, 1 nozzle/hot-end, 3 extruders)


### <b>v3</b> builds

- @ RootsMedia's 310x310x280mm https://forum.v1e.com/t/mp3dp-repeat-take-two/33215
  - Repeat v1 with sweet ACM/PolyCarb enclosure, complete with logo engraved panels.


#### STATUS

  ```js

  // DONE
│     2 x Z Post.3mf    2.3hrs

  // INPROGRESS
      Z Post M.3mf      2.3hrs
      XY Left.3mf       2.3hrs

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
      Back Corner Left.3mf
      Back Corner Right.3mf
      Bed Washer.3mf
      filament Rev Bowden Holder.3mf
      Left Stepper.3mf
      Rail Aligner.3mf
      Right Stepper.3mf
      2 x Tension Block XY.3mf
      X Carrier.3mf
      XY Right.3mf
      6 x Z Belt Holder.3mf

  ├───SKR Pro
      SKR Pro Cover.3mf
      SKR Pro Wire tie.3mf

  └───TFT E3 V3
      TFT CASE V3.STL
      TFT Holder.3mf
  ```

