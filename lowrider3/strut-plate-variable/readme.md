# Lowrider 3 mod, generate all the Struts

## Summary
- Generate *ALL the Strut .SVG files, to the nearest 10mm, so that LR3 builders don't have to.
- For more context, see https://forum.v1engineering.com/t/lowrider-3-cnc-lr3-release-notes/32748/350

*ALL - as in all the possible sizes that would be rationally chosen.  10mm increments.
- From https://docs.v1engineering.com/lowrider/calculator
  - Min 12" Usable Cutting Area, has 480mm Tube/Strut Length
  - Max 60" Usable Cutting Area = 1700mm Tube/Strut Length 


## Usage
- Generate some .SVG struts
```
for /l %i in (480,10,1700) do "C:\Program Files\OpenSCAD\openscad.exe" --D "beam_len=%i" -q -o out\lr3-strut-plate-variable_%i.svg LR3-strut-plate-variable.scad

for /l %i in (480,1,999) do "C:\Program Files\OpenSCAD\openscad.exe" --D "beam_len=%i" -q -o out_0\lr3-strut-plate-variable_%i.svg LR3-strut-plate-variable.scad

for /l %i in (1000,1,1700) do "C:\Program Files\OpenSCAD\openscad.exe" --D "beam_len=%i" -q -o out_1\lr3-strut-plate-variable_%i.svg LR3-strut-plate-variable.scad
```
- Publish somewhere folks can access, e.g. this repo
    https://raw.githubusercontent.com/aaronse/v1engineering-mods/main/lowrider3/strut-plate-variable/out/lr3-strut-plate-variable_780.svg

- Test/Verify Output :

```
echo ^<html^>^<style^>body {font-size:100px; white-space:nowrap }^</style^>^<body^> > test.html
for /l %i in (480,1,700) do echo ^<br/^>%i ^<img src=out_0/lr3-strut-plate-variable_%i.svg /^> >> test.html
echo ^</body^>^</html^> >> test.html
start test.html
```

## Acknowledgments
- Copied/forked from Jamie's https://www.printables.com/model/206716-lr3-strut-plate-variable
  - For context, see https://forum.v1engineering.com/t/lowrider-3-cnc-lr3-release-notes/32748/93?u=aaronse


## License
- This work is licensed under a [Creative Commons (4.0 International License) Attribution—Noncommercial—Share Alike](http://creativecommons.org/licenses/by-nc-sa/4.0/)
