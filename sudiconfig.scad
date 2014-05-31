// SudiConfig
// design parameters to be shared between 3d model generater script
// and the 2D dfx generater script

// smaller magic numbers will be slower but smoother curves
// smaller than .1 are ignored

$fa=2;  // fragment angle
$fs=.1; // fragment size

// mirror/OTA parameters
ota_id=6;		// what diameter mirror
F_ratio=7;		// focal ratio (for approximate apperance)


// Sudiball mount design parameters
planes=3;       //  3,4...   (2 for dob like rockers, more for headaches)
tilt=30;        // +/- angles in degrees 
ball_dia=15;    // what diameter ball to use
thickness=.375; // sheet material thickness

// hole pattern parameters
hp_patdia=13; 	// pattern diameter (~ball_dia-4*thickness)
hp_holedia=.5;						// hole diameter
hp_holedepth=thickness;				// hole depth (centered and adds epsilon)
hp_holecount=12;   					// how many holes


///////////////////////////////////////////////////// 
// No need to edit parameters below here 

// derived variables

intersect=ball_dia/2;

ota_ir=ota_id/2;
ota_or=ota_ir+thickness;
ball_r=ball_dia/2;
delta=360/planes;
centerofrotation=[0,0,intersect];



