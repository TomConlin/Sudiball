// sudigen.scad

include <sudiconfig.scad>;

echo ("If the magic numbers in sudiconfig are small [smooth]");
echo ("then generating is slow, wait for the image to appear");
echo ("When the script is ready, 'Compile and Render' with F6");
echo ("Then export as DXF from the 'File' menu for a 2D vector file");


//  build the first panel of a sudiball then lay it down 
//  and cut takes a slice through the xy plane at z=0  
projection(cut=true)  

// lay the first panel back down
rotate([-relative_tilt-90,0,0])
	translate(-centerofrotation)

// remove the light path and the hole pattern fron the panel(s)
difference() {
	intersection() {		// isolate the sudiball
							// the outside shape of the ball
		translate(centerofrotation)
		 sphere(ball_r,center=true);
							// position the first panel
        sheet([ball_dia,thickness,ball_dia],[relative_tilt,0,0],centerofrotation);
	}
	union(){ 				// stuff to be removed from the inside
		union(){
							//the light path to be removed, as defined in sudiconfig.scad
			lightpath();
			
							// the hole pattern in first sheet
		 	about([relative_tilt,0,0],centerofrotation)
			holepattern(hp_patdia,hp_holedia,hp_holecount,hp_holedepth);
		}
		// the other panels alternate as inner & outter voids
        // slot depth should aim to to be half the available width
        slot_depth = 2*thickness;
		// intersect_for(rot=[delta:delta:359.9]){
		for(rot=[delta:delta:359.9]){
			if((rot/delta)%2){
				disk(thickness,ball_r- slot_depth ,[relative_tilt,0,rot],centerofrotation);
			}else{
				washer(thickness,ball_r,ball_r- slot_depth, [relative_tilt,0,rot],centerofrotation);
			}
		}
	}
}



