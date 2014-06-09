// sudilib.scad




// routines shared bettween scripts that generate 3D models and 2D DXF

/////////////////////////////////////////////
// generate a circular hole pattern

module holepattern (circle_dia, hole_dia, count, depth){
	for(hp=[0:360/count:360]){
		translate([0,-.5,0])
		 rotate([90,hp,0])
		  translate([circle_dia/2,0,0])
		   cylinder(h=depth+1, r=hole_dia/2, center=true);
	}
}

///////////////////////////////////////////
//rotate something about a point

module about (rot, pnt) { 
	translate(pnt)
	 rotate(a=rot)    
	  children();	   // child() in older versions
}

////////////////////////////////////////////////
// make a box rotated at a point

module sheet (dim, rot, cnt) {
	 about(rot, cnt)
	  cube(size=dim,center=true);	
}

////////////////////////////////////////////////
// make a disk/cylynder rotated at a point

module disk (height,radius, rot, cnt) {
	about(rot, cnt)
	 rotate([90,0,0])
	  cylinder(h=height,r=radius,center=true);	
}

////////////////////////////////////////////////
// make a disk with a hole rotated at a point

module washer(height,outside,inside, rot, cnt) {
	about(rot, cnt)
	 rotate([90,0,0])
	  difference(){
		cylinder(h=height,r=outside,center=true);
		cylinder(h=height,r=inside,center=true);
	}
}


