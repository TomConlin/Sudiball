// SudiConfig
// design parameters to be shared between 3d model generator script
// and the 2D dfx generator script

// smaller magic numbers will be slower but smoother curves
// smaller than .1 are ignored
// make them larger when viewing then smaller when generating if necessary

$fa=3;  // fragment angle
$fs=.5; // fragment size

// mirror/OTA parameters
ota_id=6;		// what diameter mirror
F_ratio=7;		// focal ratio (for approximate appearance)


// Sudiball mount design parameters
planes=3;       //  3,4...   (2 for dob like rockers, more for headaches)
tilt=45;        // +/- angles in degrees 
ball_dia=15;    // what diameter ball to use
thickness=.375; // sheet material thickness

// hole pattern parameters
hp_patdia=13; 	// pattern diameter (~ball_dia-4*thickness)
hp_holedia=.375;						// hole diameter
hp_holedepth=thickness;				// hole depth (centered and adds epsilon)
hp_holecount=12;   					// how many holes

// derived variables
intersect=ball_dia/2;
ota_ir=ota_id/2;
ota_or=ota_ir+thickness;
ball_r=ball_dia/2;
delta=360/planes;
centerofrotation=[0,0,intersect];

////////////////////////////////////////////////////////////////////////////// 
// modules to define shapes used in both sudiview and sudigen

// define the light path to be removed from inside the ball,
module lightpath (){
	//the light path won't' begin lower in the ball than 
	// the dia of the mirror will fit
	
	translate([0,0,ball_r-sqrt(ball_r*ball_r-ota_or*ota_or)])  // min height
		cylinder(
			r1=ota_ir, 						// r1 needs to clear the mirror
			r2=ball_r-thickness,   // r2 can be whatever works for you
			h= ball_dia-thickness	// h can be whatever works for you
		);	
}
