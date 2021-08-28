// SudiView.scad

echo ("Change design and rendering parameters in 'sudiconfig.scad'");
include <sudiconfig.scad>;

// visually mark the intersection center for the planes for reference
//
color([1,0,0]) translate(centerofrotation) sphere(0.25);

// build the model
difference() {	// remove the light path and the hole pattern
   
	intersection() {	// isolate the sudiball
		// the outside shape of the ball
		translate([0,0,ball_r])
			sphere(ball_r);

		// the parts of the planes to keep	
		for(rot = [0:delta:360]){
			sheet([ball_dia,thickness,ball_dia],[relative_tilt,0,rot],centerofrotation);
		}
	} // end intersect

	union(){ //of the voids within the sheet to remove
		// the light path to be removed from inside the ball, 
		// artisticly defined in sudiconfig 
		lightpath(); // defined in sudiconfig.scad
        // optional snip off the tips 
        tiptrim();
		// the hole pattern in each sheet
		for(rot=[0:delta:359]){
			about([relative_tilt,0,rot],centerofrotation)
			holepattern(
                hp_patdia,
                hp_holedia,
                hp_holecount,
                hp_holedepth);
            }
	}
}

/////////////////////////////////////////////////////
// show primary light path
translate([0,0,ball_r-sqrt(ball_r*ball_r-ota_ir*ota_ir)])
		%cylinder(r=ota_ir,h=F_ratio*ota_id);

/////////////////////////////////////////////////
//  Base
b_factor=1-(sin(tilt) * sin(180/planes)); // 0.387627564
t2=thickness * 2;
 
translate([0,0,ball_r * b_factor])
    difference(){
        cylinder(r=ball_r, h=t2);
        translate([0,0,-ball_r+t2+.001])
            cylinder(r1=0.001, r2=ball_r * sin(60), h=ball_r);
    }
for(rot = [0:delta:360]){
    translate([sin(rot)*(ball_r-t2),cos(rot)*(ball_r-t2),0])
        cylinder(r=t2,h=b_factor*ball_r);
}
/////////////////////////////////////////////////////////////////////////////////
//  truss experiment

// build the UPPER model
difference(){	// remove the light path 
	intersection() {	// isolate the cage
		// the outside shape of the ball
		translate([0,0, 2.4* ball_r])
        %cylinder(r1=ball_r*.84, h=ball_dia, r2=ota_or,center=true)
		// the parts of the planes to keep	
		#for(rot = [0:delta:360]){
            sheet(
                [ball_dia, thickness, ball_dia],
                [relative_tilt,  0, rot ],
                 centerofrotation);
        }
    } // end intersect
} // end diff

