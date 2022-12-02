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
//
// Table Taxonomy
//  - Top
//  - Box Apron/Skirt, rim boards under table top
//  - Left|Right|Front|Back Side Rail spans between legs
//  - Side Stretcher, spans between front and back legs
//  - Left|Right Front|Back Leg
//  - Knee:  Top of leg
//  - Foot:  Bottom of leg
//
// CUSTOMIZER VARIABLES
// If you want your MPCNC corners to be right at corners of table,
// Set Len & Wid the same as your CNC_LEN & CNC_Depth
Render_CNC = 1;             // Flag indicating whether to Render CNC 
                            // (Set 0 if only want to render and export 
                            // Table model)
Render_Table = 1;

Table_Len = 63.75;                // Length of Table
Table_Wid = 36;                   // Width of Table
Table_OverHang = 2;               // Table surface overhang (excluding Alu extrusion)

Legs_Len = Table_Len - (Table_OverHang * 2);
Legs_Wid = Table_Wid - (Table_OverHang * 2);

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
CNC_WorkLen = 49.5;     // X axis usable work area
CNC_WorkDepth = 24;   // Y axis usable work area

// See LR3 Calculator/Dimensions, https://docs.v1engineering.com/img/lr3/LR3%20Dims.jpg
LR3_InsideWidth = CNC_WorkLen + ((180 + 40) / 25.4);
LR3_OverallWidth = LR3_InsideWidth + (100 / 25.4);

// LR3 overall Machine dimension along X Axis
CNC_Len = LR3_InsideWidth;

echo(str("Table_Len = ", Table_Len, 
  ", LR3_OverallWidth = ", LR3_OverallWidth,
  ", CNC_Len = ", CNC_Len,
  ", CNC_WorkLen = ", CNC_WorkLen));
  

//   including Y-Rail length
CNC_Depth = CNC_WorkDepth + (295 / 25.4);          // LR3 overall Machine dimension along Y Axis, 

LR3_YZ_Plate_Height = 200 / 25.4;
LR3_YZ_Plate_Thickness = 0.5;
CNC_Corner_Width = 18 / 25.4;
CNC_Corner_Length = 55 / 25.4;
CNC_Corner_Ht = 40 / 25.4;

CNC_Y_Pos = 210 / 25.4; //CNC_Depth / 2; // $t * CNC_Depth;

// MPCNC Machine Dimensions:
//CNC_Len = 43;       //Length of Physical MPCNC (subtract 11 for work Length)
//                    //Length is the Y-Axis on my machine
//CNC_Depth = 33;       //Width of Physical MPCNC (subtract 11 for work Width)
//                    //Width is the X-Axis on my machine
//Your actual work area will probably be less depending on
//what size router you are using & how wide your tool holder is
//CNC_WorkLen = CNC_Len - 11;         //Work area Length of MPCNC router
//CNC_WorkDepth = CNC_Depth - 11;         //Work area Width of MPCNC router
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

Work_Y_Loc = (Table_Len - CNC_WorkLen)/2; //X & Y locations of work area in this drawing
Work_X_Loc = (Table_Wid - CNC_WorkDepth)/2;

TopMidWid = Table_Wid-(EdgeWd_Wid*2);


Table_Len2 = Table_Len / 2;
Table_Wid2 = Table_Wid / 2;
CNC_Len2 = CNC_Len / 2;
CNC_Depth2 = CNC_Depth / 2;
CNC_Corner_WidthHalf = CNC_Corner_Width / 2;

WdTopLedgeLen = Legs_Len - (TopLedgeWd24_Thk * 2);
WdTopLedgeWid = Legs_Wid - (TopLedgeWd24_Thk * 2);

WdShelfLedgeLen = Legs_Len - (ShelfLedgeWd24_Thk * 2);
WdShelfLedgeWid = Legs_Wid - (ShelfLedgeWd24_Thk * 2);
ShelfWid = Legs_Wid - (LegWd24_Thk * 2);    //Width of each of the 1 or 2 shelf tops

CNC_X_Loc = Table_Len2-CNC_Len2;    //MPCNC router X location from Lower Left corner
CNC_Y_Loc = Table_Wid2-CNC_Depth2;    //MPCNC router Y location from Lower Left corner
PipeY_Z_Loc = 22.8 / 25.4;  //EMT Y Axis Z Height Location from base of Corner block
PipeX_Z_Loc = 50.4 / 25.4;  //EMT X Axis Z Height Location from base of Corner block

//Output Cut Data
if (ScaleFactor == 1)
{
    //OutputCutData();
} else if (ScaleFactor == 25.4)
{
    Header = "**********************************";
    Spacer = "----------------------------------------------------";
    c = str("** Cut 4 Legs ",Ht*25.4,"mm Long");
    d = str("** Cut 4 Top Ledge Lengths ",WdTopLedgeLen*25.4,"mm Long");
    e = str("** Cut 2 Top Ledge Widths ",WdTopLedgeWid*25.4,"mm Long");
    FTS = str("** Cut 2 Top Edges ",Table_Len*25.4,"\" x ",EdgeWd_Wid*25.4,"\" Wide");
    FTM = str("** Cut 1 Top Middle ",Table_Len*25.4,"\" x ",TopMidWid*25.4,"\" Wide");
    FL1 = str("** Cut 2 Shelf Ledge Lengths ",WdTopLedgeLen*25.4,"mm Long");
    FW1 = str("** Cut 2 Shelf Ledge Widths ",WdTopLedgeWid*25.4,"mm Long");
    FS1 = str("** Cut 1 shelves ",Table_Len*25.4,"\" x ",ShelfWid*25.4,"mm Wide");
    //ShelfWid
    FL2 = str("** Cut 4 Shelf Ledge Lengths ",WdTopLedgeLen*25.4,"mm Long");
    FW2 = str("** Cut 4 Shelf Ledge Widths ",WdTopLedgeWid*25.4,"mm Long");
    FS2 = str("** Cut 2 shelves ",Table_Len*25.4,"\" x ",ShelfWid*25.4,"mm Wide");
    
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
module OutputCutData()
{
    
    Header = "*******************************";
    Spacer = "----------------------------------------------";
    c = str("** Cut 4 Legs ",Ht,"\" Long");
    d1 = str("** Cut 3 Top Ledge Lengths ",WdTopLedgeLen,"\" Long");
    d2 = str("** Cut 4 Top Ledge Lengths ",WdTopLedgeLen,"\" Long");
    e = str("** Cut 2 Top Ledge Widths ",WdTopLedgeWid,"\" Long");
    FTS = str("** Cut 2 Top Edges ",Table_Len,"\" x ",EdgeWd_Wid,"\" Wide");
    FTM = str("** Cut 1 Top Middle ",Table_Len,"\" x ",TopMidWid,"\" Wide");
    FL1 = str("** Cut 2 Shelf Ledge Lengths ",WdTopLedgeLen,"\" Long");
    FW1 = str("** Cut 2 Shelf Ledge Widths ",WdTopLedgeWid,"\" Long");
    FS1 = str("** Cut 1 shelves ",Table_Len,"\" x ",ShelfWid,"\" Wide");
    //ShelfWid
    FL2 = str("** Cut 4 Shelf Ledge Lengths ",WdTopLedgeLen,"\" Long");
    FW2 = str("** Cut 4 Shelf Ledge Widths ",WdTopLedgeWid,"\" Long");
    FS2 = str("** Cut 2 shelves ",Table_Len,"\" x ",ShelfWid,"\" Wide");
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
}
module Leg()
{
    cube([LegWd24_Wid,LegWd24_Thk,Ht]);
}
//module TopEdge()
//{
//    color("tan",.7)
//    cube([Table_Len,EdgeWd_Wid,EdgeWd_Thk]);  
//}
//module TopMiddle()
//{
//    color("Peru",.7)
//    cube([Table_Len,Table_Wid-(EdgeWd_Wid*2),EdgeWd_Thk]);
//}
module Shelf()
{
    color("Peru",.7)
    cube([Legs_Len,ShelfWid,ShelfThk]);
}
module MpcncCornerBlocks()
{
    translate([CNC_X_Loc,CNC_Y_Loc,0])
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
    translate([CNC_X_Loc,CNC_Y_Loc,0])
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

//        translate([-Y_Block_Len_Offset,-1,0])
//          cube([LR3_OverallWidth,1,1]);
        

        for ( i = [0 : 8 : 32]){
          translate([CNC_Len-CNC_Corner_Width,i,0])
          cube([CNC_Corner_Width,CNC_Corner_Width / 2,CNC_Corner_Ht / 2]);
        }
    }
    
    // Y-Belt
    color("black")
    {
        translate([-Y_Block_Len_Offset + 0.1,0, 20/25.4])
          cube([0.1,CNC_Depth,10/25.4]);      

        translate([Y_Block_Len_Offset + CNC_Len-0.1,0, 20/25.4])
          cube([0.1,CNC_Depth,10/25.4]);      
    }
}
module Lr3EmtXAxis()
{
    color("silver")
    {
        // X Gantry EMT
        translate([0,-2.75,PipeX_Z_Loc + 1.75])
        rotate([0,90,0])
        cylinder(d=EMT_OD,h=CNC_Len,$fn=32);

        translate([0,-2,PipeX_Z_Loc + 6])
        rotate([0,90,0])
        cylinder(d=EMT_OD,h=CNC_Len,$fn=32);
    }
}
module Lr3EmtYAxis()
{
    color("silver")
    {
        // Y Rail EMT
        translate([CNC_Len-CNC_Corner_WidthHalf,0,PipeY_Z_Loc])
        rotate([-90,0,0])
        cylinder(d=EMT_OD,h=CNC_Depth,$fn=32);
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
module Lr3FrontGrill()
{
  color("gray")
  {
    rotate([90,0,0])
    {
      // https://forum.v1engineering.com/t/minor-lowrider-v3-update/34501
      linear_extrude(height = LR3_YZ_Plate_Thickness, center = false, convexity = 1)
      {
        scale([1/25.4,1/25.4,1/25.4])
        {
          import (file = "../lowrider3/front-grill-strut/grill.svg");
          //include <../lowrider3/front-grill-strut/LR3-strut-front-grill.scad>
        }
      }
    }
  }
}
module Lr3Braces()
{
  LR3_Brace_Spacing = 200 / 25.4;

  color("purple")
  {
  
    for ( i = [0 : CNC_Len / LR3_Brace_Spacing])
    {
      translate([i * LR3_Brace_Spacing, 3, 2])
      {
        rotate([-90,0,-90]) {
        
          // https://forum.v1engineering.com/t/minor-lowrider-v3-update/34501
          scale([1/25.4,1/25.4,1/25.4]) {
            import (file = "../lowrider3/model/brace-23p4.3mf");
          }
        }
      }
    }
  }
}
module TopLedges()
{
//Draw The Long Length Ledges (Legs_Len)
    color("cyan")
    {
        translate([TopLedgeWd24_Thk,LegWd24_Thk,0])
        cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
        translate([TopLedgeWd24_Thk,Legs_Wid-LegWd24_Thk-TopLedgeWd24_Thk,0])
        cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
    }
//Draw the Short Length Ledges (Legs_Wid)
    color("green")
    {
        translate([0,LegWd24_Thk,0])
        cube([TopLedgeWd24_Thk,Legs_Wid-(LegWd24_Thk*2),TopLedgeWd24_Wid]);
        translate([Legs_Len-TopLedgeWd24_Thk,LegWd24_Thk,0])
        cube([TopLedgeWd24_Thk,Legs_Wid-(LegWd24_Thk*2),TopLedgeWd24_Wid]);
    }
}
module ShelfLedges()
{
//Draw The Long Length Ledges (Legs_Len)
    color("cyan")
    {
        translate([ShelfLedgeWd24_Thk,LegWd24_Thk,0])
        cube([WdShelfLedgeLen,ShelfLedgeWd24_Thk,ShelfLedgeWd24_Wid]);
        translate([ShelfLedgeWd24_Thk,Legs_Wid-LegWd24_Thk-ShelfLedgeWd24_Thk,0])
        cube([WdShelfLedgeLen,ShelfLedgeWd24_Thk,ShelfLedgeWd24_Wid]);
    }
//Draw the Short Length Ledges (Legs_Wid)
    color("green")
    {
        translate([0,LegWd24_Thk,0])
        cube([ShelfLedgeWd24_Thk,Legs_Wid-(LegWd24_Thk*2),ShelfLedgeWd24_Wid]);
        translate([Legs_Len-ShelfLedgeWd24_Thk,LegWd24_Thk,0])
        cube([ShelfLedgeWd24_Thk,Legs_Wid-(LegWd24_Thk*2),ShelfLedgeWd24_Wid]);
    }
}
module Lr3()
{
  // LR3 Rigid structures
  translate([CNC_X_Loc,CNC_Y_Loc, 0])
  {
    Lr3CornerBlocks();
    Lr3EmtYAxis();
  }

  // LR3 Mobile gantry
  translate([CNC_X_Loc, CNC_Y_Loc + CNC_Y_Pos, 0])
  {
    Lr3EmtXAxis();
    
    translate([0, 0, LR3_YZ_Plate_Height])
    Lr3Braces();
    
    translate([0, 0, LR3_YZ_Plate_Height])
    Lr3YZPlate();
    
    translate([CNC_Len, 0, LR3_YZ_Plate_Height])
    Lr3YZPlate();
    
    translate([0, -3, -2])
    Lr3FrontGrill();
  }

}
scale([ScaleFactor,ScaleFactor,ScaleFactor])
{
    translate([0,0,Ht+(2*EdgeWd_Thk)])
    {
      if (Render_CNC == 1)
      {
        if (CNC_Model == "MPCNC")
        {
          MpcncCornerBlocks();    //Draw 4 corner blocks
          MpcncEmt();             //Draw the EMT
        }
        else if (CNC_Model == "LR3")
        {
          Lr3();
        }
      }
    }
    
    if (Render_Table == 1)
    {
      translate([0,0,Ht])
      //%TopEdge();         
      color("Peru",.7)
      cube([Table_Len,Table_Wid,EdgeWd_Thk]);  

      translate([0,0,EdgeWd_Thk])
      {
        
        // Draw Usable Work Area
        translate([Work_Y_Loc,Work_X_Loc,Ht+EdgeWd_Thk])
        color("red",.5)
      %cube([CNC_WorkLen,CNC_WorkDepth,.25]);   

        // Draw Left Y-axis surface "the 1st Top Edge"
        translate([0,0,Ht])
        //%TopEdge();         
        color("#c0c0c0",.7)
      cube([EdgeWd_Wid,Table_Wid,EdgeWd_Thk]);  
        
        // Draw Right Y-axis surface, "the 2nd Top Edge"
        translate([Table_Len-EdgeWd_Wid,0,Ht])
        //%TopEdge();         
        color("#c0c0c0",.7)
      cube([EdgeWd_Wid,Table_Wid,EdgeWd_Thk]);  
     
      // Draw Front surface no-cut zone
        translate([EdgeWd_Wid,0,Ht])
        //%TopEdge();         
        color("Peru",.7)
        cube([Table_Len-(2 * EdgeWd_Wid),EdgeWd_Wid,EdgeWd_Thk]);  

        translate([EdgeWd_Wid,Table_Wid - EdgeWd_Wid,Ht])
        //%TopEdge();         
        color("Peru",.7)
        cube([Table_Len-(2 * EdgeWd_Wid),EdgeWd_Wid,EdgeWd_Thk]);  
        
        // Draw the Top Middle (Spoilboard)
    //    translate([EdgeWd_Wid,0,Ht])
    //    color("Peru",.7)
    //  %cube([Table_Len-(EdgeWd_Wid*2),Table_Wid,EdgeWd_Thk]);       
      }
  
      translate([Table_OverHang,Table_OverHang,0])
      {
        Leg();              //Draw 1st Leg
        translate([0,Legs_Wid-LegWd24_Thk,0])
        Leg();              //Draw 2nd Leg
        translate([Legs_Len-LegWd24_Wid,0,0])
        Leg();              //Draw 3rd Leg
        translate([Legs_Len-LegWd24_Wid,Legs_Wid-LegWd24_Thk,0])
        Leg();              //Draw 4th Leg

        // Mid span Internal rail(s) supporting table top
        if (MidTopLedgeQty == 1)
        {
            translate([TopLedgeWd24_Thk,Table_Wid/2-(LegWd24_Thk/2),Ht-TopLedgeWd24_Wid])
            cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
        } else
        {
            translate([TopLedgeWd24_Thk,(Legs_Wid/2-(LegWd24_Thk/2))+6,Ht-TopLedgeWd24_Wid])
            cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
            translate([TopLedgeWd24_Thk,(Legs_Wid/2-(LegWd24_Thk/2))-6,Ht-TopLedgeWd24_Wid])
            cube([WdTopLedgeLen,TopLedgeWd24_Thk,TopLedgeWd24_Wid]);
        }

        // Shelf 1 (Bottom)
        if (Shelf_Qty > 0)
        {
            translate([0,0,Shelf1_Ht-ShelfLedgeWd24_Wid])
            ShelfLedges();
            translate([0,LegWd24_Thk,Shelf1_Ht])
            Shelf();
        }
        
        // Shelf 2 (Middle)
        if (Shelf_Qty > 1)
        {
            translate([0,0,Shelf2_Ht-ShelfLedgeWd24_Wid])
            ShelfLedges();
            translate([0,LegWd24_Thk,Shelf2_Ht])
            Shelf();
        }

        // Draw the 4 top outside box apron/rails that top rests on
        translate([0,0,Ht-TopLedgeWd24_Wid])
        TopLedges();
      }
      
      VAC_Diameter = 20;
      VAC_Height = 20;
      
      color("orange")
      translate([
        Table_OverHang + VAC_Diameter/2,
        Table_OverHang + Legs_Wid/2,
        Shelf1_Ht])
      rotate([0,0,0])
      cylinder(d=VAC_Diameter,h=VAC_Height,$fn=32);
  }
}