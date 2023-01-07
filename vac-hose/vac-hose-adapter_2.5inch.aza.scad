// FollyMaker
// Vacuum Hose Adapter Beta 0.2 Testing
// Gather the parameters
/* [Parameters] */

//--Example is ShopVac Nominal 2.5" machine port to 1.5" accessory.  -- For the Lower end, is the measurement the
//adapter's outside or inside diameter?
LowerEndMeasured = "outside"; //[outside, inside]
// Diameter of Lower End? (mm)
LowerEndDiameter = 61.5;
// Length of Lower End? (mm)
LowerEndLength = 14;
// For the Upper end, is the measurement the adapter's outside or inside diameter?
UpperEndMeasured = "inside"; //[outside, inside]
// Diameter of Upper End? (mm)
UpperEndDiameter = 70.5;
// Length of Upper End? (mm)
UpperEndLength = 16;
// Length of Taper Section? (mm)
TaperLength = 5;
// Create an Inside Stop at the lower end of Upperer end of this adapter? (To keep the connected fitting from being
// sucked in.)
InsideStop = "no"; //[no,yes]
// What is the thickness of the adapter's walls?
WallThickness = 1.8;

// Flag indicating whether to cutout notch from top
hasCutout = "yes";

// Cutout dimensions
cutOutHeight = 12;
cutOutWidth = 25;

// [yes,no] Flag indicating whether to generate flange
hasFlange = "no";

$fn = 60 * 1;

WT = WallThickness;
LL = LowerEndLength;
SL = UpperEndLength;
TL = TaperLength;

LD = LowerEndMeasured == "inside" ? LowerEndDiameter + 2 * WT : LowerEndDiameter;
SD = UpperEndMeasured == "inside" ? UpperEndDiameter + 2 * WT : UpperEndDiameter;
LID = LowerEndMeasured == "inside" ? LD : LD - 2 * WT;
SID = UpperEndMeasured == "inside" ? SD : SD - 2 * WT;
LID = LD - 2 * WT;
SID = SD - 2 * WT;
DR = LD + 3 * WT;

top = (hasFlange == "yes") ? SL + LL + TL + 2 * WT : SL + LL + TL;

module TransCylinder(D1, D2, H, Z)
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
        TransCylinder(LD, LD, LL, 0); // Lower

        if (hasFlange == "yes")
        {
            TransCylinder(LD, DR, WT, LL);               // Lower to Flange
            TransCylinder(DR, DR, WT, LL + WT);          // Flange
            TransCylinder(LD, SD, TL, LL + 2 * WT);      // Flange to Upper
            TransCylinder(SD, SD, SL, LL + TL + 2 * WT); // Upper
        }
        else
        {
            TransCylinder(LD, SD, TL, LL);      // Transition
            TransCylinder(SD, SD, SL, LL + TL); // Upper
        }
    }
    union()
    {
        TransCylinder(LID, LID, LL + 1, 0); // Lower
        if (hasFlange == "yes")
        {
            TransCylinder(LID, LID, WT, LL);          // Lower to Flange
            TransCylinder(LID, LID, WT, LL + WT);     // Flange
            TransCylinder(LID, SID, TL, LL + 2 * WT); // Flange to Upper
        }
        else
        {
            TransCylinder(LID, SID, TL, LL);      // Lower-to-Upper
            TransCylinder(SID, SID, SL, LL + TL); // Upper
        }

        if (hasCutout == "yes")
        {
            translate([ SD / 2 - (SD / 2), -(cutOutWidth / 2), top - cutOutHeight ])
            {
                cube([ SD / 2, cutOutWidth, cutOutHeight ], center = false);
            }
        }

        if (InsideStop == "yes")
        {
            TransCylinder(SID, SID - (2 * WT), WT, LL + TL + 2 * WT);
            TransCylinder(SID, SID, SL, LL + TL + 3 * WT);
        }
        else
        {
            TransCylinder(SID, SID, SL, LL + TL + 2 * WT);
        }
    }
}