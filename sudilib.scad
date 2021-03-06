// sudilib.scad
// routines shared between scripts that generate 3D models and 2D DXF

/////////////////////////////////////////////
// generate a circular hole pattern

module holepattern (circle_dia, hole_dia, count, depth){
	eps  = 0.5;	// amount hole protrudes outside surface
    eps2 = 2 * eps;
	for(hp=[0:360/count:360]){
		translate([0,-eps,0])
		 rotate([90,hp,0])
		  translate([circle_dia/2,0,0])
		   cylinder(h = depth+eps2, r = hole_dia/2, center = true);
	}
}

///////////////////////////////////////////
// rotate something about the origin
// then translate it to a point

module about (rot, pnt) {
	translate(pnt)
	 rotate(rot)
	  children();
}

///////////////////////////////////////////////
// make a box rotated at a point

module sheet (dim, rot, cent) {
	 about(rot, cent)
	  	cube(size = dim, center = true);
}

////////////////////////////////////////////////
// make a disk/cylinder rotated at a point

module disk (height, radius, rot, cnt) {
	about(rot, cnt)
	 rotate([90,0,0])
	  cylinder(h = height, r = radius, center = true);
}

////////////////////////////////////////////////
// make a disk with a hole rotated at a point

module washer(height,outside,inside, rot, cnt) {
	about(rot, cnt)
	 rotate([90,0,0])
	  //translate([0,height,0]) {
	  	difference(){
			cylinder(h = height, r = outside, center = true);
			cylinder(h = height, r = inside, center = true);
		}
	//}
}

