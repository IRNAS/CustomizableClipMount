// Customizable Clip Mount
// Developed by Musti - Institute IRNAS Race - www.irnas.eu
// License: Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// Version: 1.0

// Instructions: Measure the object you want to mount, choose width, thickness and mounting options, 3D print and use

// Step 1: Measure width and height in mm
width_measured=65; // width of the object
height_measured=30; // height of the object

// Common dimensions:
// Router TP-Link MR3020 67/22
// Lenovo T440 power supply: 65/30

// Step 2: Adjust tolerances to get a better fit
height_tolerance=0;
width_tolerance=2;

distance=width_measured+width_tolerance; //do not change

// Step 3: Adjust the clip dimensions
width=15; // Width of the clip
thick=3;	// Thickness of the clip, 3mm is a good starting point

// Adjust teeth on bottom to fit non-flat objects
tooth_width=5; // width of the tooth
tooth_height=1; // height of the tooth
tooth_spacing=distance*0.8; // spacing between teeth

// Step 4: Choose custom mounting options

// Optional mount for adhesive velcro strips
velcro_mount=0; // Set to 1 if you want a patch in the middle to put a velcro strip on
velcro_width=25; // Enter velcro dimensions
velcro_length=25; // Enter velcro dimensions

// Optional mount for threaded suction mounts
suction_mount=0; // Set to 1 if you want mounting holes for suction cups with a screw
suction_screw=4; //3 for M3 or 4 for M4

// Do not edit below
/////////////////////////////////////////////////////
height=height_measured+height_tolerance+tooth_height;
hook_diameter=thick*2;


module clip(width,height,thick,tooth) {
	translate([-thick,-width/2,0]){
		cube(size=[thick,width,height+thick], center=false);
		rotate([-90,0,0])
		translate([thick,-height-thick,0])
		cylinder(h=width,d=hook_diameter,$fn=10);
		translate([0-3,width/2,-thick+5])
		//Add suction mounts M4 thread
		if (suction_mount==1){
			difference(){
				cube(size=[suction_screw*2,width,10], center=true);
				cylinder(h=10,d=suction_screw,$fn=10, center=true);
			}
		}
	}
	if (suction_mount!=1){		
			rotate([-90,0,0])
			translate([-thick,-thick,0])	
			difference(){
				cylinder(h=width,d=thick*4,$fn=20, center=true);
				translate([thick,0,0])
				cube(size=[thick*2,thick*4,width], center=true);
			}
		}
}

// Make clips
clip(width,height,thick,tooth);
translate([distance,0,0])
rotate([0,0,180])
clip(width,height,thick,tooth);

// Connect clips
translate([-thick,-width/2,-thick])
cube(size=[distance+2*thick,width,thick], center=false);

// Add tooth spacers
translate([distance/2-tooth_spacing/2,0,tooth_height/2])
cube(size=[tooth_width,width,tooth_height], center=true);
translate([distance/2+tooth_spacing/2,0,tooth_height/2])
cube(size=[tooth_width,width,tooth_height], center=true);

// Add velcro space
if (velcro_mount==1){
	translate([distance/2,0,-thick/2])
	cube(size=[velcro_length,velcro_width,thick], center=true);
}
