//FollyMaker
//Vacuum Hose Adapter Rev 1 (April 25, 2022) 
//Gather the parameters
/* [Parameters] */

//Example is ShopVac Nominal 2.5" machine port to 1.5" accessory.  -- For the large end, is the measurement the adapter's outside or inside diameter?
LargeEndMeasured = "outside"; //[outside, inside]
//Diameter of Large End? (mm)
LargeEndDiameter = 40.1;
// Length of Large End? (mm)
LargeEndLength = 15.1;
//For the small end, is the measurement the adapter's outside or inside diameter?
SmallEndMeasured = "outside"; //[outside, inside]
//Diameter of Small End? (mm)
SmallEndDiameter = 17.1;
// Length of Small End? (mm)
SmallEndLength = 25.1;
// Length of Taper Section? (mm)
TaperLength = 25.1;
//What is the thickness of the adapter's walls?
 WallThickness = 1.5;
// Create an Inside Stop at the lower end of smaller section of this adapter? (To prevent the connected fitting from being sucked in.)
 InsideStop= "no"; //[no,yes]

 
 
 $fn=60 *1;
 
     WT=WallThickness;
     LL=LargeEndLength;
     SL=SmallEndLength;
     TL=TaperLength;
     
     LOD=  LargeEndMeasured =="inside" ? LargeEndDiameter + 2*WT : LargeEndDiameter;
     SOD=  SmallEndMeasured =="inside" ? SmallEndDiameter + 2*WT : SmallEndDiameter;
     LID = LOD - 2*WT;
     SID = SOD - 2*WT;
     DR = LOD + 3*WT;
     
 
module TransCylinder(D1, D2, H, Z)
    {
        translate([0, 0, Z])
        {
            cylinder(d1=D1, d2=D2, h=H, center=false);
        }
    }
   
difference()
{
      union()
        { 
            TransCylinder(LOD, LOD, LL, 0);
            TransCylinder(LOD, DR, WT, LL);
            TransCylinder(DR, DR, WT, LL + WT);
            TransCylinder(LOD, SOD, TL, LL + 2*WT);
            TransCylinder(SOD, SOD, SL, LL + TL + 2*WT);
          } 
     union()
        {
            TransCylinder(LID, LID, LL, 0);
            TransCylinder(LID, LID, WT, LL);
            TransCylinder(LID, LID,  WT, LL + WT);
            TransCylinder(LID, SID, TL, LL + 2*WT);
            if (InsideStop=="yes")
                {
                TransCylinder(SID, SID-(2*WT), WT, LL +TL + 2*WT);
                TransCylinder(SID, SID, SL, LL +TL + 3*WT);
                    }
                else
                    {          
                    TransCylinder(SID, SID, SL, LL +TL + 2*WT);
                    }
        }
}   