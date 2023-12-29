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

difference()
{
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
  }
  
  union()
  {
    // Lower
    transCylinder(LID, LID, LL + 1, 0); 
    if (hasFlange == "yes")
    {
      // Lower to Flange
      transCylinder(LID, LID, WT, LL);
      
      // Flange
      transCylinder(LID, LID, WT, LL + WT);
      
      // Flange to Upper
      transCylinder(LID, SID, TL, LL + 2 * WT); 
    }
    else
    {
      // Lower-to-Upper
      transCylinder(LID, SID, TL, LL);      
      
      // Upper
      transCylinder(SID, SID, SL, LL + TL); 
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
        SL,
        LL + TL + 3 * WT);
    }
    else
    {
      transCylinder(
        SID,
        SID,
        SL,
        LL + TL + 2 * WT);
    }
  }
}
