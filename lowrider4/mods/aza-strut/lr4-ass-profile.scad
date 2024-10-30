// Parameters for the dimensions
line_thickness = 2;


// Function to calculate distance between two points
function dist(p1, p2) = sqrt(pow(p2[0] - p1[0], 2) + pow(p2[1] - p1[1], 2));

// Function to draw a line between two points
/*
module draw_line(p1, p2, thickness) {
    translate([(p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2, 0])
        rotate([0, 0, atan2(p2[1] - p1[1], p2[0] - p1[0])])
        cube([dist(p1, p2), thickness, thickness], center = true);
}
*/

module draw_line(p1, p2, thickness) {
    translate([(p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2]) // Translate to midpoint
        rotate(atan2(p2[1] - p1[1], p2[0] - p1[0])) // Rotate the line to match the angle
            square([dist(p1, p2), thickness], center = true); // Draw a 2D line with thickness
}


/*
// Function to draw a green circle
module draw_circle(pos, circle_dia, thickness) {
    translate([pos[0], pos[1], 0])
        color([0, 1, 0])
        cylinder(h = thickness, r = circle_dia / 2, center = true);
}
*/

// Module to draw a 2D circle with a given diameter
module draw_circle(pos, circle_dia, thickness) {
    translate([pos[0], pos[1]])  // Translate to the position
        color([0, 1, 0])         // Green color for the circle (optional in 2D rendering)
            circle(d = circle_dia, $fn = 20);  // Draw a 2D circle with the given diameter
}


// Function to calculate distance between two points along X-axis (width)
function dist_x(p1, p2) = abs(p2[0] - p1[0]);

// Function to calculate distance between two points along Y-axis (height)
function dist_y(p1, p2) = abs(p2[1] - p1[1]);

function t(p, tx, ty) = [p[0] + tx, p[1] + ty];

// Module to draw a hollow square (outline) given two points
module draw_square(p1, p2, thickness) {
		lt = thickness;
	
    // Calculate the bottom-left corner based on p1 and p2
    x_pos = min(p1[0], p2[0]);
    y_pos = min(p1[1], p2[1]);

    // Calculate the width and height based on the two points
    width = dist_x(p1, p2);
    height = dist_y(p1, p2);

    // Draw the four lines (edges) of the hollow square

		// Bottom line
		draw_line([x_pos - lt / 2, y_pos], [x_pos + width + lt / 2, y_pos], lt);

		// Top line
		draw_line([x_pos - lt / 2, y_pos + height], [x_pos + width + lt / 2, y_pos + height], lt);

		// Left vertical line
		draw_line([x_pos, y_pos], [x_pos, y_pos + height], lt);

		// Right vertical line
		draw_line([x_pos + width, y_pos], [x_pos + width, y_pos + height], lt);
}

// Drawing the frame and connections
module draw_cnc(scale = 1 / 4, circle_dia = 6, thickness = 2) {
		sw = 828 * scale;			// Strut width
		sh = 90.5 * scale;		// Strut height	
		cw = (167.5 * scale);	// Core width
		ch = (195 * scale);		// Core height
		yzh = 175 * scale;		// YZ Plate height
		yzw = 42 * scale;			// YZ Plate width

    // Coordinates of points (estimated from the diagram proportions)
    y1 = [0, 0];  		// Bottom left point
    y2 = [sw, 0];  	// Bottom right point
    z1 = [0, yzh];  	// Top left point
    z2 = [sw, yzh];  // Top right point
    x = [sw / 2 - cw / 2, yzh - sh];  		// Middle point (router head)
		ctl = [sw / 2 - (cw / 2), yzh * 1.3 ];	// Core top left
		cbr = [sw / 2 + (cw / 2), yzh * 1.3 - ch];		// Core bottom right
		p = [sw / 2, 0];

		lt = thickness;
		draw_square([-yzw / 2, 0], [yzw / 2, yzh], lt);
		draw_square([-yzw / 2 + sw, 0], [yzw / 2 + sw, yzh], lt);

		// Beam Top horizontal lines
		draw_line(t(z1, yzw / 2, -lt), t(z1, ctl[0], -lt), lt);  
		draw_line(t(z2, -ctl[0], -lt), t(z2, -yzw / 2, -lt), lt);  
		// Beam Bot horizontal lines
		draw_line(t(z1, yzw / 2, -sh), t(z1, ctl[0], -sh), lt);  
		draw_line(t(z2, -ctl[0], -sh), t(z2, -yzw / 2, -sh), lt);  

		// Core
		draw_square(ctl, cbr, lt);
	
		// Drill bit to probe
		draw_line(t(cbr, -cw / 2, 0), p, lt);

    // Draw green circles at the connection points
		cd = circle_dia;
    cr = circle_dia / 2;
		draw_circle(t(y1, 0, cr), cd, lt);  // Bottom left
    draw_circle(t(y2, 0, cr), cd, lt);  // Bottom right
    draw_circle(t(z1, 0, -cr), cd, lt);  // Top left
    draw_circle(t(z2, 0, -cr), cd, lt);  // Top right
    draw_circle(x, cd, lt);  	// Middle (router head)
		draw_circle(p, cd, lt);  	// Middle (probe)
}

// Run the CNC drawing module
//draw_cnc();