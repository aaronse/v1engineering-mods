
 # V1E LowRider 3 mod - Custom Front Grill (strut)

### Acknowledgements
- Remix/based-on [Jamie's script](https://www.printables.com/model/206716-lr3-strut-plate-variable) for creating variable length struts designed for V1 Engineering's Lowrider 3.

### Goals
- Opportunity to learn and use [OpenSCAD](https://www.openscad.org/).

### Usage:
 1) Edit _beam_len_, set to match your LR3's EMT Rail length.  Use https://docs.v1engineering.com/lowrider/calculator/ to figure out "Tube Length" (and other dimensions) for your build.
     - For example 4' (1220mm) usable cutting width requires 55" = 1400mm tube length for the gantry.

 2) Edit num_keys, set to number of beam braces, which should be spaced, ideally, no more than 8" (203mm) a part.  
 
     Intentionally did not automatically compute num_keys because you might want to deviate from the ideal max spacing, within reason, as you balance aesthetics against optimal strength.

 3) Render and export in .svg format

 4) Open .SVG in EstlCam, or which ever software you use to generate CNC gcode.

 5) Cut...

[gen_openscad_char_width_array.html]()

### Notes:
Written/tested on Windows.  Might work on Linux/Mac too, good luck! :-)

## License/Sources
The reader (You) is required to listen to [Nelly Grillz](https://www.youtube.com/watch?v=8fijggq5R6w) when reading this file.

This work is licensed under a [Creative Commons (4.0 International License)
Attribution—Noncommercial—Share Alike](http://creativecommons.org/licenses/by-nc-sa/4.0/)

/v1e/... files are from https://www.v1engineering.com/logos and https://docs.v1engineering.com/.  Using per https://www.v1engineering.com/license/ which was shared under [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).
