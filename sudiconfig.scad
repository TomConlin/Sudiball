// SudiConfig
// design parameters to be shared between 3d model generator script
// and the 2D dfx generator script
// KNOWN TO WORK WITH OpenSCAD version 2014.03
// (and seen not working in unstable snapshots)

// bring in the basic helper functions
include <sudilib.scad>;

// magic numbers begin wth '$'
// smaller magic numbers result in slower but smoother curves
// values smaller than .1 are ignored
// make them larger when viewing and smaller when generating if necessary

$fa =	4 ;		   // fragment angle (what looks smooth enough)
$fs =	.5;		// fragment size (using the radius of rouder bit used here)

// mirror amd optical tube assembly (OTA) parameters
ota_id = 8;			// what diameter mirror
F_ratio= 4.0;		// focal ratio (for approximate appearance)

// Sudiball mount design parameters
planes	 =  3;	//  2,[3],4...
tilt	 = 45;	// +/- angles in degrees for the plane

ball_dia = 14;		// what diameter ball to use
thickness = .375;	// sheet material thickness

// hole pattern parameters
// these are holes about the perimeter for fixtures, jigs and whatever
hp_patdia    =	12.5;	// pattern diameter (apx; ball_dia- 4 * thickness)
hp_holedia   =	.375;	// hole diameter
hp_holedepth =	thickness; // hole depth (centered, will add epsilon > 0)
hp_holecount =	12;		// how many holes(would be in full 360 deg)

////////////////////////////////////////////////////////////////////////////////
// derived variables (these should not need to be edited)
intersect =	ball_dia / 2;
ota_ir =	ota_id / 2;
ota_or = ota_ir + thickness;
ball_r =	ball_dia / 2;
delta  =	360 / planes;
centerofrotation = [0,0,intersect];

// to compensate for order of transform operations
relative_tilt =  asin(sin(tilt)) * sin(delta) * 180 / PI;

// may be red herring, but for  45 by 45 
// the above & miter only differ by a half deg
// atan(tan(rot)×cos(tilt))  // miter 
// asin(sin(rot)*sin(tilt))  // bevel

//////////////////////////////////////////////////////////////////////////////
// modules to define shapes used in both sudiview and sudigen

// define the light path clearance to be removed from inside the ball,
// r1 is the light path clearance at the mirror.
// r2 is the clearance some distance above the mirror.
// r2 is not smaller than r1.
// if r2 > r1 then the light path clearance is a cone and 
// the intersection of a cone and inclined plane is a parabola 
// which can be a nice aesthetic.
module lightpath (){
	// the light path won't begin lower in the ball than
	// the dia of the mirror will fit within
    // min height plus whatever is needed to maintain structure or looks.
	translate([0,0,ball_r-sqrt(ball_r*ball_r-ota_ir*ota_ir)+ 3 *thickness])
		cylinder(
			r1 = ota_ir,	 			            // r1 needs to clear the mirror
			r2 = ball_r - 6*thickness,	// r2 can be whatever works for you
			h  = ball_dia - thickness	// h can be whatever works for you
		);
}
