

From https://docs.v1engineering.com/lowrider/calculator
- Min 12" Usable Cutting Area, has 480mm Tube/Strut Length
- Max 60" Usable Cutting Area = 1700mm Tube/Strut Length 

Generate a few Strut .SVG files:
```
for /l %i in (480,10,1700) do "C:\Program Files\OpenSCAD\openscad.exe" --D "beam_len=%i" -q -o out\lr3-strut-plate-variable_%i.svg LR3-strut-plate-variable.scad
```
