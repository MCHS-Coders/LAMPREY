// Function to draw a line segment
module draw_segment(length) {
    // A simple line is represented by a small rectangle (polygon)
    polygon([[0, 0], [length, 0]]);
}

// Recursive Fractal Tree Function
module fractal_tree(level, length, angle) {
    if (level == 0) {
        draw_segment(length); // Base case: Draw a segment
    } else {
        // Draw the current segment
        draw_segment(length);

        // Move to the next position and recursively draw the left and right branches
        push();
        rotate([0, 0, angle]); // Rotate the segment to the right
        translate([length, 0]) // Move to the end of the current segment
        fractal_tree(level - 1, length / 2, -angle); // Left branch
        pop();

        push();
        rotate([0, 0, -angle]); // Rotate the segment to the left
        translate([length, 0]) // Move to the end of the current segment
        fractal_tree(level - 1, length / 2, angle); // Right branch
        pop();
    }
}

// Main Code to draw multiple trees
d = 220; // Distance factor
b = 300; // Base offset for positioning the fractal trees

// Loop to draw multiple fractal trees at different positions
for (level = [0:6]) {
    x_offset = d * floor(level / 3) - b;
    y_offset = d * (level % 3) - b;

    // Position the fractal tree at the desired location
    translate([x_offset, y_offset]) {
        rotate([0, 0, 60 * (level % 2 == 1 ? 1 : 0)]) // Rotate for odd levels
        fractal_tree(level, 200, 60); // Draw the tree with initial length and angle
    }
}
