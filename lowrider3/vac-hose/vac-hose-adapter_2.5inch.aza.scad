/*
VAC HOSE ADAPTER, but can use for other stuff too...

Example default values configured are for specific Vac Hose
used with my LowRider 3.  See...
  https://www.printables.com/model/550066-lowrider-3-vac-hose-adapter-25-and-parametric-scad

RELATED WORK:
- Originally based on FollyMaker's Thingiverse script.  
  Discovered thanks to Philippe on V1E forum post.
  - https://www.thingiverse.com/thing:1246651
  - https://forum.v1e.com/t/vacuum-hose-size/35926/3?u=aaronse

  
         1         2         3         4         5         6
123456789012345678901234567890123456789012345678901234567890
*/

/* [Parameters] */

// Is Adapter's lower end, is the measurement for outside 
// or inside diameter?
lowerEndMeasured = "outside"; //[outside, inside]

// Diameter of Lower End? (mm)
lowerEndDiameter = 61.5;

// Length of Lower End? (mm)
lowerEndLength = 14;

// For the Upper end, is the measurement the adapter's outside 
// or inside diameter?
upperEndMeasured = "inside"; //[outside, inside]

// Diameter of Upper End? (mm)
upperEndDiameter = 70.5;

// Length of Upper End? (mm)
upperEndLength = 16;

// Length of Taper Section? (mm)
taperLength = 5;

// Create an Inside Stop at the lower end of Upperer end of 
// this adapter? (To keep the connected fitting from being
// sucked in.)
insideStop = "no"; //[no,yes]

// What is the thickness of the adapter's walls?
wallThickness = 1.8;

// Flag indicating whether to cutout notch from top
hasCutout = "no";

// Cutout dimensions
cutOutHeight = 12;
cutOutWidth = 25;

// [yes,no] Flag indicating whether to generate flange
hasFlange = "yes";

// Optional options for optional Square Flange
hasSquareFlange = "yes";
hasSquareFlangeHoles = "yes";
SquareFlangeThickness = 5;
SquareFlangeHeight = 10;
SquareFlangeHoleDiameter = 5;
SquareFlangeHoleThickness = 3;
SquareFlangeCornerRadius = 2.5;


$fn = 60 * 1;

WT = wallThickness;
LL = lowerEndLength;
SL = upperEndLength;
TL = taperLength;

LD = lowerEndMeasured == "inside" 
  ? lowerEndDiameter + 2 * WT 
  : lowerEndDiameter;
  
SD = upperEndMeasured == "inside" 
  ? upperEndDiameter + 2 * WT 
  : upperEndDiameter;
  
LID = lowerEndMeasured == "inside" ? LD : LD - 2 * WT;
SID = upperEndMeasured == "inside" ? SD : SD - 2 * WT;

LID = LD - 2 * WT;
SID = SD - 2 * WT;
DR = LD + 3 * WT;

top = (hasFlange == "yes") ? SL + LL + TL + 2 * WT : SL + LL + TL;



module transCylinder(D1, D2, H, Z)
{
  translate([ 0, 0, Z ])
  {
    cylinder(d1 = D1, d2 = D2, h = H, center = false);
  }
}

module transRoundedCube(W, D, H, Z, radius, apply_to)
{
  translate([ -W/2, -D/2, Z ])
  {
    //cube([W, D, H], center = false);
    roundedcube(
      size = [W, D, H],
      center = false,
      radius = radius,
      apply_to = apply_to);
  }
}

module transCube(W, D, H, Z)
{
  translate([ -W/2, -D/2, Z ])
  {
    cube([W, D, H], center = false);
  }
}

difference()
{
  // Objects to Add...
  union()
  {
    transCylinder(LD, LD, LL, 0); // Lower

    if (hasFlange == "yes")
    {
      // Lower to Flange
      transCylinder(LD, DR, WT, LL);               
      
      // Flange
      transCylinder(DR, DR, WT, LL + WT);          
      
      // Flange to Upper
      transCylinder(LD, SD, TL, LL + 2 * WT);      
      
      // Upper
      transCylinder(SD, SD, SL, LL + TL + 2 * WT); 
    }
    else
    {
      // Transition
      transCylinder(LD, SD, TL, LL);      
        
      // Upper
      transCylinder(SD, SD, SL, LL + TL); 
    }
    
    
    if (hasSquareFlange == "yes")
    {
      if (SquareFlangeCornerRadius == 0)
      {
        transCube(
          SD, 
          SD,
          SquareFlangeThickness,
          SL + LL + TL + 2 * WT - SquareFlangeThickness);
      }
      else
      {
        transRoundedCube(
          SD,
          SD,
          SquareFlangeThickness,
          SL + LL + TL + 2 * WT - SquareFlangeThickness,
          SquareFlangeCornerRadius,
          "z" );
      }
    }
  }
  
  // Objects to Subtract...
  union()
  {
    
    // Lower
    transCylinder(LID, LID, LL + 2, -1); 
    if (hasFlange == "yes")
    {
      // Lower to Flange
      transCylinder(LID, LID, WT + 0.001, LL);
      
      // Flange
      transCylinder(LID, LID, WT + 0.001, LL + WT);
      
      // Flange to Upper
      transCylinder(LID, SID, TL + 0.001, LL + 2 * WT); 
    }
    else
    {
      // Lower-to-Upper
      transCylinder(LID, SID, TL + 0.001, LL);      
      
      // Upper
      transCylinder(SID, SID, SL + 0.001, LL + TL); 
    }

    if (hasCutout == "yes")
    {
      translate(
        [ SD / 2 - (SD / 2),
        -(cutOutWidth / 2),
        top - cutOutHeight ])
      {
        cube(
          [ SD / 2, cutOutWidth, cutOutHeight ],
          center = false);
      }
    }

    if (insideStop == "yes")
    {
      transCylinder(
        SID,
        SID - (2 * WT),
        WT, 
        LL + TL + 2 * WT);
      
      transCylinder(
        SID,
        SID,
        SL + 0.001,
        LL + TL + 3 * WT);
    }
    else
    {
      transCylinder(
        SID,
        SID,
        SL + 0.001,
        LL + TL + 2 * WT);
    }
    
    // Square Flange Holes
    if (hasSquareFlangeHoles == "yes")
    {
      SquareFlangeHoleHeightOffset =
        SL + LL + TL + 2 * WT - SquareFlangeHoleThickness;
      
      SquareFlangeRadius = SD / 2;
      
      // Set hole pattern radius to between square flange 
      // corner and upper outside diameter
      PattRadius =
        (sqrt(2 * pow(SquareFlangeRadius, 2)) + SquareFlangeRadius) / 2;
      
      n = 4;        // number of objects
      step = 360/n;
      for (i=[0:step:359])
      {
        angle = i;
        dx = PattRadius * cos(angle + 45);
        dy = PattRadius * sin(angle + 45);
        color("red"){
          translate([dx ,dy , SquareFlangeHoleHeightOffset])
          {
            cylinder(
              d1 = SquareFlangeHoleDiameter,
              d2 = SquareFlangeHoleDiameter, 
              h = SquareFlangeHoleThickness + 1, 
              center = false);
          }
        }
      }
    }
    
  }
}


// From https://gist.github.com/groovenectar/92174cb1c98c1089347e
// Higher definition curves
// $fs = 0.01;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}