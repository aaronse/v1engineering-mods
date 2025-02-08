////////////////////////////////////////////////////////////////////////////////
// Four Build Stages, Side by Side, with a More Realistic, Open-Frame MPCNC.
//
// Stage 1: Bare plywood (on floor) + MPCNC
// Stage 2: Adds tall 2×4 legs & minimal rails, table top at deskHeight
// Stage 3: Adds lower shelf + DeWalt-style shop vac + orange bucket
// Stage 4: Adds overhead top & enclosure side/back panels
//
// The MPCNC:
//
/*  - Corner blocks (3D-printed) 
    - Outer frame rails (approx 0.92" OD EMT) from corner to corner
    - Center gantry rails for X/Y
    - A Z-axis pipe + tool block
    - Rotated 180° about Z to face the other way
    - Dimensions are approximate to convey the idea of an MPCNC
*/
//
// Author: ChatGPT
// Date: 2025-02-08
////////////////////////////////////////////////////////////////////////////////

//---------------------------
// Global Dimensions
//---------------------------
tableWidth       = 48;     // 2' x 4' => 24"x48"
tableDepth       = 24;
deskHeight       = 30;     // main tabletop height
shelfHeight      = 6;      // lower shelf top
overheadHeight   = 60;     // future enclosure rail height

woodThickness    = 1.5;    // 2x4 thickness
woodWidth        = 3.5;    // 2x4 width
plyThickness     = 0.75;   // 3/4" plywood
enclosureThk     = 0.5;    // 1/2" enclosure panel thickness

// For side-by-side staging
stageSpacing     = 65;     // horizontal offset between stages

//---------------------------
// MPCNC Approx Params
//---------------------------
// We'll place it so the "bottom" of corner blocks is at z=0 
// in the MPCNC's own coordinates. Then we'll translate it 
// in each stage to rest on top of the table.

pipeOD           = 0.92;   // 3/4" EMT OD ~0.92"
cornerBlockSize  = 2;      // each corner block is a 2" cube
outerRailLenX    = 20;     // outer frame X dimension
outerRailLenY    = 16;     // outer frame Y dimension

// The central gantry needs a smaller "inner" region of rails
gantryRailLenX   = 18;     // approximate length of the X direction "center rails"
gantryRailLenY   = 14;     // approximate length of the Y direction "center rails"

rollerSize       = 1.7;    // approximate roller block size
zPipeLength      = 7;      // approximate vertical pipe length above the plane

// We'll place the whole MPCNC offset on the table so it's not at the edge
// (in the MPCNC's local coordinate system, the corners are from (0,0) to (outerRailLenX,outerRailLenY)).
xTableOffset     = 14;     
yTableOffset     = 3;     


//---------------------------
// Helper Modules
//---------------------------

// 1) Simple rectangular 3/4" plywood panel
module plyPanelX(length=48, depth=24, thick=0.75, c="burlywood") {
    color(c)
    cube([length, depth, thick]);
}

// 2) 2×4 leg (vertical)
module leg(height=60, c="brown") {
    color(c)
    cube([woodThickness, woodWidth, height]);
}

// 3) 2×4 rail along X
module railX(len=48, c="brown") {
    color(c)
    cube([len, woodThickness, woodWidth]);
}

// 4) 2×4 rail along Y
module railY(len=24, c="brown") {
    color(c)
    cube([woodThickness, len, woodWidth]);
}

// 5) Shop vac in two-tone (yellow/black)
module shopVacDeWalt() {
    union() {
        // bottom: ~10" dia x 14" tall
        color("yellow")
        cylinder(d=10, h=14, $fn=64);

        // top: ~9" dia x 4" tall
        color("black")
        translate([0,0,14])
            cylinder(d=9, h=4, $fn=64);
    }
}

// 6) Classic orange 5-gal bucket
module homeDepotBucket() {
    // typical ~11.8" dia, 14.5" tall
    color("orange")
    cylinder(d=11.8, h=14.5, $fn=64);
}

// 7) Enclosure panel along X (width × thickness × height)
module enclosurePanelX(width=48, height=30, thick=0.5, c="lightblue") {
    color(c)
    cube([width, thick, height]);
}

// 8) Enclosure panel along Y (thickness × depth × height)
module enclosurePanelY(depth=24, height=30, thick=0.5, c="lightblue") {
    color(c)
    cube([thick, depth, height]);
}


//---------------------------
// MPCNC Model (Approx.)
// - 4 corner blocks: each a 2" cube
// - 4 outer frame rails, connecting the corners
// - "Center rails" (X and Y) for the gantry
// - Rollers, center block, Z pipe & simple tool
// - By default, corner blocks sit on z=0 => 'floor' in local coords.
//   We'll do an external translate to put it on the table.
//
// - Finally, rotate 180° around Z so it faces "the other way."
//---------------------------
module mpcnc() {
    union() {
        //---------------------------------
        // 1) Corner Blocks
        //---------------------------------
        color("darkgray") {
            // front-left
            translate([0, 0, 0])
                cube([cornerBlockSize, cornerBlockSize, cornerBlockSize]);
            // front-right
            translate([outerRailLenX - cornerBlockSize, 0, 0])
                cube([cornerBlockSize, cornerBlockSize, cornerBlockSize]);
            // back-left
            translate([0, outerRailLenY - cornerBlockSize, 0])
                cube([cornerBlockSize, cornerBlockSize, cornerBlockSize]);
            // back-right
            translate([outerRailLenX - cornerBlockSize, outerRailLenY - cornerBlockSize, 0])
                cube([cornerBlockSize, cornerBlockSize, cornerBlockSize]);
        }

        //---------------------------------
        // 2) Outer Frame Rails (connecting corners)
        //---------------------------------
        // We'll place them at the top of the corner blocks => z= cornerBlockSize
        // For horizontal cylinders, we rotate them so "h" extends in X or Y.
        
        color("silver") {
            // front rail (X) from x=(0+cornerBlockSize) to (outerRailLenX-cornerBlockSize)
            // at y= cornerBlockSize/2, z= cornerBlockSize
            lengthFrontX = (outerRailLenX - 2*cornerBlockSize);
            if(lengthFrontX > 0) {
                translate([cornerBlockSize + lengthFrontX, cornerBlockSize/2, cornerBlockSize]) {
                    rotate([0,-90,0])  // rotate so cylinder extends along X
                    cylinder(d=pipeOD, h=lengthFrontX, center=false, $fn=32);
                }
            }
            // back rail (X)
            lengthBackX = (outerRailLenX - 2*cornerBlockSize);
            if(lengthBackX > 0) {
                translate([cornerBlockSize + lengthFrontX, outerRailLenY - cornerBlockSize/2, cornerBlockSize]) {
                    rotate([0,-90,0])
                    cylinder(d=pipeOD, h=lengthBackX, center=false, $fn=32);
                }
            }
            // left rail (Y)
            lengthLeftY = (outerRailLenY - 2*cornerBlockSize);
            if(lengthLeftY > 0) {
                translate([cornerBlockSize/2, cornerBlockSize, cornerBlockSize]) {
                    rotate([0,0,90])
                    cylinder(d=pipeOD, h=lengthLeftY, center=false, $fn=32);
                }
            }
            // right rail (Y)
            lengthRightY = (outerRailLenY - 2*cornerBlockSize);
            if(lengthRightY > 0) {
                translate([outerRailLenX - cornerBlockSize/2, cornerBlockSize, cornerBlockSize]) {
                    rotate([0,0,90])
                    cylinder(d=pipeOD, h=lengthRightY, center=false, $fn=32);
                }
            }
        }

        //---------------------------------
        // 3) Center (Gantry) Rails
        //    We'll place them a bit lower than outer rails (z= cornerBlockSize/2)
        //    So they pass "inside" the frame. 
        //    2 rails in X direction, 2 in Y, just to illustrate the gantry concept.
        //---------------------------------
        color("silver") {
            railZ = cornerBlockSize/2;  // approx
            // front "gantry" rail (X)
            translate([cornerBlockSize, cornerBlockSize+1, railZ + gantryRailLenY / 2]) {
                rotate([0,90,0])
                cylinder(d=pipeOD*0.9, h=gantryRailLenX - 2, center=false, $fn=32);
            }
            // back "gantry" rail (X)
            translate([cornerBlockSize, outerRailLenY - cornerBlockSize-1, railZ + gantryRailLenY / 2]) {
                rotate([0,90,0])
                cylinder(d=pipeOD*0.9, h=gantryRailLenX - 2, center=false, $fn=32);
            }

            // left "gantry" rail (Y)
            translate([cornerBlockSize+1, cornerBlockSize, railZ]) {
                rotate([0,0,90])
                cylinder(d=pipeOD*0.9, h=gantryRailLenY - 2, center=false, $fn=32);
            }
            // right "gantry" rail (Y)
            translate([outerRailLenX - cornerBlockSize -1, cornerBlockSize, railZ]) {
                rotate([0,0,90])
                cylinder(d=pipeOD*0.9, h=gantryRailLenY - 2, center=false, $fn=32);
            }
        }

        //---------------------------------
        // 4) Rollers & Center Block 
        //    Approx. black "roller blocks" where X & Y rails meet
        //---------------------------------
        color("black") {
            // We'll place a small roller block near each intersection 
            // of the center rails. For simplicity, let's do a single center block:
            centerBlockSize = 3;
            centerZ = cornerBlockSize/2 + 1;
            translate([ (outerRailLenX - centerBlockSize)/2, 
                        (outerRailLenY - centerBlockSize)/2, 
                        centerZ ]) 
                cube([centerBlockSize, centerBlockSize, 2]);
        }

        //---------------------------------
        // 5) Z-axis pipe & tool
        //---------------------------------
        color("silver") {
            // place it in the center
            translate([ (outerRailLenX - pipeOD)/2, (outerRailLenY - pipeOD)/2, cornerBlockSize + 1.5])
                cylinder(d=pipeOD*0.9, h=zPipeLength, center=false, $fn=32);
        }
        // Tool block
        color("darkgray") {
            translate([ (outerRailLenX - 2)/2, (outerRailLenY - 2)/2, cornerBlockSize + 1.5])
                cube([2,2,2]);
        }
    }
    
    // Finally, rotate the entire assembly 180° around Z 
    // so it faces the opposite direction.
    rotate([0,0,180]) 
        children(); // This "children()" pass-through allows us to place the union above at a pivot
}

//---------------------------
// Stage 1: Bare plywood on floor + MPCNC
//   The plywood is from z=0..0.75 => top at z=0.75
//   We want the CNC corner blocks to sit exactly on that top => bottom at z=0.75
//---------------------------
module stage1() {
    // Plywood on floor
    translate([0,0,0])
        plyPanelX(tableWidth, tableDepth, plyThickness, "burlywood");

    // Place MPCNC so bottom corner blocks are at z=0.75
    // We'll also shift it in X/Y to place it on the panel.
    translate([xTableOffset, yTableOffset, plyThickness]) 
        mpcnc();
}

//---------------------------
// Stage 2: Add 2×4 legs & minimal rails, tabletop at deskHeight + MPCNC
//   The top spans z=(deskHeight - 0.75).. deskHeight => top at deskHeight
//   So CNC corner blocks should sit at z=deskHeight
//---------------------------
module stage2() {
    // 4 legs
    translate([-woodThickness, -woodWidth, 0])
        leg(overheadHeight,"brown");
    translate([tableWidth, -woodWidth, 0])
        leg(overheadHeight,"brown");
    translate([-woodThickness, tableDepth, 0])
        leg(overheadHeight,"brown");
    translate([tableWidth, tableDepth, 0])
        leg(overheadHeight,"brown");

    // Minimal rails at deskHeight
    translate([0, 0, deskHeight - woodWidth])
        railX(tableWidth, "darkgreen");
    translate([0, tableDepth - woodThickness, deskHeight - woodWidth])
        railX(tableWidth, "darkgreen");
    translate([0, 0, deskHeight - woodWidth])
        railY(tableDepth, "darkgreen");
    translate([tableWidth - woodThickness, 0, deskHeight - woodWidth])
        railY(tableDepth, "darkgreen");

    // Tabletop
    translate([0,0,deskHeight - plyThickness])
        plyPanelX(tableWidth, tableDepth, plyThickness,"burlywood");

    // MPCNC on top (corner blocks at z=deskHeight)
    translate([xTableOffset, yTableOffset, deskHeight]) 
        mpcnc();
}

//---------------------------
// Stage 3: Add lower shelf, shop vac, bucket
//   Shelf at z=(shelfHeight - 0.75).. shelfHeight => top at shelfHeight
//   Table & CNC as in Stage 2
//---------------------------
module stage3() {
    // Reuse Stage 2 geometry
    stage2();

    // Lower shelf rails
    translate([0,0, shelfHeight - woodWidth])
        railX(tableWidth,"orange");
    translate([0, tableDepth - woodThickness, shelfHeight - woodWidth])
        railX(tableWidth,"orange");
    translate([0, 0, shelfHeight - woodWidth])
        railY(tableDepth,"orange");
    translate([tableWidth - woodThickness, 0, shelfHeight - woodWidth])
        railY(tableDepth,"orange");

    // Shelf plywood
    translate([0,0,shelfHeight - plyThickness])
        plyPanelX(tableWidth, tableDepth, plyThickness,"wheat");

    // Shop vac on shelf
    translate([30,8,shelfHeight])
        shopVacDeWalt();

    // 5-gal bucket on shelf
    translate([20,8,shelfHeight])
        homeDepotBucket();
}

//---------------------------
// Stage 4: Add overhead top + enclosure side/back panels
//   Overhead top at z=(overheadHeight - 0.75).. overheadHeight => top at overheadHeight
//   Enclosure from z=deskHeight..overheadHeight => 30" tall
//---------------------------
module stage4() {
    // Reuse Stage 3
    stage3();

    // Overhead rails
    translate([0,0,overheadHeight - woodWidth])
        railX(tableWidth, "gray");
    translate([0, tableDepth - woodThickness, overheadHeight - woodWidth])
        railX(tableWidth, "gray");
    translate([0,0,overheadHeight - woodWidth])
        railY(tableDepth, "gray");
    translate([tableWidth - woodThickness, 0, overheadHeight - woodWidth])
        railY(tableDepth, "gray");

    // Overhead plywood
    translate([0,0,overheadHeight - plyThickness])
        plyPanelX(tableWidth, tableDepth, plyThickness, "lightgray");

    // Side/back enclosure from deskHeight.. overheadHeight => 30" tall
    enclosureH = overheadHeight - deskHeight;

    // left panel
    translate([-enclosureThk, 0, deskHeight])
        enclosurePanelY(tableDepth, enclosureH, enclosureThk, "lightblue");
    // right panel
    translate([tableWidth, 0, deskHeight])
        enclosurePanelY(tableDepth, enclosureH, enclosureThk, "lightblue");
    // back panel
    translate([0, tableDepth, deskHeight])
        enclosurePanelX(tableWidth, enclosureH, enclosureThk, "lightblue");
    // front is open
}

//---------------------------
// Show all four stages side by side
//---------------------------
union() {
    // Stage 1
    translate([0,0,0]) stage1();

    // Stage 2
    translate([stageSpacing,0,0]) stage2();

    // Stage 3
    translate([2*stageSpacing,0,0]) stage3();

    // Stage 4
    translate([3*stageSpacing,0,0]) stage4();
}
