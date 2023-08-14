// V1E LowRider 3 mod - Custom Front Grill (Strut)
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

// Based on Jamie's OpenSCAD based Strut generator script:
// - https://www.printables.com/model/206716-lr3-strut-plate-variable

// Usage:
// 1) Edit beam_len, set to match your LR3's EMT Rail length.  Use 
//    https://docs.v1engineering.com/lowrider/calculator/ to figure
//    out "Tube Length" for your build.  Tube length = Strut length.
//    - For example 4' (1220mm) usable cutting width requires 
//      55" = 1400mm tube (or strut) length for the gantry.
//    - Included commented examples below for common dimensions.
//
// 2) Edit num_keys, set to number of beam braces, which should be 
//    spaced, ideally, no more than 8" (~200mm) a part.  So, typically...
//      num_keys = ceil(beam_len / 200) + 1;
//    NOTE:  Intentionally did not auto compute num_keys because you
//    might want to deviate from the ideal max spacing, within reason, 
//    as you balance aesthetics against optimal gantry strength.
// 3) Edit cnc_name text to something that brings you joy.
//    - Font can be changed too, autocentering text requires some extra 
//      steps.  You might want to follow those commented steps, or 
//      just play with the fudge factor.
// 4) Render, then verify layout is expected and acceptable.
//    - Script trys to auto center cnc_name Text, but you might need 
//      to edit cnc_name_fudge to a positive/negative number that 
//      tweaks text a bit left/right to your liking.
// 5) Export as .svg
// 6) Open in EstlCam or which ever CNC gcode generating software you 
//    use. Cut and Strut...


// My Gantry has Usable Cutting Area 49.5" (Full width MDF panel + 
// 1/2" wiggle).  LR3 Calc says Tube Rail is 56.5" = 1440mm
beam_len = 1440; 
num_keys = 8;

// Gantry with 4' Usable Cutting Area
//beam_len = 1400;
//num_keys = 8;

// Gantry with 2' Usable Cutting Area
//beam_len = 790;
//num_keys = 6;

cnc_name = 
  //"Aza's Lowrider 3";
  "Milly McMillFace";

// Font used for CNC name text.  MUST specify a font that's already 
// already installed and available for OpenSCAD to use, see
// File menu -> Help -> Font List.  Also, the autocenter logic relies
// on fontWidthProportions.scad which contains character width proportion 
// info used to help calc overall text width and positioning.  Overkill
// for one text string, but useful in other situations with lots of 
// text to layout.
cnc_name_font =
    //"roboto:style=condensed"; // Download from https://www.dafont.com/roboto.font
    "nasalization";             // Download from https://www.dafont.com/nasalization.font
    //"arial";
    //"arial:style=bold";
    // - Font name, and optional style, use lowercase.
    
// Ideally 0, but play with your fudge until it looks good.
cnc_name_fudge = 0; 

marker_font = 
    "roboto:style=condensed";
font_spacing = 0.95;
font_size = 14;
increment_font_size = 13.9;
increment_font_spacing = 0.9;
fontTopPos = 75;
strut_height = 80;
zone_height = 30;
zone_padding = 11;
bit_diameter = 3.175;
// Choose whether to use keyholes for mounting screws
use_keyholes = "yes"; //[yes,no]
// Computed variables
strike_spacing = bit_diameter * 3;
fontLineHeight = font_size + 3;
key_pitch = (beam_len - 15)/(num_keys-1);


include <fontWidthProportions.scad>

fontWidthProportions = findFontWidthProportions(cnc_name_font)[1];

// Recursive function to compute text width.  Required to workaround OpenSCAD
// not supporting variable value accumulation/mutation within loops.  Reason 
// is OpenSCAD isn't a true iterative language despite how the syntax looks.
function calcTextWidth(s, i=0, ret=0) = 
  i<len(s) ? 
    calcTextWidth(s, i+1, ret + fontWidthProportions[ord(s[i])] * font_size) 
    : ret;

totalCharWidth = calcTextWidth(cnc_name);

difference() {
  color("black")
    square([beam_len, strut_height]);
  
  // cut out all mountingHoles, top and bottom
  for (i=[0:num_keys-1]) mountingHole(7.5 + key_pitch*i);

  // V1E Logo
  translate([31 + key_pitch, 57])
  scale([0.8,0.8])
    import("v1e/v1e.svg");

  // Got .SVG Logo?  Display it here...
  //  translate([(key_pitch * 2) + cnc_name_fudge, 54])
  //  scale([0.8,0.8])
  //    import("v1e/tri_logo.svg");

  // Your LR3's name
  translate([((key_pitch - totalCharWidth) / 2) + (key_pitch * 2) + cnc_name_fudge, 74])
    text(
      cnc_name,
      font = cnc_name_font,
      valign = "top",
      size = font_size,
      spacing = font_spacing);

  // 100mm increment markers
  for (i=[0:100:beam_len - 180]) {
    y = (i < 10) ? (fontTopPos - (3 * fontLineHeight))
      : (i < 100) ? (fontTopPos - (2 * fontLineHeight))
      : (i < 1000) ? (fontTopPos - fontLineHeight)
      : fontTopPos;
    translate([i + 90, y])
      text(
        str(i),
        font = marker_font,
        direction = "btt",
        size = increment_font_size,
        spacing = increment_font_spacing);
  }

  // Last usable marker
  {
    lastNum = beam_len - (90 * 2);
    y = (lastNum < 10) ? (fontTopPos - (3 * fontLineHeight))
      : (lastNum < 100) ? (fontTopPos - (2 * fontLineHeight))
      : (lastNum < 1000) ? (fontTopPos - fontLineHeight)
      : fontTopPos;
    translate([lastNum + 90, y])
      text(
        str(lastNum),
        font = marker_font,
        direction = "btt",
        size = increment_font_size,
        spacing = increment_font_spacing);
  }

  // Draw 50mm increment notches
  // Positioned as close to edge as possible without being considered part of the Strut's exterior contour
  for (i=[0:50:beam_len - 180])
    translate([i + 90, bit_diameter / 2])
      hull() for (y=[0, 2]) translate([0, y]) circle(d= 3.175, $fn=10);
      
  // Last Notch
  translate([beam_len - 90, bit_diameter / 2])
      hull() for (y=[0, 2]) translate([0, y]) circle(d= 3.175, $fn=10);

  // Left NOT Usable Zone
  // TODO: Simplify this fugly abomination
  for (i=[zone_padding:strike_spacing:90 - bit_diameter]) {
    translate([i, 5]) hull() {
      for (y=[0, zone_height]) {
        tx = (i-y < zone_padding) ? -i + zone_padding : -y;
        ty = (i-y < zone_padding) ? y + i - (zone_padding + zone_height) : y;
        
        // Don't mark NOT GO Zone near outer contour's fastener notch
        if (tx != -i + zone_padding || ty > 5) {
          translate([tx, ty]) circle(d=bit_diameter, $fn=10);
        }
      }
    }
  }

  // Right NOT Usable Zone
  for (i=[bit_diameter:strike_spacing:90 - zone_padding]) {
    translate([beam_len - 90 + i, 5]) hull() {
      for (y=[0, zone_height]) {
        tx = (i + y > 90 - zone_padding) ? -i + 90 - zone_padding : y;
        ty = (i + y > 90 - zone_padding) ? -(y + i - (90 - zone_padding + zone_height)) : y;

        if (tx != -i + 90 - zone_padding || ty > 5) {
          translate([tx, ty]) circle(d=bit_diameter, $fn=10);
        }
      }
    }
  }
}


module mountingHole(xpos=7.5) {
  if (use_keyholes == "yes") {
    translate([xpos, 60.5]) {
      circle(d=9.84, $fn=60);
      hull() for (y=[0, 13.5]) translate([0, y]) circle(d=max(bit_diameter, 5.1), $fn=30);
    }
    hull() for (y=[-1, 6]) translate([xpos, y]) circle(d=max(bit_diameter, 5.1), $fn=30);
  }
  else {
    translate([xpos, 60.5]) {
      hull()  translate([0, 13.5]) circle(d=max(bit_diameter, 5.1), $fn=30);
    }
    hull() translate([xpos, 6]) circle(d=max(bit_diameter, 5.1), $fn=30);
  }
}

// For comparison against reference
// translate([0,100]) import("v1e/Strut Plate 1400mm.dxf");
