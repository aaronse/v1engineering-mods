// FollyMaker
// Vacuum Hose Adapter Beta 0.2 Testing
// Gather the parameters
/* [Parameters] */

//--Example is ShopVac Nominal 2.5" machine port to 1.5" accessory.  -- For the Lower end, is the measurement the
//adapter's outside or inside diameter?
lowerEndMeasured = "outside"; //[outside, inside]
// Diameter of Lower End? (mm)
lowerEndDiameter = 61.5;
// Length of Lower End? (mm)
lowerEndLength = 14;
// For the Upper end, is the measurement the adapter's outside or inside diameter?
upperEndMeasured = "inside"; //[outside, inside]
// Diameter of Upper End? (mm)
upperEndDiameter = 70.5;
// Length of Upper End? (mm)
upperEndLength = 16;
// Length of Taper Section? (mm)
taperLength = 5;
// Create an Inside Stop at the lower end of Upperer end of this adapter? (To keep the connected fitting from being
// sucked in.)
insideStop = "no"; //[no,yes]
// What is the thickness of the adapter's walls?
wallThickness = 1.8;

// Flag indicating whether to cutout notch from top
hasCutout = "yes";

// Cutout dimensions
cutOutHeight = 12;
cutOutWidth = 25;

// [yes,no] Flag indicating whether to generate flange
hasFlange = "no";

$fn = 60 * 1;

WT = wallThickness;
LL = lowerEndLength;
SL = upperEndLength;
TL = taperLength;

LD = lowerEndMeasured == "inside" ? lowerEndDiameter + 2 * WT : lowerEndDiameter;
SD = upperEndMeasured == "inside" ? upperEndDiameter + 2 * WT : upperEndDiameter;
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
            transCylinder(LD, DR, WT, LL);               // Lower to Flange
            transCylinder(DR, DR, WT, LL + WT);          // Flange
            transCylinder(LD, SD, TL, LL + 2 * WT);      // Flange to Upper
            transCylinder(SD, SD, SL, LL + TL + 2 * WT); // Upper
        }
        else
        {
            transCylinder(LD, SD, TL, LL);      // Transition
            transCylinder(SD, SD, SL, LL + TL); // Upper
        }
    }
    union()
    {
        transCylinder(LID, LID, LL + 1, 0); // Lower
        if (hasFlange == "yes")
        {
            transCylinder(LID, LID, WT, LL);          // Lower to Flange
            transCylinder(LID, LID, WT, LL + WT);     // Flange
            transCylinder(LID, SID, TL, LL + 2 * WT); // Flange to Upper
        }
        else
        {
            transCylinder(LID, SID, TL, LL);      // Lower-to-Upper
            transCylinder(SID, SID, SL, LL + TL); // Upper
        }

        if (hasCutout == "yes")
        {
            translate([ SD / 2 - (SD / 2), -(cutOutWidth / 2), top - cutOutHeight ])
            {
                cube([ SD / 2, cutOutWidth, cutOutHeight ], center = false);
            }
        }

        if (insideStop == "yes")
        {
            transCylinder(SID, SID - (2 * WT), WT, LL + TL + 2 * WT);
            transCylinder(SID, SID, SL, LL + TL + 3 * WT);
        }
        else
        {
            transCylinder(SID, SID, SL, LL + TL + 2 * WT);
        }
    }
}