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
	}

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
	#cylinder(r=ota_ir,h=F_ratio*ota_id);
