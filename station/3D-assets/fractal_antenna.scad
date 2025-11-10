// Parameters for the fractal
level = 4;         // Recursion depth
length = 40;       // Length of the initial segment
angle = 60;        // Angle for the arrowhead fractal pattern
tube_diameter = 2; // Diameter of the tubes (antennas)

// Function to generate and store the fractal lines (tubes)
module arrowhead_fractal(level, p1, p2) {
    if (level == 0) {
        // Base case: just add the tube (line) from p1 to p2
        draw_line(p1, p2);
    } else {
        // Midpoint of the segment p1-p2
        midpoint = [(p1[0] + p2[0]) / 2, (p1[1] + p2[1]) / 2, (p1[2] + p2[2]) / 2];

        // Calculate the offset for the fractal arrowhead (rotation of 60 degrees)
        offset = [0, length * sqrt(3) / 2, 0];  // Vertical offset for arrowhead pattern
        offset = offset * (1 / 2); // Scale based on recursion level

        // Recursively generate smaller fractal segments
        arrowhead_fractal(level - 1, p1, midpoint + offset);  // First segment
        arrowhead_fractal(level - 1, midpoint + offset, p2);  // Second segment
    }
}

// Function to draw a tube (line) between two points
module draw_line(p1, p2) {
    // Create a tube between points p1 and p2
    // Use the OpenSCAD "cylinder" function to draw the tube (a line segment)
    
    // Calculate the distance between the two points
    dist = distance(p1, p2);

    // Calculate the axis of the line (direction from p1 to p2)
    direction = normalize(p2 - p1);

    // Create a cylinder between p1 and p2 (with given diameter and length)
    translate(p1)
        rotate(a = [0, 0, atan2(direction[1], direction[0])])
            rotate([90, 0, 0]) 
                cylinder(h = dist, r1 = tube_diameter / 2, r2 = tube_diameter / 2);
}

// Calculate the distance between two points
function distance(p1, p2) = sqrt((p2[0] - p1[0])^2 + (p2[1] - p1[1])^2 + (p2[2] - p1[2])^2);

// Initial points for the fractal line (start and end)
start_point = [0, 0, 0];         // Starting point
end_point = [length, 0, 0];      // Ending point (along X-axis)

// Generate the fractal by recursively drawing tubes
arrowhead_fractal(level, start_point, end_point);
