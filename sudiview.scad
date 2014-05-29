// SudiView.scad


include <sudiconfig.scad>;
include <sudilib.scad>;

// visually mark the intersection center for the planes
//
color([1,0,0]) translate(center) sphere(0.1,center=true);



// build the sudiball (should make this a module also)

difference() {	// remove the light path and the hole pattern

	intersection() {	// isolate the sudiball
		// the outside shape of the ball
		translate([0,0,ball_r])
		 sphere(ball_r,center=true);		
		for(rot=[0:delta:359.9]){
			sheet([2*ball_r,thickness,2*ball_r],[tilt,0,rot],[0,0,intersect]);
		}
	}
	union(){ 
		// define the light path to be removed from inside the ball, 
		cylinder(r1=ota_ir, r2=ball_r*cos(tilt)-thickness, h=ball_dia);

		// the hole pattern in each sheet
		for(rot=[0:delta:359.9]){		
			translate([0,0,ball_r])
		 	 rotate(a=[tilt,0,rot])
		  	  holepattern(ball_dia-4*thickness,.5,12,thickness);
		}
	}
}


/////////////////////////////////////////////////////
// show primay light path
 translate([0,0,2*thickness])
		%cylinder(r=ota_ir,h=F_ratio*ota_id);
