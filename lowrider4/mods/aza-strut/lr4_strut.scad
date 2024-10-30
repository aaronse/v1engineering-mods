// V1E LowRider 4 mod - Custom Front Grill (Strut)
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

// Based on Jamie's OpenSCAD based Strut generator script:
// - https://vector76.github.io/Web_OpenSCAD_Customizer/strut_plate.html

usable_X_inches = 26;
strut_length = 167.75 + (usable_X_inches * 25.4);
num_braces = 6;
front_plate = true;
bottom_plate = true;
dogbones = 3.5;
front_wing_size = 11.75;
front_wing_top = front_wing_size;
front_wing_bot = front_wing_size;

bottom_wing_top = 5.5;
bottom_wing_bot = 5.5;

render_2d = true;


cnc_name = 
  /* Aza's */ "LOWRIDER 4";
  //"Milly McMillFace";

cnc_color = "black";

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
cnc_name_fudge_x = 0; 
cnc_name_fudge_y = 50.4;
v1e_logo_fudge_x = 18;
marker_fudge_y = 0.75;

render_all_digits = false;

marker_font = 
    "roboto:style=condensed";

font_spacing = 0.95;
font_size = 18.5;
increment_font_size = 13.25;
increment_font_spacing = 0.95;
fontTopPos = 75;
bit_diameter = 3.175;
core_width = 166;
zone_height = 30;
zone_padding = 11;
notch_dia = 1.5;

// Computed variables
strike_spacing = bit_diameter * 3;
fontLineHeight = increment_font_size + 3;
num_keys = calcNumBraces(strut_length, num_braces);
key_pitch = (strut_length - 18)/(num_keys-1);



include <fontWidthProportions.scad>
include <lr4-ass-profile.scad>

fontWidthProportions = findFontWidthProportions(cnc_name_font)[1];

// Recursive function to compute text width.  Required to workaround OpenSCAD
// not supporting variable value accumulation/mutation within loops.  Reason 
// is OpenSCAD isn't a true iterative language despite how the syntax looks.
function calcTextWidth(s, i=0, ret=0) = 
  i<len(s) ? 
    calcTextWidth(s, i+1, ret + fontWidthProportions[ord(s[i])] * font_size) 
    : ret;

totalCharWidth = calcTextWidth(cnc_name);

function calcNumBraces(xLen, numBraces) =
	numBraces ? numBraces : ceil(xLen / 200) + 1;



if (render_2d) {
  color(cnc_color) rz(90) plates_2d();
}
else {
	rz(90)
  rx(90)
  color(cnc_color) linear_extrude(height=1)
  plates_2d();
}


module plates_2d() {
  if (front_plate) {
			ty(front_wing_bot) strut_plate(strut_length, num_braces, 1, front_wing_top, front_wing_bot);
			
  }
  if (bottom_plate) {
    ty(-95) strut_plate(strut_length, num_braces, 0, bottom_wing_top, bottom_wing_bot);
  }
}

module strut_plate(xlen, nbraces_=0, isFront = 0, extra_top, extra_bot) {
  margin = 0.25;
  nbraces = nbraces_ ? nbraces_ : ceil(xlen / 200) + 1;
  
  nspaces = nbraces-1;
  pitch = (xlen-18)/nspaces;
	
	
	union() {
		
		difference() {
			union() {
				// main rectangle
				tx(0.25) square([xlen-0.5, 67.5]);
				
				// extensions
				totalHeight = 67.5 + (extra_top + extra_bot);
				totalWidth = xlen-0.5;
				for (i=[0:nbraces-2])
					tx(18+margin+i*pitch) ty(-extra_bot) 
						square([pitch-18-2*margin, totalHeight]);
			
				echo(str("isFront : ", isFront, ", totalHeight : ", totalHeight, ", totalWidth : ", totalWidth));
			}
		
			// holes
			ty([5.75, 67.5-5.75]) tx([for (i=[0:nbraces-1]) i*pitch + 9]) 
			circle(d=5.3, $fn=36);
			
			// other features
			if (isFront == 1) {
				ty(30.49) square([5.25, 12]);
				
				// right side large notch
				tx(xlen-35.25) ty(10.85) square([35, 19.1]);
			}
			
			// Remove dogbones for notches
			if (dogbones > 0) {
				for (i=[0:nbraces-2])
					tx(18+margin+i*pitch) {
						rz(45) tx(-dogbones/2) circle(d=dogbones, $fn=30);
						ty(67.5) rz(-45) tx(-dogbones/2) circle(d=dogbones, $fn=30);
						
						tx(pitch-18-2*margin) {
							rz(-45) tx(dogbones/2) circle(d=dogbones, $fn=30);
							ty(67.5) rz(45) tx(dogbones/2) circle(d=dogbones, $fn=30);
						}
					}
			}
			
		
			// Front Strut details
			if (isFront == 1)
			{
				// Scaled CNC assembly profile 
				tx(23 + 15 + key_pitch * 2) ty(31)
					draw_cnc(scale = 1/8, circle_dia = 3.5, thickness = 1.5);			
				
				// V1E Logo
				//translate([31 + key_pitch, 57])
				translate([-26 + key_pitch + v1e_logo_fudge_x, 30])
				scale([1.01,1])
					import("v1e/v1e.svg");
//				translate([28 + key_pitch + v1e_logo_fudge_x, 20])
//				scale([.8,.8])
//					import("v1e/v1e-logo.svg");

				// Got .SVG Logo?  Display it here...
				//  translate([(key_pitch * 2) + cnc_name_fudge_x, 54])
				//  scale([0.8,0.8])
				//    import("v1e/tri_logo.svg");
				
				// Your LowRiders's name
				translate([((key_pitch - totalCharWidth) / 2) + (key_pitch * 3) + cnc_name_fudge_x, cnc_name_fudge_y])
					text(
						cnc_name,
						font = cnc_name_font,
						valign = "top",
						size = font_size,
						spacing = font_spacing);
				
				// Measurement markers
				// 100mm increment markers
				for (i=[0:100:strut_length - core_width]) {
					if (render_all_digits) {
						s = str(i);
						y = (i < 10) ? (fontTopPos - (3 * fontLineHeight))
											: (i < 100) ? (fontTopPos - (2 * fontLineHeight))
											: (i < 1000) ? (fontTopPos - fontLineHeight)
											: fontTopPos;
						
						translate([i + (core_width / 2), y - extra_bot + marker_fudge_y])
						text(
							s,
							font = marker_font,
							direction = "btt",
							size = increment_font_size,
							spacing = increment_font_spacing);
						
					} else {
						s = str(i / 100);
						y = (fontTopPos - (3 * fontLineHeight));
						
						translate([i + (core_width / 2), y - extra_bot + marker_fudge_y])
						text(
							s,
							font = marker_font,
							direction = "btt",
							size = increment_font_size,
							spacing = increment_font_spacing);
					}
					

				}		
				
				// Last usable marker
				{
					lastNum = round(strut_length - core_width);
					y = (lastNum < 10) ? (fontTopPos - (3 * fontLineHeight))
						: (lastNum < 100) ? (fontTopPos - (2 * fontLineHeight))
						: (lastNum < 1000) ? (fontTopPos - fontLineHeight)
						: fontTopPos;
					translate([lastNum + (core_width / 2), y - extra_bot])
						text(
							str(lastNum),
							font = marker_font,
							direction = "btt",
							size = increment_font_size,
							spacing = increment_font_spacing);
				}
				
				
				// Draw 50mm increment notches
				// Positioned as close to edge as possible without being considered part of the Strut's exterior contour
				for (i=[0:50:strut_length - core_width])
					translate([i + (core_width / 2), (bit_diameter / 2) - extra_bot])
						hull() for (y=[0, 6]) translate([0, y]) circle(d= notch_dia, $fn=10);
						
				// Last Notch
				translate([strut_length - (core_width / 2), (bit_diameter / 2) - extra_bot])
						hull() for (y=[0, 6]) translate([0, y]) circle(d= notch_dia, $fn=10);

				// Left NOT Usable Zone
				// TODO: Simplify this fugly abomination
				for (i=[zone_padding + strike_spacing + strike_spacing:strike_spacing:(core_width / 2) - bit_diameter]) {
					translate([i, 5 - front_wing_bot]) hull() {
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
				for (i=[bit_diameter:strike_spacing:(core_width / 2) - zone_padding - strike_spacing - strike_spacing]) {
					translate([strut_length - (core_width / 2) + i, 5 - front_wing_bot]) hull() {
						for (y=[0, zone_height]) {
							tx = (i + y > (core_width / 2) - zone_padding) ? -i + (core_width / 2) - zone_padding : y;
							ty = (i + y > (core_width / 2) - zone_padding) ? -(y + i - ((core_width / 2) - zone_padding + zone_height)) : y;

							if (tx != -i + (core_width / 2) - zone_padding || ty > 5) {
								translate([tx, ty]) circle(d=bit_diameter, $fn=10);
							}
						}
					}
				}
				
			}
		}
		
		// Add back material that was overly cut...  We need outer contour shape that won't confuse CAM software.
		
		// Border for cut out
		tx(xlen-37.75) ty(10.85) square([2.5, 19.1]);
		tx(xlen-38.25) ty(8.35) square([35, 2.5]);
  }
}

module tq(q, v)
  if (is_list(q)) for (qq=q) tq(qq, v) children();
  else translate(q*v) children();

module tx(q) tq(q, [1, 0, 0]) children();
module ty(q) tq(q, [0, 1, 0]) children();
module tz(q) tq(q, [0, 0, 1]) children();

module rq(q, v)
  if (is_list(q)) for (qq=q) rq(qq, v) children();
  else rotate(q*v) children();

module rx(q) rq(q, [1, 0, 0]) children();
module ry(q) rq(q, [0, 1, 0]) children();
module rz(q) rq(q, [0, 0, 1]) children();