
/*
Single  Sudiball section built in the flat(-ish)

*/
include <sudiconfig.scad>
difference(){ // lightpath
rotate([0,0,45])
difference(){  // fingers
    disk(thickness, ball_r, [90,0,0], [0,0,0]);
    
    union(){
     about( [90,0,45], [0,0,0])
        holepattern(
            hp_patdia,
            hp_holedia,
            hp_holecount,
            hp_holedepth );
    sheet( // the missing quarter 
        [ball_dia, ball_dia, thickness*2],
        [0, 0, 0], 
        [ball_r+thickness/2, ball_r+thickness/2, 0]
     );
     // finger joints
     for(f = [(ball_r-thickness/2):(-thickness*2):(ball_r/2)]){
         translate([f,thickness/2,0]) 
            cube(
                [thickness, thickness*2, thickness*2],
                center=true);
         translate([thickness/2, f-thickness, 0]) 
            cube(
                [thickness*2, thickness, thickness*2],
                center=true);
     }
     
    }
}


     // light path   
     rotate([-(90-relative_tilt),0,0])
        translate([0, 0, -ball_r/2])

		cylinder(
			r1 = ota_ir,
			r2 = ota_ir ,
			h  = ball_dia
		);
  
}
