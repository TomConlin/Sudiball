// SudiView.scad

echo ("Change design parameters in 'sudiconfig.scad'");
include <sudiconfig.scad>;

include <sudilib.scad>;

// visually mark the intersection center for the planes
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
		// define the light path to be removed from inside the ball, 
		cylinder(r1=ota_ir, r2=ball_r*cos(tilt)-thickness, h=ball_dia);

		// the hole pattern in each sheet
		for(rot=[0:delta:359.9]){
		 	 about([tilt,0,rot],centerofrotation)
		  	  holepattern(hp_patdia,hp_holedia,hp_holecount,hp_holedepth);
		}
	}
}


/////////////////////////////////////////////////////
// show primay light path
 translate([0,0,2*thickness])
		%cylinder(r=ota_ir,h=F_ratio*ota_id);
