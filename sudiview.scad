// SudiView.scad

echo ("Change design and rendering parameters in 'sudiconfig.scad'");
include <sudiconfig.scad>;
include <sudilib.scad>;

// visually mark the intersection center for the planes for reference
//
color([1,0,0]) translate(centerofrotation) sphere(0.1,center=true);

// build the model
difference() {	// remove the light path and the hole pattern

	intersection() {	// isolate the sudiball
		// the outside shape of the ball
		translate([0,0,ball_r])
		 sphere(ball_r,center=true);		
		for(rot=[0:delta:359.9]){
			sheet([2*ball_r,thickness,2*ball_r],[tilt,0,rot],centerofrotation);
		}
	}
	union(){ 
		// the light path to be removed from inside the ball, defined in sudiconfig 
		lightpath(); // defined in sudiconfig.scad

		// the hole pattern in each sheet
		for(rot=[0:delta:359.9]){
		 	 about([tilt,0,rot],centerofrotation)
		  	  holepattern(hp_patdia,hp_holedia,hp_holecount,hp_holedepth);
		}
	}
}

/////////////////////////////////////////////////////
// show primary light path
 translate([0,0,ball_r-sqrt(ball_r*ball_r-ota_ir*ota_ir)])
		#cylinder(r=ota_ir,h=F_ratio*ota_id);
