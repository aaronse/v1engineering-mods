# <big>MP3DP v4 (aka Repeat v2)</big> <small>— 3D Printed, CNC'd CoreXY 3D Printer</small>

Some MP3DP V4 == Repeat V2 related notes and resources.  See Official V1E [MP3DP V4 Docs](https://docs.v1e.com/mp3dp), they reference :
-  [*Repeat V2* forum thread](https://forum.v1e.com/t/repeat-v2/33330) containing design process/updates/feedback. 
- [Fusion 360 hosted Design](https://myhub.autodesk360.com/ue29a24ab/g/shares/SH35dfcQT936092f0e43b20f88cb61d3441a), export/download and print these parts for latest greatest design.  Related forum post is [here](https://forum.v1engineering.com/t/repeat-v2/33330/85?u=vicious1).
  - Can use [export-components.py](https://github.com/aaronse/v1engineering-mods/blob/main/mp3dp-v4/scripts/export-components.py) Python script to Bulk Export parts to .STL files.  ~~Included a snapshot of exported .STLs in the [/models](https://github.com/aaronse/v1engineering-mods/tree/main/mp3dp-v4/models) subfolder.~~  
    - As-is models will need orienting before splicing and printing.
- [Printable](https://www.printables.com/model/282346) .STL files will be stable, but not latest.

<mark style=opacity:0.4>&nbsp;**Note:** Until full docs are available, reading through v3 docs (albeit a different design) for general guidance will help.  For example v3 [printed parts docs](https://docs.v1e.com/mp3dp/version3index/#printed-parts) has info that applies to v4 too.</mark>

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




## <big>Why build one?</big>
Mostly Fun, and, maybe profit.  Have an Ender 3 Max, great machine but has limited speed/quality/temps.  Want something faster and capable of other printing other materials, not just higher temp ASA/ABS/PC, TPU will be easier with direct drive instead of bowden.  

Super secret goal, arguably the most important one...  is to inspire and lure the kids into 3D printing, a gateway to becoming a Maker...

### Why others built one...
- Dan/SupraGuy perspective @ https://forum.v1e.com/t/mp3dp-v2/37092/7?u=azab2c


### Low Cost (Parts, not labor...)

- Dan's costs https://forum.v1e.com/t/mp3dp-v2/37092/3?u=azab2c

### Performance / Reliablity
Ryan/V1E relies on these to run his business, so that says a lot.

### Alternatives considered :
- https://vorondesign.com/
- https://us.ratrig.com/3d-printers/v-core.html


## <big>BOM / Parts</big>
- Ryan prints with PLA, am using PETG (like Dan), may reprint with ASA.

### PRINTED PARTS
- Using 3 wall, 35% gyroid infill.  Ryan says [40% is probably really good](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/82?u=azab2c).

Related posts:
- [MP3DP v4 BOM](https://forum.v1e.com/t/mp3dp-v4-bom/35315/21?u=azab2c) forum topic
- [Dan's parts](https://forum.v1e.com/t/mp3dp-v4-build-plog/36010/3?u=azab2c)


  ```js

  // DONE

  // INPROGRESS
  │       2 x Z Post.3mf

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
      XY Left.3mf
      XY Right.3mf
      6 x Z Belt Holder.3mf
      Z Post M.3mf

  ├───SKR Pro
      SKR Pro Cover.3mf
      SKR Pro Wire tie.3mf

  └───TFT E3 V3
      TFT CASE V3.STL
      TFT Holder.3mf
  ```



## <big>Assembly</big>



## Community Builds/Advice

[Community MP3DP Build Logs](https://forum.v1e.com/search?expanded=true&q=%23mostly-printed-3d-printer-mp3dp%3Ayour-builds-mp3dp)



## Build 


<br/><br/><br/>
