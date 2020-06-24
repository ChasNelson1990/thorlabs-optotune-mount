////////////////////////////////////////////////////////////////////////
// Lens Holder for Optotune EL-10-30 Series 
// Designed for Thor Labs 30mm Cage System
// 2019 Chas Nelson, University of Glasgow
// Based on https://www.thingiverse.com/thing:1916222
////////////////////////////////////////////////////////////////////////

/// PARAMETERS///
// All units in mm

// Tolerance
screw_tolerance = 0;// adjust for your printer
lens_tolerance = 0.5;// adjust for your printer
rod_tolerance = 0.5;// adjust for your printer

//Mount dimensions
mount_height = 41;
mount_width = 41;
mount_depth = 10.7; // from Optotune specifications

// Optotune lens details
lens_diameter = 29.9+lens_tolerance; // from Optotune specifications
lens_screw_diameter = 3+screw_tolerance; // here for M3 x 0.5 Nylon-Tipped Setscrews (Thorlabs)

cable_width = 4; // measured by hand

// Cage system details
rod_position = 15; // Relative x/y Position from center of mount to center of rod guides
rod_diameter = 6+rod_tolerance; // ER series rod diameter (Thorlabs) plus a small tolerance
rod_screw_diameter = 3+screw_tolerance; // here for M3 x 0.5 Nylon-Tipped Setscrews (Thorlabs)

module Base_pos(){
    cube ([mount_height,mount_width,mount_depth], center=true);   
}
module Base_neg(){
    // Lens hole
    translate([0,0,-mount_depth/2]){cylinder ($fn=500, d=lens_diameter, h=mount_depth);}

    // Lens screws hole
    translate([-mount_height/2,0,0]){rotate ([0,90,0])cylinder ($fn=100, d=lens_screw_diameter, h=mount_height);}
    translate([0,-mount_width/2,0]){rotate ([270,0,0])cylinder ($fn=100, d=lens_screw_diameter, h=mount_width);}

    // Rod holes
    translate([-rod_position,-rod_position,-mount_depth/2]){cylinder ($fn=100, d=rod_diameter, h=mount_depth);}
    translate([+rod_position,-rod_position,-mount_depth/2]){cylinder ($fn=100, d=rod_diameter, h=mount_depth);}
    translate([-rod_position,rod_position,-mount_depth/2]){cylinder ($fn=100, d=rod_diameter, h=mount_depth);}
    translate([+rod_position,rod_position,-mount_depth/2]){cylinder ($fn=100, d=rod_diameter, h=mount_depth);}

    // Rod screw holes
    translate([rod_position,mount_width/2,0]){rotate ([90,0,0])cylinder ($fn=100, d=rod_screw_diameter, h=mount_width/2-rod_position);}
    translate([-rod_position,mount_width/2,0]){rotate ([90,0,0])cylinder ($fn=100, d=rod_screw_diameter, h=mount_width/2-rod_position);} 
    translate([rod_position,-mount_width/2,0]){rotate ([270,0,0])cylinder ($fn=100, d=rod_screw_diameter, h=mount_width/2-rod_position);}
    translate([-rod_position,-mount_width/2,0]){rotate ([270,0,0])cylinder ($fn=100, d=rod_screw_diameter, h=mount_width/2-rod_position);}

    // Cable cutout (the 1 and 2 just make sure the holes overlap)
    translate([0,1-(mount_height+lens_diameter)/2/2,0]) {cube ($fn = 50, [cable_width,2+(mount_height-lens_diameter)/2,mount_depth],center = true);}
}

//Base_neg();

difference() {
    Base_pos();
    Base_neg();
}
