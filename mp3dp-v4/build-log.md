# MP3DP v4 Build Log

# TASKS

- TODO:BOM?

BOM Generator? https://forum.v1e.com/t/repeat-v2/33330/160?u=azab2c

- TODO: Print parts, file://C:\Projects(NAS)\Make.V1E_RepeatV2\models\



# ACTIONS
- 23-03-11 Created [export-components.py](scripts\export-components.py), a Fusion 360 Python script to Bulk Export MP3DPv4 parts to .STL files, and orientate exported parts ready for printing.  Shared script and [usage video](https://youtu.be/MV8f6tbj4n4) with V1E community.  Script automation will enable/encourage publishing of more-frequent design updates (i.e. Move Faster).
- 23-03-12 Start printing parts while wrapping up other projects.
  - Opened [Overture Transparent Red PETG](https://www.amazon.com/gp/product/B07YCNCZ5J)
  - Visited Teaching Tech calibration site (again) https://teachingtechyt.github.io/calibration.html#baseline
    - Created baseline cube https://teachingtechyt.github.io/calibration.html#baseline
    - https://teachingtechyt.github.io/calibration.html#flow
      - Infill Density : 55%, Wall Thickness : 1.8mm, Alternate extra wall:true, top layers: 3

      ![image](img/2023-03-12-calibration-old-material-flow-values.png)
  - Printed Test Cube to measure/verify Flow
        tech_cube_flow=100.petg.gcode
      <mark>TODO Add Clip/Photo</mark>
      Observed 0.66-0.68
      Changed flow from 100% to 91%, set brim flow to 110%.
  - https://teachingtechyt.github.io/calibration.html#retraction
  - Printed Cura Temp Tower, going with ~245


23-03-13
  - Downloaded current models https://www.printables.com/model/282346-mp3dp-v41/files


23-03-14
  - Ugh.  After feeling smug about using Teaching Tech’s Calibration Tool to tune your settings; Do remember to uncheck “Remove All Holes”, before you print ~8hrs worth of parts :man_facepalming:
  ![image](img/2023-03-14-don't-forget-to-revert-calibration-only-settings.png)
  - Switched infill from gyroid to cubic.  Didn't like how much gyroid infill pattern was rattling and slinging the bed around (Ender 3 Max).  Cubic worked great for my LR3 build.  Will try gyroid again on a CoreXY printer.

23-03-15
  - Ugh.  Ended up printing Left Right Steppers twice.
  - Given some printing screw ups, not sure if the PETG 1KG will be enough for all parts.  So, now that printer settings/quality are acceptable, am examining Fusion model and prioritizing printing parts most visible first.  Can print minor/smaller parts in black/something.


 - FAIL: X Carriage part warped/lifted from bed.  Fixing by reducing "Brim distance" from 0.12mm to 0mm. 

...

Posted misc updates/questions to https://forum.v1e.com/t/not-another-mp3dp-v4/37429/119

...

23-04-05
- Cut interior side panels from Poly carb

23-04-07
- Cut exterior rear from Ply

23-04-08
- Attempting sheet metal for interior...
   - https://forum.v1e.com/t/cutting-sheet-metal/7878/7?u=azab2c
