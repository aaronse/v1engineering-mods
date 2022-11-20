// DRAFT DRAFT DRAFT - Implemented just enough to start first build 'sprint'

// Rev 5+ was Forked from https://www.thingiverse.com/thing:1468511
//
// Draw Allted's Simple CNC Table based on input dimensions using openscad
// Translated into openscad on 4/4/2016  by: David Bunch
//
// The default dimensions are what I am using for a table, 48"Long x 36"Wide x 30"High
// This is drawn in Inches, set ScaleFactor variable to 25.4 to draw in millimeters
// Rev2 - revised for Quantity of Top Ledge Lengths if only 1 middle stiffener used
// Rev3 - Legs, Top Ledges & Shelf Ledges can be different Widths & thickness now
//        I made this change because I want to use 2x3's for the Shelf ledges
// Rev4 - Display Shelf Usable Heights with a visual cube for each shelf
// Rev5 - 
//
// CUSTOMIZER VARIABLES
// If you want your MPCNC corners to be right at corners of table,
// Set Len & Wid the same as your CNC_LEN & CNC_Depth
Len = 63;                   //Length of Table
Wid = 36;                   //Width of Table
Ht = 36;                    //Height of Table at top of Ledges
LegWd24_Wid = 3.5;          //Width Legs (I am using 2x4)
LegWd24_Thk = 1.5;          //Thickness of 2Legs

TopLedgeWd24_Wid = 3.5;     //Width of Top Ledge Boards (2x4 is what I use)
TopLedgeWd24_Thk = 1.5;     //Thickness of Top Ledge Boards
MidTopLedgeQty = 2;         //How many middle stiffener ledges, 1 or 2

EdgeWd_Wid = 6;             //How wide of top to put along edges
EdgeWd_Thk = 1;             //How thick the top is

Shelf_Qty = 2;              //0,1 or 2
Shelf1_Ht = 6;              //Shelf height of lower shelf
Shelf2_Ht = 16;             //Shelf height of upper shelf
ShelfThk = 0.5;             //Thickness of Shelves
ShelfLedgeWd24_Wid = 3.5;   //Width of Shelf Ledge Boards (Default is 2x4)
ShelfLedgeWd24_Thk = 1.5;   //Thickness of Shelf Ledge Boards
                        //I am going to use 2x3 to give me a little extra shelf height
Shelf_Cube_X = 12;  //Visual Show Shelf Cube this size in X
Shelf_Cube_Y = 12;  //Visual Show Shelf Cube this size in Y
CNC_Model = "LR3";

// LR3 Machine Dimensions:
CNC_Len = 48 + (180 / 25.4);  // LR3 overall Machine dimension along X Axis
CNC_Depth = 24 + (12);          // LR3 overall Machine dimension along Y Axis, 
                              //   including Y-Rail length
CNC_WorkLen = CNC_Len - (180 / 25.4); // X axis usable work area
CNC_WorkWid = CNC_Depth - (12);         // Y axis usable work area
LR3_YZ_Plate_Height = 200 / 25.4;
LR3_YZ_Plate_Thickness = 0.5;
CNC_Corner_Width = 18 / 25.4;
CNC_Corner_Length = 55 / 25.4;
CNC_Corner_Ht = 40 / 25.4;

// MPCNC Machine Dimensions:
//CNC_Len = 43;       //Length of Physical MPCNC (subtract 11 for work Length)
//                    //Length is the Y-Axis on my machine
//CNC_Depth = 33;       //Width of Physical MPCNC (subtract 11 for work Width)
//                    //Width is the X-Axis on my machine
//Your actual work area will probably be less depending on
//what size router you are using & how wide your tool holder is
//CNC_WorkLen = CNC_Len - 11;         //Work area Length of MPCNC router
//CNC_WorkWid = CNC_Depth - 11;         //Work area Width of MPCNC router
//CNC_Corner_Width = 53.0 / 25.4;
//CNC_Corner_Ht = 63.2 / 25.4;

EMT_OD = 23.6 / 25.4;       //Diameter of EMT, convert to Inches
ScaleFactor = 1;    //1 = draw in Inches, set to 25.4 to draw in millimeters
//CUSTOMIZER VARIABLES END

//Calculate Usable Shelf Space Heights
ToeSpace = Shelf1_Ht - ShelfLedgeWd24_Wid;  //Space Below Bottom Shelf Ledge
OneShelfSpace = Ht - TopLedgeWd24_Wid - (Shelf1_Ht + ShelfThk);
BotShelfSpace = Shelf2_Ht - ShelfLedgeWd24_Wid - (Shelf1_Ht + ShelfThk);
TopShelfSpace = Ht - TopLedgeWd24_Wid - (Shelf2_Ht + ShelfThk);

Work_Y_Loc = (Len - CNC_WorkLen)/2; //X & Y locations of work area in this drawing
Work_X_Loc = (Wid - CNC_WorkWid)/2;

TopMidWid = Wid-(EdgeWd_Wid*2);


Len2 = Len / 2;
Wid2 = Wid / 2;
CNC_Len2 = CNC_Len / 2;
CNC_Depth2 = CNC_Depth / 2;
CNC_Corner_WidthHalf = CNC_Corner_Width / 2;

WdTopLedgeLen = Len - (TopLedgeWd24_Thk * 2);
WdTopLedgeWid = Wid - (TopLedgeWd24_Thk * 2);

WdShelfLedgeLen = Len - (ShelfLedgeWd24_Thk * 2);
WdShelfLedgeWid = Wid - (ShelfLedgeWd24_Thk * 2);
ShelfWid = Wid - (LegWd24_Thk * 2);    //Width of each of the 1 or 2 shelf tops

CNC_X_Loc = Len2-CNC_Len2;    //MPCNC router X location from Lower Left corner
CNC_Y_Loc = Wid2-CNC_Depth2;    //MPCNC router Y location from Lower Left corner
PipeY_Z_Loc = 22.8 / 25.4;  //EMT Y Axis Z Height Location from base of Corner block
PipeX_Z_Loc = 50.4 / 25.4;  //EMT X Axis Z Height Location from base of Corner block

//Output Cut Data
if (ScaleFactor == 1)
{
    Header = "*******************************";
    Spacer = "----------------------------------------------";
    c = str("** Cut 4 Legs ",Ht,"\" Long");
    d1 = str("** Cut 3 Top Ledge Lengths ",WdTopLedgeLen,"\" Long");
    d2 = str("** Cut 4 Top Ledge Lengths ",WdTopLedgeLen,"\" Long");
    e = str("** Cut 2 Top Ledge Widths ",WdTopLedgeWid,"\" Long");
    FTS = str("** Cut 2 Top Edges ",Len,"\" x ",EdgeWd_Wid,"\" Wide");
    FTM = str("** Cut 1 Top Middle ",Len,"\" x ",TopMidWid,"\" Wide");
    FL1 = str("** Cut 2 Shelf Ledge Lengths ",WdTopLedgeLen,"\" Long");
    FW1 = str("** Cut 2 Shelf Ledge Widths ",WdTopLedgeWid,"\" Long");
    FS1 = str("** Cut 1 shelves ",Len,"\" x ",ShelfWid,"\" Wide");
    //ShelfWid
    FL2 = str("** Cut 4 Shelf Ledge Lengths ",WdTopLedgeLen,"\" Long");
    FW2 = str("** Cut 4 Shelf Ledge Widths ",WdTopLedgeWid,"\" Long");
    FS2 = str("** Cut 2 shelves ",Len,"\" x ",ShelfWid,"\" Wide");
    F_ToeSpace = str("** Toe Space Height = ",ToeSpace, chr(34));
    F_UseSpace = str("** Single Shelf Usable Height = ",OneShelfSpace, chr(34));
    F_UseSpace1 = str("** Bottom Shelf Usable Height = ",BotShelfSpace, "\"");
    F_UseSpace2 = str("** Top Shelf Usable Height = ",TopShelfSpace, "\"");   
    echo(Header);
    echo(c);
    if (MidTopLedgeQty == 1)
    {
        echo(d1);
    } else if (MidTopLedgeQty == 2)
    {
        echo(d2);
    }
    echo(e);
    echo(FTS);
    echo(FTM);
    echo(Spacer);
    if (Shelf_Qty == 1)
    {
        echo(FL1);
        echo(FW1);
        echo(FS1);
        echo(Spacer);
        echo(F_ToeSpace);
        echo(F_UseSpace);
//Draw Cube to Represent Toe Space"
        translate([0,LegWd24_Thk,0])
        %cube([Shelf_Cube_X,Shelf_Cube_Y,ToeSpace]);
//Draw Cube to Represent Bottom Shelf Height"
        color("red",.7)
        translate([0,0,Shelf1_Ht + ShelfThk])
        %cube([Shelf_Cube_X,Shelf_Cube_Y,OneShelfSpace]);

    } else if (Shelf_Qty == 2)
    {
        echo(FL2);
        echo(FW2);
        echo(FS2);
        echo(Spacer);
        echo(F_ToeSpace);
        echo(F_UseSpace1);
        echo(F_UseSpace2);
//Draw Cube to Represent Toe Space"
        translate([0,LegWd24_Thk,0])
        %cube([Shelf_Cube_X,Shelf_Cube_Y,ToeSpace]);
//Draw Cube to Represent Bottom Shelf Height"
        color("red",.7)
        translate([0,LegWd24_Thk,Shelf1_Ht + ShelfThk])
        %cube([Shelf_Cube_X,Shelf_Cube_Y,BotShelfSpace]);
//Draw Cube to Represent Top Shelf Height"
        color("blue",.7)
        translate([0,LegWd24_Thk,Shelf2_Ht + ShelfThk])
        %cube([Shelf_Cube_X,Shelf_Cube_Y,TopShelfSpace]);
    }
    echo(Header);
} else if (ScaleFactor == 25.4)
{
    Header = "**********************************";
    Spacer = "----------------------------------------------------";
    c = str("** Cut 4 Legs ",Ht*25.4,"mm Long");
    d = str("** Cut 4 Top Ledge Lengths ",WdTopLedgeLen*25.4,"mm Long");
    e = str("** Cut 2 Top Ledge Widths ",WdTopLedgeWid*25.4,"mm Long");
    FTS = str("** Cut 2 Top Edges ",Len*25.4,"\" x ",EdgeWd_Wid*25.4,"\" Wide");
    FTM = str("** Cut 1 Top Middle ",Len*25.4,"\" x ",TopMidWid*25.4,"\" Wide");
    FL1 = str("** Cut 2 Shelf Ledge Lengths ",WdTopLedgeLen*25.4,"mm Long");
    FW1 = str("** Cut 2 Shelf Ledge Widths ",WdTopLedgeWid*25.4,"mm Long");
    FS1 = str("** Cut 1 shelves ",Len*25.4,"\" x ",ShelfWid*25.4,"mm Wide");
    //ShelfWid
    FL2 = str("** Cut 4 Shelf Ledge Lengths ",WdTopLedgeLen*25.4,"mm Long");
    FW2 = str("** Cut 4 Shelf Ledge Widths ",WdTopLedgeWid*25.4,"mm Long");
    FS2 = str("** Cut 2 shelves ",Len*25.4,"\" x ",ShelfWid*25.4,"mm Wide");
    
    echo(Header);
    echo(c);
    echo(d);
    echo(e);
    echo(FTS);
    echo(FTM);
    echo(Spacer);
    if (Shelf_Qty == 1)
    {
        echo(FL1);
        echo(FW1);
        echo(FS1);
    } else if (Shelf_Qty == 2)
    {
        echo(FL2);
        echo(FW2);
        echo(FS2);
    }
    echo(Header);
}

module Leg()
{
    cube([LegWd24_Wid,LegWd24_Thk,Ht]);
}
//module TopEdge()
//{
//    color("tan",.7)
//    cube([Len,EdgeWd_Wid,EdgeWd_Thk]);  
//}
//module TopMiddle()
//{
//    color("Peru",.7)
//    cube([Len,Wid-(EdgeWd_Wid*2),EdgeWd_Thk]);
//}
module Shelf()
{
    color("Peru",.7)
    cube([Len,ShelfWid,ShelfThk]);
}
module MpcncCornerBlocks()
{
    translate([CNC_X_Loc,CNC_Y_Loc,Ht+EdgeWd_Thk])
    color("blue")
    {
        translate([0,0,0])
        cube([CNC_Corner_Width,CNC_Corner_Width,CNC_Corner_Ht]);
        translate([CNC_Len-CNC_Corner_Width,0,0])
        cube([CNC_Corner_Width,CNC_Corner_Width,CNC_Corner_Ht]);
        translate([CNC_Len-CNC_Corner_Width,CNC_Depth - CNC_Corner_Width,0])
        cube([CNC_Corner_Width,CNC_Corner_Width,CNC_Corner_Ht]);
        translate([0,CNC_Depth - CNC_Corner_Width,0])
        cube([CNC_Corner_Width,CNC_Corner_Width,CNC_Corner_Ht]);
    }
}
module MpcncEmt()
{
    translate([CNC_X_Loc,CNC_Y_Loc,Ht+EdgeWd_Thk])
    color("silver")
    {
        // Y Pipes
        translate([0,CNC_Corner_WidthHalf,PipeY_Z_Loc])
        rotate([0,90,0])
        cylinder(d=EMT_OD,h=CNC_Len,$fn=32);
        translate([0,CNC_Depth-CNC_Corner_WidthHalf,PipeY_Z_Loc])
        rotate([0,90,0])
        cylinder(d=EMT_OD,h=CNC_Len,$fn=32);
        // X Pipes
        translate([CNC_Corner_WidthHalf,0,PipeX_Z_Loc])
        rotate([-90,0,0])
        cylinder(d=EMT_OD,h=CNC_Depth,$fn=32);
        translate([CNC_Len-CNC_Corner_WidthHalf,0,PipeX_Z_Loc])
        rotate([-90,0,0])
        cylinder(d=EMT_OD,h=CNC_Depth,$fn=32);
    }
}
module Lr3CornerBlocks()
{
    Y_Block_Len_Offset = 1;
  
    translate([CNC_X_Loc,CNC_Y_Loc,Ht+EdgeWd_Thk])
    color("purple")
    {
        translate([-Y_Block_Len_Offset,0,0])
          cube([CNC_Corner_Width,CNC_Corner_Length,CNC_Corner_Ht]);
        translate([-Y_Block_Len_Offset,CNC_Depth - CNC_Corner_Length,0])
          cube([CNC_Corner_Width,CNC_Corner_Length,CNC_Corner_Ht]);

        translate([Y_Block_Len_Offset+CNC_Len,0,0])
          cube([CNC_Corner_Width,CNC_Corner_Length,CNC_Corner_Ht]);
        translate([Y_Block_Len_Offset+CNC_Len,CNC_Depth - CNC_Corner_Length,0])
          cube([CNC_Corner_Width,CNC_Corner_Length,CNC_Corner_Ht]);
        
//        translate([CNC_Len-CNC_Corner_Width,0,0])
//        cube([CNC_Corner_Width,CNC_Corner_Width,CNC_Corner_Ht]);

           
//        translate([CNC_Len-CNC_Corner_Width,CNC_Depth - CNC_Corner_Width,0])
//        cube([CNC_Corner_Width,CNC_Corner_Width,CNC_Corner_Ht]);
//        
      
        for ( i = [0 : 8 : 32]){
          translate([CNC_Len-CNC_Corner_Width,i,0])
          cube([CNC_Corner_Width,CNC_Corner_Width / 2,CNC_Corner_Ht / 2]);
        }
    }
    
    // Y-Belt
    translate([CNC_X_Loc,CNC_Y_Loc,Ht+EdgeWd_Thk])
    color("black")
    {

      
        translate([-Y_Block_Len_Offset + 0.1,0, 20/25.4])
          cube([0.1,CNC_Depth,10/25.4]);      

        translate([Y_Block_Len_Offset + CNC_Len-0.1,0, 20/25.4])
          cube([0.1,CNC_Depth,10/25.4]);      
    }
}
module Lr3Emt()
{
    translate([CNC_X_Loc,CNC_Y_Loc,Ht+EdgeWd_Thk])
    color("silver")
    {
        // Y Rail EMT
//        translate([0,CNC_Corner_WidthHalf,PipeY_Z_Loc])
//        rotate([-90,0,0])
//        cylinder(d=EMT_OD,h=CNC_Depth,$fn=32);
      
        translate([CNC_Len-CNC_Corner_WidthHalf,0,PipeY_Z_Loc])
        rotate([-90,0,0])
        cylinder(d=EMT_OD,h=CNC_Depth,$fn=32);
      
        // X Gantry EMT
        translate([0,CNC_Depth/2 - 2,PipeX_Z_Loc + 2])
        rotate([0,90,0])
        cylinder(d=EMT_OD,h=CNC_Len,$fn=32);

        translate([0,CNC_Depth/2 - 2,PipeX_Z_Loc + 6])
        rotate([0,90,0])
        cylinder(d=EMT_OD,h=CNC_Len,$fn=32);

//        translate([CNC_Len-CNC_Corner_WidthHalf,0,PipeX_Z_Loc])
//        rotate([0,90,0])
//        cylinder(d=EMT_OD,h=CNC_Depth,$fn=32);
    }
}
module Lr3YZPlate()
{
  color("purple")
  {
    rotate([90,0,-90]) {
      // https://forum.v1engineering.com/t/minor-lowrider-v3-update/34501
      linear_extrude(height = LR3_YZ_Plate_Thickness, center = false, convexity = 1) {
        scale([1/25.4,1/25.4,1/25.4]) {
          import (file = "../lowrider3/model/YZ plate DXF.dxf");
        }
      }
    }
  }
}
module TopLedges()
{
//Draw The Long Length Ledges (Len)
    color("cyan")
    {
        translate([TopLedgeWd24_Thk,LegWd24_Thk,0])
        cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
        translate([TopLedgeWd24_Thk,Wid-LegWd24_Thk-TopLedgeWd24_Thk,0])
        cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
    }
//Draw the Short Length Ledges (Wid)
    color("green")
    {
        translate([0,LegWd24_Thk,0])
        cube([TopLedgeWd24_Thk,Wid-(LegWd24_Thk*2),TopLedgeWd24_Wid]);
        translate([Len-TopLedgeWd24_Thk,LegWd24_Thk,0])
        cube([TopLedgeWd24_Thk,Wid-(LegWd24_Thk*2),TopLedgeWd24_Wid]);
    }
}
module ShelfLedges()
{
//Draw The Long Length Ledges (Len)
    color("cyan")
    {
        translate([ShelfLedgeWd24_Thk,LegWd24_Thk,0])
        cube([WdShelfLedgeLen,ShelfLedgeWd24_Thk,ShelfLedgeWd24_Wid]);
        translate([ShelfLedgeWd24_Thk,Wid-LegWd24_Thk-ShelfLedgeWd24_Thk,0])
        cube([WdShelfLedgeLen,ShelfLedgeWd24_Thk,ShelfLedgeWd24_Wid]);
    }
//Draw the Short Length Ledges (Wid)
    color("green")
    {
        translate([0,LegWd24_Thk,0])
        cube([ShelfLedgeWd24_Thk,Wid-(LegWd24_Thk*2),ShelfLedgeWd24_Wid]);
        translate([Len-ShelfLedgeWd24_Thk,LegWd24_Thk,0])
        cube([ShelfLedgeWd24_Thk,Wid-(LegWd24_Thk*2),ShelfLedgeWd24_Wid]);
    }
}
scale([ScaleFactor,ScaleFactor,ScaleFactor])
{
    if (CNC_Model == "MPCNC")
    {
      MpcncCornerBlocks();    //Draw 4 corner blocks
      MpcncEmt();             //Draw the EMT
    }
    else if (CNC_Model == "LR3")
    {
      Lr3CornerBlocks();
      Lr3Emt();

      translate([
        CNC_X_Loc,
        CNC_Y_Loc + (CNC_Depth / 2),
        Ht+EdgeWd_Thk + LR3_YZ_Plate_Height])
        Lr3YZPlate();
      
      translate([
        CNC_X_Loc + CNC_Len,
        CNC_Y_Loc + (CNC_Depth / 2),
        Ht+EdgeWd_Thk + LR3_YZ_Plate_Height])
        Lr3YZPlate();
      
      // LR3 Front grill plate
      translate([
        CNC_X_Loc,
        CNC_Y_Loc + (CNC_Depth / 2) - 3,
        Ht+EdgeWd_Thk-2])
        color("gray")
        {
          rotate([90,0,0]) {
            // https://forum.v1engineering.com/t/minor-lowrider-v3-update/34501
            linear_extrude(height = LR3_YZ_Plate_Thickness, center = false, convexity = 1) {
              scale([1/25.4,1/25.4,1/25.4]) {
                import (file = "../lowrider3/front-grill-strut/grill.svg");
                //include <../lowrider3/front-grill-strut/LR3-strut-front-grill.scad>
              }
            }
          }
      }
  
//      difference() {
//linear_extrude(height = 4, center = false, convexity = 1)
//import (file = "YZ plate DXF v1.dxf");
//
//translate([-60,-200, 0])
//cube([145, 250, 4]);
//}
      
    }
    
    // Draw Usable Work Area
    translate([Work_Y_Loc,Work_X_Loc,Ht+EdgeWd_Thk])
    color("red",.5)
    %cube([CNC_WorkLen,CNC_WorkWid,.25]);   

    // Draw Left Y-axis surface "the 1st Top Edge"
    translate([0,0,Ht])
    //%TopEdge();         
    color("#c0c0c0",.7)
    %cube([EdgeWd_Wid,Wid,EdgeWd_Thk]);  
    
    // Draw Right Y-axis surface, "the 2nd Top Edge"
    translate([Len-EdgeWd_Wid,0,Ht])
    //%TopEdge();         
    color("#c0c0c0",.7)
    %cube([EdgeWd_Wid,Wid,EdgeWd_Thk]);  
    
    // Draw the Top Middle (Spoilboard)
    translate([EdgeWd_Wid,0,Ht])
    color("Peru",.7)
    %cube([Len-(EdgeWd_Wid*2),Wid,EdgeWd_Thk]);       
  
    Leg();              //Draw 1st Leg
    translate([0,Wid-LegWd24_Thk,0])
    Leg();              //Draw 2nd Leg
    translate([Len-LegWd24_Wid,0,0])
    Leg();              //Draw 3rd Leg
    translate([Len-LegWd24_Wid,Wid-LegWd24_Thk,0])
    Leg();              //Draw 4th Leg
    
    translate([0,0,Ht-TopLedgeWd24_Wid])
    TopLedges();           //Draw the 4 top outside ledges that top rests on
    if (MidTopLedgeQty == 1)
    {
        translate([TopLedgeWd24_Thk,Wid/2-(LegWd24_Thk/2) ,Ht-TopLedgeWd24_Wid])
        cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
    } else
    {
        translate([TopLedgeWd24_Thk,(Wid/2-(LegWd24_Thk/2))+6,Ht-TopLedgeWd24_Wid])
        cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
        translate([TopLedgeWd24_Thk,(Wid/2-(LegWd24_Thk/2))-6,Ht-TopLedgeWd24_Wid])
        cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
    }
    if (Shelf_Qty > 0)
    {
        translate([0,0,Shelf1_Ht-ShelfLedgeWd24_Wid])
        ShelfLedges();
        translate([0,LegWd24_Thk,Shelf1_Ht])
        Shelf();
    }
    if (Shelf_Qty > 1)
    {
        translate([0,0,Shelf2_Ht-ShelfLedgeWd24_Wid])
        ShelfLedges();
        translate([0,LegWd24_Thk,Shelf2_Ht])
        Shelf();
    }
}