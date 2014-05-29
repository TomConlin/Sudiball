// sudigen.scad

include <sudiconfig.scad>;
include <sudilib.scad>;

echo ("When the script is ready hit F6");
echo ("Then export as dxf from the 'Design' menu");


// build the first panel of a sudiball then lay it down 

projection(cut = true)  
 rotate([-tilt-90,0,0]) 
	translate(-centerofrotation)

difference() {	// remove the light path and the hole pattern

	intersection() {	// isolate the sudiball
		// the outside shape of the ball
		translate([0,0,ball_r])
		 sphere(ball_r,center=true);		
		// position the main plane
		// This first one is kept
		sheet([2*ball_r,thickness,2*ball_r],[tilt,0,0],centerofrotation);
	}
	union(){ // stuff to be removed
		union(){ 
			// define the light path to be removed, 
			cylinder(r1=ota_ir, r2=ball_r*cos(tilt)-thickness, h=ball_dia);
			
			// the hole pattern in first sheet		
		 	about([tilt,0,0],centerofrotation)
		  	 holepattern(ball_dia-4*thickness,.5,12,thickness);
		}
		// the other planes alternate as inner & outter voids
		//intersect_for(rot=[delta:delta:359.9]){
		for(rot=[delta:delta:359.9]){
			if((rot/delta)%2){ 
				disk(thickness,ball_r-3*thickness,[tilt,0,rot],centerofrotation);
			}else{
				washer(thickness,ball_r,ball_r-3*thickness,[tilt,0,rot],centerofrotation);
			}
		}
	}
}

