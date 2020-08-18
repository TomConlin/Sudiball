/*
Single  Sudiball section built in the flat(-ish)

 Basic parameters  diameter, thickness, etc.
 are defined in `sudiconfig.scad`

 It is not expected that this single sheet generator
 will work well with exotic species of Sudiball
 as it is narrowly focuced on 3-planes @ 45-degrees
 intersecting at the geometric center.
*/
include <sudiconfig.scad>


difference(){ // lightpath
    rotate([0,0,45])
difference(){  
    // From this disk; 
    cylinder(h=thickness, r=ball_r, center = true);
    // remove fingers, slots, holepaternn ...
    union(){
     rotate([90,0,45])
        holepattern(
            hp_patdia,
            hp_holedia,
            hp_holecount,
            hp_holedepth );
    // missing top quadrant  
    translate([ball_r+thickness/2, ball_r+thickness/2, 0])   
        cube(  
            [ball_dia, ball_dia, thickness*2],
            center=true); 
     // finger joints
     for(f = [(ball_r-thickness/2):(-thickness*2):(ball_r/2)]){
         translate([f,thickness/2,0]) 
            cube(
                [thickness, thickness*2, thickness*2],
                center=true);
         translate([thickness/2, f-thickness, 0]) 
            cube(
                [thickness*2, thickness, thickness*2],
                center=true);
     }
     // slot outter (y)
     translate([0,-ball_r+thickness,0])
        cube(
            [thickness, thickness*5, thickness*2],
            center=true);
     // slot inner (x)
     translate([-(ball_r-thickness*6),0,0])
        cube(
            [thickness*5, thickness, thickness*2],
            center=true);
    }
} 

/*  
    The light path should be moved inside the union above
    but need to get the order of rotations right first
*/
     // light path   
     rotate([-(90-relative_tilt),0,0]){
        translate([0, 0, -ball_r+.001])
		cylinder(
			r1 = ota_ir+thickness,
			r2 = ball_r/2,
			h  = ball_r
		);
        ///translate([0, 0, -ball_r])
		cylinder(
			r1 = ball_r/2,
			r2 = ball_r/2,
			h  = ball_r
		);
    }
}
