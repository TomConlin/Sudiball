// SudiConfig
// design parameters to be shared between 
// 3d model generator script
// and the 2D dfx generator script

// bring in the basic helper functions
include <sudilib.scad>;

// magic numbers begin wth '$'
// smaller magic numbers result in SLOWER but smoother curves
// values smaller than .1 are ignored
// make them larger when viewing and smaller when generating if necessary

$fa =	5;		   // fragment angle (what looks smooth enough)
$fs =	.5;		// fragment size 

// mirror amd optical tube assembley (OTA) parameters
ota_id = 10;		// what diameter mirror
F_ratio= 4.5;		// focal ratio (for approximate appearance)

// Sudiball mount design parameters
planes	 =  3;	//  2,[3],4...
tilt	 = 45;	// +/- angles in degrees for the plane 

ball_dia = 28.125;		// what diameter ball to use
thickness = .625;	// sheet material thickness

// hole pattern parameters 
// these are holes about the permiter for fixturing
hp_patdia    =	25.0;	// pattern diameter (apx; ball_dia - 4 * thickness)
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

// 
relative_tilt =  sin(tilt) * sin(delta) * 180 / PI;


////////////////////////////////////////////////////////////////////////////// 
// modules to define shapes used in both sudiview and sudigen

// define the light path clearence to be removed from inside the ball,
module lightpath2(){
	// the light path won't begin lower in the ball than 
	// the dia of the mirror will fit within
	
 // min height plus whatever is needed to look right or maintain structure
	translate([0,0,ball_r-sqrt(ball_r*ball_r-ota_ir*ota_ir) + thickness * 0])
		cylinder(
			// r1 needs to clear the mirror @ contact
			r1 = ota_ir, // - 2*thickness,	
			// r2 whatever works, not less than r1 
			//r2 = ball_r * 0.707 - 2 * thickness,
			r2 = ota_ir,
			// ota_ir ,//* 1.414, //ball_r - 2*thickness ,	
			// h can be whatever works for you
			//h  = ball_dia * .707	
			h = ball_dia 
		);	
}

module lightpath(){

	translate([0,0,ball_r])
		//difference(){
			sphere(ball_r-8*thickness);  // keep top thick multiple for fingers
			//translate([0,0,-ball_r])
			//	cylinder(r=ball_r*.707, h=ball_r*.45);
		//}
}	
///////////////////////////////////////////////////////////////////////////
//  
module tiptrim(){
	translate([0, 0, ball_r + thickness/2])
		cylinder(
			r1 = 0,	
			r2 = ball_r * 1.414, //
			h  = ball_r	
		);	
}

