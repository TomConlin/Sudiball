
/// smaller magic numbers will be slower but smoother curves
$fa=8;  // fragment angle
$fs=.75; // fragment size


// mirror/OTA parameters
ota_id=12;  // what diameter mirror
F_ratio=8;    // focal ratio (for approximate apperance)


// Sudiball mount design parameters
planes=3;       //  3,4...   (2 for dob like rockers, more for headaches)
tilt=30;        // +/- angles in degrees 
ball_dia=28;    // what diameter ball to use
thickness=.75;  // sheet material thickness

// uncomment next line for ball center based intersection
//
intersect= ball_dia/-2;
// OR
// uncomment & edit nextline for noncenter based intersection 
//intersect=-15;  // +/- units from bottom of ball for planes to meet


//////////////////// No need to edit parameters below here 

// derived variables
ota_ir=ota_id/2;
ota_or=ota_ir+thickness;
ball_r=ball_dia/2;
delta=360/planes;


// visually mark the intersection center for the planes
translate([0,0,-intersect]){
	color([1,0,0])
	#sphere(0.1,center=true);
}


//////////////////////////////////////////////
// subroutine to create a sheet 
// then tilt and twirl it
// 
// intersection and tilt are global
//module sheet (w, t, h, tilt, twirl, cor ) {
//   translate([0,0,-cor])
//	rotate(a=[tilt,0,twirl])   
//   		translate([0,0,h/2+cor])
//			cube(size=[w,t,h],center=true);	
//}
//////////////////////////////////////////


//rotate something about a point
module about (rot, pnt){ 
	translate(-pnt)
	 rotate(a=rot)    
	  translate(pnt)
	  children();	
}

module sheet (dim, rot, cnt) {
   translate(-cnt)
	rotate(a=rot)    
	 translate(cnt+[0,0,dim[2]/2])
	  cube(size=dim,center=true);	
}

module disk (h,r, rot, cnt) {
	color([0,1,0,1])	
   	translate(-cnt)
	rotate(a=rot+[90,0,0])    
	 translate(cnt+[0,0,r])
	  cylinder(h,r,center=true);	
}

module washer(h,or,ir, rot, cnt) {
	color([0,0,1,.5])	
   translate(-cnt)
	rotate(a=rot+[90,0,0])    
	 translate(cnt+[0,0,r])
	  difference(){
		cylinder(h,or,center=true);
		cylinder(h,ir,center=true);
	}
}


/////////////////////////////////////////////
// subroutine to generate a circular hole pattern
// holes are colinear with the y-axis
module holepattern (radius, size, count, depth){
	for(hp=[0:360/count:360]){
		rotate([0,hp,0])
		translate([radius,depth-.1,0])
		rotate([90,0,0])
		cylinder(r = size/2, h = depth+2, center = true);
	}
}
//////////////////////////////////////////


// build the sudiball (should make this a module also)

difference() {	// remove the light path and the hole pattern

	intersection() {	// isolate the sudiball
		// the outside shape of the ball
		translate([0,0,ball_r])
		 sphere(ball_r,center=true);		
		// position the rectangular planes
		// This first one is kept
		sheet([2*ball_r,thickness,2*ball_r],[tilt,0,0],[0,0,intersect]);
	}
	union(){ // stuff to be removed
		union(){ 
			// define the light path to be removed, 
			// (a paralaba when a cone intersects the tilted plane)
			cylinder(r1=ota_ir, r2=ball_r*cos(tilt)-thickness, h=ball_dia);
			
			// the hole pattern in first sheet		
			translate([0,0,ball_r])
		 	rotate(a=[tilt,0,0])
		  	holepattern(ball_r-2*thickness,.5,12,thickness);
		}
		// the other planes alternate as inner & outter voids
		//intersect_for(rot=[delta:delta:359.9]){
		%for(rot=[delta:delta:359.9]){
			if((rot/delta)%2){ 
				disk(thickness,ball_r-3*thickness,[tilt,0,rot],[0,0,intersect]);
			}else{
				washer(thickness,ball_r,ball_r-3*thickness,[tilt,0,rot],[0,0,intersect]);
			}
		}
	}
}
/////////////////////////////////////////////////////


// show primay light path
* translate([0,0,ball_r/7])
		%cylinder(r=ota_ir,h=F_ratio*ota_id);


//projection(cut = false));
