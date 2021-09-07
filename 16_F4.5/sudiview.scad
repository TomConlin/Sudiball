// SudiView.scad

echo ("Change design and rendering parameters in 'sudiconfig.scad'");
include <sudiconfig.scad>

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
			sheet(
                [ball_dia,thickness,ball_dia],
                [relative_tilt,0,rot],
                centerofrotation);
		}
	}

	union(){ 
        // Of the voids within the sheet to remove
		// the light path to be removed from inside the ball, 
		// artisticly defined in sudiconfig 
		lightpath2(); // defined in sudiconfig.scad
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
        // optional, for constant width runners outside of the lightpath
        translate([0,0,ball_r])
            sphere(ball_r-(6*thickness));
	}

}

/////////////////////////////////////////////////////
// show primary light path
  translate([0,0,  ball_r*(1-sin( acos(ota_ir/ball_r) )) 
        + thickness * 6 
        + ota_id/6 
  ])
    %cylinder(r=ota_ir,h=F_ratio*ota_id - (ota_ir + 3) );

// show primary mirror
translate([0,0,  ball_r*(1-sin( acos(ota_ir/ball_r) )) + thickness * 6])
#cylinder(r=ota_ir,h=ota_id/6);
