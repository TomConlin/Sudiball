// SudiConfig
// design parameters to be shared between 3d model generator script
// and the 2D dfx generator script
// KNOWN TO WORK WITH OpenSCAD version 2014.03
// (and seen not working in unstable snapshots)


// bring in the basic helper functions
include <sudilib.scad>;

// magic numbers begin wth '$'
// smaller magic numbers result in SLOWER but smoother curves
// values smaller than .1 are ignored
// make them larger when viewing and smaller when generating if necessary

$fa =	5;		   // fragment angle (what looks smooth enough)
$fs =	.5;		// fragment size 

// mirror amd optical tube assembley (OTA) parameters
ota_id = 6;			// what diameter mirror
F_ratio= 8.0;		// focal ratio (for approximate appearance)

// Sudiball mount design parameters
planes	 =  3;	//  2,[3],4...
tilt	 = 45;	// +/- angles in degrees for the plane 

ball_dia = 24;		// what diameter ball to use
thickness = .75;	// sheet material thickness

// hole pattern parameters 
// these are holes about the permiter for fixturing
hp_patdia    =	21;	// pattern diameter (apx; ball_dia - 4 * thickness)
hp_holedia   =	.5;	// hole diameter
hp_holedepth =	thickness; // hole depth (centered, will add epsilon > 0)
hp_holecount =	12;		// how many holes

// derived variables
intersect =	ball_dia / 2;
ota_ir =	ota_id / 2;
ota_or = ota_ir + thickness;
ball_r =	ball_dia / 2;
delta  =	360 / planes;
centerofrotation = [0,0,intersect];
relative_tilt =  sin(tilt) * sin(delta) * 180 / PI;


////////////////////////////////////////////////////////////////////////////// 
// modules to define shapes used in both sudiview and sudigen

// define the light path clearence to be removed from inside the ball,
module lightpath(){
	// the light path won't begin lower in the ball than 
	// the dia of the mirror will fit within
	
 // min height plus whatever is needed to look right or maintain structure
	translate([0,0,ball_r-sqrt(ball_r*ball_r-ota_ir*ota_ir)+ 3 *thickness])
		cylinder(
			r1 = ota_ir - 2*thickness,	// r1 needs to clear the mirror @ contact
			r2 = ball_r - 3*thickness ,	// r2 can be whatever works for you 
			h  = ball_dia - thickness	// h can be whatever works for you
		);	
}

///////////////////////////////////////////////////////////////////////////
// 
module tiptrim(){
		translate([0, 0, ball_r + .5*thickness])
		cylinder(
			r1 = 0,	
			r2 = ball_r , //
			h  = ball_r	* .707
		);	
}

