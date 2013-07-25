//---------------------------------------------------------------------------------------------------
// RepRap "Morgan", main ver 1.00
// Copyright 2012, 2013. Author: Quentin Harley (qharley)
// This original design is licensed under GPLv2.
//
// These are the main SCARA arm components

include <MCAD/teardrop.scad>
include <MCAD/polyholes.scad>
include <MCAD/nuts_and_bolts.scad>

LMxUU = 8;			// Choose linear bearing: 8 or 12mm
rodspacing = 175;	// Distance between rods:	175 standard, 190 wide

MakeMorgan(14);		// Select Part number to make	

//***********************************************************
//**                                                			**
//**    Select the number of the module to make				**
//**																		**
//**	01:	 PVC pipe support A (Ported, 458.5mm pipe)			**
//**	02:	 PVC pipe support B (non Ported, 451.5mm pipe)		**
//**	03: Z-mount Bottom												**
//**	04: Z-mount Top													**
//**	05: Motormount Short											**
//**	06: Motormount Tall											**
//**	07: Rod mounted Drivewheel									**
//**	08: Tube mounted Drivewheel									**
//**	09: 22mm Tube 6805 bearing adaptor							**
//**	10: Bed arm Left												**
//**	11: Bed arm Right												**
//** 	12:	 Bed Z-bracket and lead screw holder					**
//**	13: Bed rear mounting clips									**
//**	14: Bed front mounting clips									**
//**	15: hall-endstop holders										**
//**	16: Z-Lead screw motor shaft coupler						**
//**	17: Arm PSI A (inner supporting arm)						**
//**	18: Arm PSI B (outer supporting arm)						**
//**	19: Arm Theta A (inner steering arm)						**
//**	20: Arm Theta B (outter steering arm)						**
//**	21: Morgan Tool head (make from ABS/Nylon/etc)		**
//**	22: Lead screw nut (Alpen 8mm SDS)	
//**	23: extruder Bowden adaptor						
//**
//**  TO DO!  Build Plates...
//**		Select number of build plate
//**	50: Arms Plate (PLA)
//**	51: Bed Plate	(PLA)
//**	55: Wheel PlateA	(PLA)
//**	56: Wheel PlateB	(PLA)
//**	60: Diverse Plate	(ABS)



module MakeMorgan(partnumber)
{
	if (partnumber == 1 ){
		MorganPVCsupport_ANG(26.5,130,130,420, pipe = false, port=true);	// 458.47
	}
	if (partnumber == 2 ){
		MorganPVCsupport_ANG(26.5,70,150,420, pipe = false);					// 451.44
	}
	
  rotate([0,0,45]){ 					// parts rotated through 45deg to ease fitting to RepRap heatbed

	if (partnumber == 3 ){
		MorganZmountBot(rodspacing, LMxUU);
	}
	if (partnumber == 4 ){
		MorganZmountTop(rodspacing, LMxUU);
	}

  }

	if (partnumber == 5 ){
		MorganMotorMount4(Height = 50);
	}
	if (partnumber == 6 ){
		MorganMotorMount4(Height = 70);
	}
	if (partnumber == 7 ){
		MorganBeltWheel();			// Rod mounted belt drive wheel
	}
	if (partnumber == 8 ){
		MorganBeltWheel2();			// Tube mounted belt drive wheel
	}
	if (partnumber == 9 ){
		MorganPillar();				// 6805 bearing tube mount
	}
	
  rotate([0,0,45]){

	if (partnumber == 10 ){
		if(LMxUU == 12)
			MorganBedarmLeft(21.5);
		else
			MorganBedarmLeft(15.5);
	}
	if (partnumber == 11 ){
		if(LMxUU == 12)
			MorganBedarmRight(21.5);
		else
			MorganBedarmRight(15.5);
	}
	if (partnumber == 12 ){
		//Bed_stabil_bracket(21.5);
		if(LMxUU == 12)
			Bed_stabil_bracket(21.5);
		else
			Bed_stabil_bracket(15.5);
	}

  }

	if (partnumber == 13 ){
		BedMountRear();
	}
	if (partnumber == 14 ){
		BedMountFront();
	}
	
	if (partnumber == 15 ){
		MorganEndstop();
	}

	if (partnumber == 16 ){
		rotate([0,0,45])
			MorganZCoupler();
	}
	if (partnumber == 17 ){
		Primary_Arm();
	}
	if (partnumber == 18 ){
		Secondary_Arm();
	}
	if (partnumber == 19 ){
		Sup_Arm1();
	}	
	if (partnumber == 20 ){
		Sup_Arm2();
	}
	if (partnumber == 21 ){
		Secondary_Arm_hotend_holder(Hotend_D = 16.5, Hotend_H = 12);
	}
	if (partnumber == 22 ){
		leadscrew_nut();
	}
	if (partnumber == 23 ){
		Extruder_Bowden_adaptor(support = false);
	}
	
//**************** Plates  ***************************

	if (partnumber == 60 ){
		translate([0,0,0])
			rotate([0,0,0])
				Secondary_Arm_hotend_holder(Hotend_D = 16.5, Hotend_H = 12);

		translate([70,-10,0])
			rotate([0,0,180])
				MorganPVCsupport_ANG(26.5,130,130,420, pipe = false, port=true);	// 458.47
	
		translate([-40,0,0])
			rotate([0,0,180])
				MorganPVCsupport_ANG(26.5,130,130,420, pipe = false, port=true);	// 458.47

		translate([-50,40,0])
			rotate([0,0,0])
				MorganPVCsupport_ANG(26.5,70,150,420, pipe = false);					// 451.44
		
		translate([-50,-70,0])
			rotate([0,0,0])
				MorganPVCsupport_ANG(26.5,70,150,420, pipe = false);					// 451.44

		translate([-70,-40,0])
			rotate([0,0,0])
				Extruder_Bowden_adaptor(support = false);

		translate([40,-35,0])
			rotate([0,0,0])
				import("../stl/cap_2.stl");

		translate([-40,-35,0])
			rotate([0,0,0])
				import("../stl/cap_2.stl");

		translate([-30,50,0])
			rotate([0,0,0])
				import("../stl/Eckstruder_Big_Gear_Herringbone.stl");

		translate([-16,-35,20])
			rotate([0,0,0])
				import("../stl/Eckstruder_Small_Gear_Herringbone.stl");

		translate([-50,-25,0])
			rotate([0,0,-90])
				import("../stl/Eckstruder_Idler_Block_for_Prusa.stl");

		translate([50,-65,0])
			rotate([0,0,0])
				import("../stl/thumb_knob_M4_extruder.stl");

		translate([10,110,0])
			rotate([0,0,-90])
				import("../stl/Eckstruder_Block_for_Prusa.stl");

	}

}





// **********************************************************
// **  Here be dragons...

//** print envelope check - only in F5 review
	translate([0,0,50])
		%cube([200,200,100], center=true);

module Matrix_test()
{
	for(x=[0:9])
	{
		for (y=[0:9])
		{
			translate([20*x,20*y,1.5])
				difference(){
					cube([20,20,3], center=true);
					cube([19,19,3],center=true);
				}
		}
	}	
}



PipeFactor = 40/39.2;			// Multiplication factor for inner diameter 




//MorganFrame();

pipeselect = false; // Show pipes in frame... default false

//MorganPVCsupport_ANG(26.5,130,130,420, pipe = false, port=true);	// 458.47
//MorganPVCsupport_ANG(26.5,70,150,420, pipe = false);					// 451.44

//MorganEndstop();

//MorganMotorMount4(Height = 50);
//MorganMotorMount4(Height = 70);



//translate([-90,-90,0])
//	Matrix_test();



//MorganPillar();				// 6805 bearing tube mount

//MorganBeltWheel();			// Rod mounted belt drive wheel
//MorganBeltWheel2();			// Tube mounted belt drive wheel

//MorganPVCsupport(29);
//PipeCuttingTemplate(32);

//MorganSpoolHolder(PipeOD = 32, PipeID=29);


rotate([0,0,45]){
//	MorganBedarmLeft(21.5);
//	translate([30,0,0])
//		MorganBedarmRight(21.5);
//	Bed_stabil_bracket(21.5);
//MorganZmountTop(195, 12);
//MorganZmountBot(195, 12);
}

//BedMountRear();


//leadscrew_nut();

// **************** Parts **********************
//translate([0,0,5])
//	cylinder(r=14.72/2, h=5, $fn=6);
//linear_extrude(height = 42)
//	nutHole(8, proj = 1);
//boltHole(8);

//Primary_Arm();
//Secondary_Arm();

//intersection(){
//	Fastener_stack();
//	cylinder(r=20, h=5);
//}

//Secondary_Arm_hotend_holder(Hotend_D = 16.5, Hotend_H = 12);  // Make out of ABS...
//Secondary_Arm_hotend_holder_2(Hotend_D = 16.5, Hotend_H = 12);  // Make out of ABS...
//translate([40,0,0])
//Extruder_Bowden_adaptor();

//Sup_Arm1();
//Sup_Arm2();



// *********** Misc **************8
// bolt_hobber();

// ************** Building Blocks *************
// MorganPillarMount();
//	MorganShaftMount();
// MorganBedarm_mount();
//Bed_stabil_clasp();

// *****************8***********
//MorganMotorMount(50);
//MorganMotorMount(75);
//MorganFlatMotorMount();



module leadscrew_profile()
{
	projection(cut=false){
		polyhole(5,5);
		cube([7.5, 3,1], center=true);
		rotate([0,0,-45])
			cube([6.5,3,1],center = true);
	}
}

module leadscrew_nut(){
	difference(){
		union(){
			cylinder(r=14.8/2,h=14, $fn=6);

		}
		linear_extrude(height = 120/4, center = true, twist = -360)
			scale(1.1)
				leadscrew_profile();
	}

}

module bolt_hobber()
{
	difference(){
		

		translate([0,0,7]){
			rotate([90,0,0]){
				cylinder(r=7.8/2, h=50, $fn = 20);
				cylinder(r=10, h=10, $fn = 12);
			}
		}	

	}
}

module CalCylinder()
{
	cylinder(r=20, h=10, $fn = 200);


}

module CalCross()
{
	cube([200,10,10], center=true);
	cube([10,200,10],center=true);
}

module CalCube(){
	cube([20,20,20]);

}

module MorganEndstop()
{
	difference(){
		union(){
			cylinder(r=6, h=10);

			translate([9,0,1.5])
				minkowski(){
					cube([17,8,3],center=true);
					cylinder(r=2, h=0.00001, $fn=12);
				}

			translate([-5,1,5])
				rotate([90,0,0])
					minkowski(){
						cube([7,6,12],center=true);
						cylinder(r=2, h=2, $fn=12);
					}


		}

		translate([0,0,-1])
			polyhole(12,8);

		translate([-12,0,5])
			cube([20,8,12],center=true);

		translate([15,0,1])
			cube([4,5,2.1], center=true);
		translate([12,0,2.1])
			cube([4,5,2], center=true);

		translate([-6,10,5])
			rotate([90,0,0])
				polyhole(20,3);

		translate([-6,11,5])
			rotate([90,0,0])
				cylinder(r=3.1, h=5, $fn =6);



	}

}





		

module MorganF(){

		MorganPVCsupport_ANG(29,130,130,420, pipe = pipeselect);		// 458.47
	translate([50,0,0])
		MorganPVCsupport_ANG(29,70,150,420, pipe = pipeselect);			// 451.44
	

}

//translate([200,0,0])
//	cube([10,10,420]);

module MorganFrame(){

	translate([0,0,-4])	
		cube([360,360,8],center = true);
	translate([0,0,0])
		MorganZmountBot();

	translate([150,0,0])
		MorganPVCsupport_ANG(29,-130,130,420, pipe =pipeselect);
	translate([-150,0,0])
		MorganPVCsupport_ANG(29,130,130,420, pipe = pipeselect);
	
	translate([70,150,0])
		MorganPVCsupport_ANG(29,70,-150,420, pipe = pipeselect);
	translate([-70,150,0])
		MorganPVCsupport_ANG(29,-70,-150,420, pipe = pipeselect);

	translate([-180,-40,420])
		cube([360,220,8]);

	translate([0,0,420])
		rotate([0,180,0])
		{
			MorganZmountTop();

			translate([140,0,0])
				MorganPVCsupport_ANG(29,-70,150,420, pipe = pipeselect);
			translate([-140,0,0])
				MorganPVCsupport_ANG(29,70,150,420, pipe = pipeselect);
			translate([20,130,0])
				MorganPVCsupport_ANG(29,130,-130,420, pipe = pipeselect);
			translate([-20,130,0])
				MorganPVCsupport_ANG(29,-130,-130,420, pipe = pipeselect);
		}
}

module BedMountFront()
{
  rotate([0,90,0])	
	difference(){
		cube([15,25,25], center=true);
		translate([0,0,6.5])
			rotate([0,90,0])
				cylinder(r=15/2, h=20, center=true);	
		difference(){
			translate([0,0,6.5])
				rotate([0,90,0])
					cylinder(r=15/2+3, h=20, center=true);
			translate([0,0,6.5])
				rotate([0,90,0])
					cylinder(r=15/2+2, h=20, center=true);
			translate([0,0,19])
				cube([15,25,25],center=true);
		}
			
		cube([15,10,10],center=true);
		translate([0,0,10])
			cube([15,12,10],center=true);

		rotate([0,-90,0])
		#teardrop(2.6,30,90);


	}
}


module Bed_stabil_bracket(bsize = 15.5){
	difference(){
		union(){
			translate([(rodspacing)/2,0,0])
				Bed_stabil_clasp(bsize);
			translate([(rodspacing)/-2,0,0])
				mirror(){
					Bed_stabil_clasp(bsize);
				}
			difference(){
			  union(){
				translate([0,-14.5,25])
					cube([rodspacing-bsize+10,3,50],center=true);
			
				translate([rodspacing/2,-12,0])
					rotate([0,0,-160])
						cube([rodspacing/2, 3, 50]);
				mirror()
					translate([rodspacing/2,-12,0])
						rotate([0,0,-160])
							cube([rodspacing/2, 3, 50]);
			  }
		
			  translate([rodspacing/2,0,0])
					#cylinder(r=bsize*0.8, h=50);
			  translate([rodspacing/-2,0,0])
					#cylinder(r=bsize*0.8, h=50);	
			}		

	
			cylinder(r=22,h=50);

			translate([0,-40,0])
				cylinder(r=11,h=50,$fn=6);

			translate([0,-20,5])
				cube([22,40,10],center=true);
			translate([0,-20,48.5])
				cube([12,40,3],center=true);
		}

		cylinder(r=19,h=50);
		translate([-25,-13,0])
		cube([50,50,50]);

		translate([45,-30,22])
			rotate([0,0,90])
				teardrop(16, 50, 90);
				
		translate([-45,-30,22])
			rotate([0,0,90])
				teardrop(16, 50, 90);
				

		translate([0,-40,0])
			cylinder(r=8,h=6,$fn=6);
		translate([0,-40,9])
			cylinder(r=8,h=41,$fn=6);
		translate([0,-40,6.5])
			cylinder(r=4.5, h=10);

		translate([rodspacing/-2+LMxUU/1.5, LMxUU*-1.75, 0])
			cylinder(r=2.5, h=3);
	
	}
}

module Bed_stabil_clasp(bsize=15.5){
	difference(){
		
		cylinder(r=bsize/2+8, h=50);
		translate([0,0,2])
			MorganBedarmRight(bsize);
		cylinder(r=bsize/1.9,h=50);
		translate([0,bsize*.75,25])
			cube([bsize*3,bsize*1.5,52],center=true);
	}
}


module BedMountRear(){
  translate([0,0,0])
    rotate([0,270,0])
	difference(){
		union(){
			translate([0,0,0])
				cube([18,60,4]);
			translate([0,70,19.5])
				rotate([0,90,0])
					polyhole(18,25);
			translate([0,60,0])
				rotate([60,0,0])
					cube([18,20,6]);
		}
		translate([-1,70,19.5])
			rotate([0,90,0])
				polyhole(22,15.5);
		translate([-1,70,19.5])
			rotate([60,0,0])	
				translate([4.5,10,0])
					cube([32,20,15.5],center=true);
		translate([9,6,0])
			polyhole(5,4);
		translate([9,14,0])
			polyhole(5,4);
	}
}



module MorganBedScrewmount(){
  
  difference(){
	union(){
		translate([25,22,0])
			ArmEndPiece();
		translate([25,0,2])
			cube([18,68,4],center=true);
		translate([25,-5,12])
			cube([4,74,24],center=true);

		translate([-25,22,0])
			ArmEndPiece();
		translate([-25,0,2])
			cube([18,68,4],center=true);
		translate([-25,-5,12])
			cube([4,74,24],center=true);
	
		translate([0,-42,2])
			cube([68,18,4],center=true);
		translate([0,-42,12])
			cube([54,4,24],center=true);
		translate([0,-42,0])
			cylinder(r=10,h=24,$fn=50);
	}
	translate([0,-42,17])
		cylinder(r=7.5,h=7,$fn=6);
	translate([0,-42,0])
		cylinder(r=8,h=15,$fn=6);
	translate([0,-42,15.4])
		cylinder(r=5,h=15,$fn=50);

	translate([-50,22,12])
		rotate([0,90,0])
			polyhole(100,15.5);

	polyhole(20,36);
  }
}

module ArmEndPiece(){
	difference(){
		union(){
			

			translate([-9,0,12])
				rotate([0,90,0])
					cylinder(r=12,h=18,$fn=50);
			translate([0,6,12])
				cube([18,12,24],center=true);
			
		}
		
		translate([-10,0,12])
				rotate([0,90,0])
					polyhole(20,15.5);

	}
}

module MorganBedarm_mount(){
	difference(){
		cylinder(r=12,h=3*24,$fn=50);
		polyhole(3*24,15.5);
		translate([13,0,0])
			cylinder(r=9.2,h=3*24,$fn=50);
		
		

	}
	rotate([0,0,-45])
		translate([9.85,0,0])
			cylinder(r=2.15,h=3*24, $fn=50);
	rotate([0,0,45])
		translate([9.85,0,0])
			cylinder(r=2.15,h=3*24, $fn=50);

	translate([0,0,4])
		difference(){
			rotate_extrude(convexity = 10)
				translate([8.4, 0, 0])
					circle(r = 1, $fn = 100);
			translate([5,0,0])
				cube([10,10,2], center=true);
		}

	translate([0,0,(3*24)-4])
		difference(){
			rotate_extrude(convexity = 10)
				translate([8.4, 0, 0])
					circle(r = .8, $fn = 100);
			translate([5,0,0])
				cube([10,10,2], center=true);
		}

}

module MorganBedarm_mount12(bearingD = 21){
	
	bearingR = bearingD / 2;

	subcyl = sqrt(pow((bearingR+4.25),2)/2);

	difference(){
		cylinder(r=bearingR + 4.25,h=3*24,$fn=50);
		polyhole(3*24,bearingD);
		translate([bearingR+4.25,0,0])
			cylinder(r=subcyl,h=3*24,$fn=50);
		
		

	}
	rotate([0,0,-45])
		translate([bearingR+2.25,0,0])
			cylinder(r=2.25,h=3*24, $fn=50);
	rotate([0,0,45])
		translate([bearingR+2.25,0,0])
			cylinder(r=2.25,h=3*24, $fn=50);

	translate([0,0,6])
		difference(){
			rotate_extrude(convexity = 10)
				translate([bearingR, 0, 0])
					circle(r = .8, $fn = 100);
			translate([8,0,0])
				cube([bearingD*.66,bearingD*.66,2], center=true);
		}

	translate([0,0,44.5+6])
		difference(){
			rotate_extrude(convexity = 10)
				translate([bearingR, 0, 0])
					circle(r = .8, $fn = 100);
			translate([8,0,0])
				cube([bearingD*.66,bearingD*.66,2], center=true);
		}

}

module MorganBedarm(){

	
	difference(){
		union(){
			translate([0,100,2])
				cube([18,200,4],center=true);
			translate([0,100,3*24/2])
				cube([5,200,3*24],center=true);
			
			
			translate([-9,25,12])
				rotate([0,90,0])
					cylinder(r=12,h=18,$fn=50);
		}

		cylinder(r=11.5,h=100);
		translate([0,75,87.50])
			rotate([0,90,0])
				cylinder(r=65,h=20,center=true);
		translate([0,175,72.5])
			cube([20,200,100],center=true);

		translate([-9,25,12])
				rotate([0,90,0])
					polyhole(18,15.5);

		translate([-9,188,12])
				rotate([0,90,0])
					polyhole(20,15.5);
		
	}
	
	
	
	difference(){
		union(){
			translate([-9,188,12])
				rotate([0,90,0])
					cylinder(r=12,h=18,$fn=50);
			translate([0,194,12])
				cube([18,12,24],center=true);
		}
		
		translate([-10,188,12])
				rotate([0,90,0])
					polyhole(20,15.5);

	}
	
}

module MorganBedarmLeft(bsize = 15.5){

	MorganBedarm_mount12(bsize);
	MorganBedarm();
	
}


module MorganBedarmRight(bsize = 15.5){

	rotate([0,0,180])
		MorganBedarm_mount12(bsize);

	MorganBedarm();
	
}


module Motor(MotorH = 50, MotorW = 42){
	translate([0,0,MotorH/2])
		intersection(){
			cube([MotorW*1.285,MotorW*1.285,MotorH],center=true);
			rotate([0,0,45])
				cube([MotorW,MotorW,MotorH],center=true);
		}

}

module MorganFlatMotorMount(){
	difference(){
		Motor(3);
		for(i=[0,90,180,270]){
			rotate([0,0,i])
			{
				translate([33,0,Height-8])
					polyhole(12,2);

				translate([22,0,0])
					polyhole(10,3);
			}
		}
		polyhole(2,22);
	}
}


module MorganMotorMount4(Height = 50, Mheight = 52){

	if (Height < Mheight+2)
	{
		echo ("Help");
	}	
	
	rotate([0,90,0])
	{
		difference(){
			
			union(){
				Motor(Height + 3, 44+6);
				translate([0,30,0])
					cylinder(r=20,h=4);
				translate([0,-25,0])
					cylinder(r=20,h=4);
			}
			translate([0,0,0])
				Motor(Height, 44);
			translate([65,0,25])
				cube([100,100,100],center=true);
			translate([-65,0,25])
				cube([100,100,100],center=true);
			translate([0,22,Height - 5])
				polyhole(10,3);
			translate([0,-22,Height - 5])
				polyhole(10,3);
			translate([0,-38, 0])
				polyhole(10,3);
			intersection(){
				translate([0,25,5])
					cube([20,50,10],center=true);
				translate([0,-38,0])
					difference(){
						cylinder(r=79.5, h=10, $fn=100);
						cylinder(r=76.5, h=10, $fn=100);
					}
			}
			translate([0,0,Height - 5])
				polyhole(10,22);
			
			translate([0,0,Height/2])
				cube([37,37,Height],center=true);

		}
	} 

}


module MorganMotorMount3(Height = 50, Mheight = 52){

	if (Height < Mheight+2)
	{
		echo ("Help");
	}	
	   
	difference(){
		union(){
			Motor(Height+2, 48);

			for(i=[0,90])
				rotate([0,0,i])
					translate([30,0,0])
						difference(){
							cylinder(r=9, h=3);
							translate([4,0,0])
							polyhole(3,4);
						}

			for(i=[170,280])
				rotate([0,0,i])
					translate([32,0,0])
						difference(){
							cylinder(r=8, h=3);
							translate([2,0,0])
							polyhole(3,4);
						}

			
		}
		translate([0,0,0])
			Motor(Height, 44);

		translate([25,25,Height - 11])
			rotate([0,45,45])
				cube([100,100,50],center=true);		
		translate([9,9,Height])
			rotate([0,0,45])
				cube([50,44,50],center=true);




		translate([-20,-20,Height*.45])
			rotate([0,-45,45])
				cube([Height*.71,44,Height],center=true);

		translate([-20,-20,Height*.318])
			rotate([0,0,45])
				translate([-15,-18,0])
					cube([30,36,Height*.58]);
		
		*translate([0,0,Height*1.5+2])
			cube([100,100,Height],center=true);	

		*for(i=[0,90,180,270])
			rotate([0,0,i])
				translate([18,0,0])
					polyhole(2,3);

		*for(i=[45, 135])
			//translate([-35,-35,Height/2])
				rotate([0,90,i])
				translate([-Height/2,0,-50])
					polyhole(100,30);

		translate([0,0,Height/3])
			rotate([0,0,135])
				teardrop(10, 50, 90);
		translate([-7.5,-7.5,Height*.67])
			rotate([0,0,135])
				teardrop(5, 50, 90);
		//polyhole(Height+20,22);
		rotate([0,0,-45])
			cube([42,25,30],center=true);

		for(i=[0,90,180,270]){
			rotate([0,0,i])
				translate([22,0,Height+1.2])
					rotate([0,0,30])
						polyhole(20,3);
   		}
	}



}

module MorganMotorMount2(Height = 50, Mheight = 52){

	if (Height < Mheight+2)
	{
		echo ("Help");
	}	
	   
	difference(){
		union(){
			Motor(Height, 46);
			
		}
		translate([0,0,2])
			Motor(Height+20, 42);
		translate([0,0,Height/2+2])
			rotate([0,0,45]){	
				cube([100,15,Height],center=true);
				cube([15,100,Height],center=true);
			}
		
		translate([0,0,Height*1.5+2])
			cube([100,100,Height],center=true);	

		for(i=[0,90,180,270])
			rotate([0,0,i])
				translate([18,0,0])
					polyhole(2,3);
				
		polyhole(2,22);
	}


	difference(){
		intersection(){
			Motor(Height);
			for (i=[0,90,180,270]){
				rotate([0,0,i]){
					translate([20,-20,Height-2])
						cube([12,40,2]);
					translate([20,-20,Height-2-Mheight])
						cube([12,40,2]);

				}
			}
		}
		
		for(i=[0,90,180,270]){
			rotate([0,0,i])
				translate([22,0,Height - 1.4])
					rotate([0,0,30])
						polyhole(2,3);
   		}

		translate([0,0,Height/2+2])
			rotate([0,0,45]){	
				cube([100,15,Height],center=true);
				cube([15,100,Height],center=true);
			}
	}
}

module MorganMotorMount(Height = 50){
   intersection(){
	difference(){
		union(){
			Motor(Height);
			for(i=[0,90,180,270]){
				//difference(){
					rotate([0,0,i])
						translate([25,0,Height+2])
							rotate([0,45,0])
							rotate([0,0,45])
								cube([20,20,20],center=true);
				//	polyhole(20,2);
				//}
			}
		}
		translate([0,0,2])
			scale(.9)
				Motor(Height+20);
		translate([0,0,Height/2+2])
			rotate([0,0,45]){	
				cube([100,20,Height],center=true);
				cube([20,100,Height],center=true);
			}
		polyhole(2,22);

		translate([0,0,Height*1.5+2])
			cube([100,100,Height],center=true);	

		for(i=[0,90,180,270]){
			rotate([0,0,i])
			{
				translate([33,0,Height-8])
					polyhole(10,2);

				translate([22,0,0])
					polyhole(2,3);
			}
		}
	}

   	cylinder(r=39, h=Height+10, $fn=100);

   }
}


module PipeCuttingTemplate(PipeOD, ){
	difference(){	
		union(){
			cube([PipeOD*2,PipeOD+10,PipeOD/2+8]);
			cube([PipeOD, 5, PipeOD+12]);
			translate([0,PipeOD+5,0])
				cube([PipeOD, 5, PipeOD+12]);
		}
		translate([-1,PipeOD/2+5,PipeOD/2+5])
			rotate([0,90,0])
				polyhole(PipeOD*2+2,PipeOD);
		translate([PipeOD/2,-PipeOD,4])
			cube([1.5,PipeOD*3,PipeOD*2]);
		
		translate([PipeOD/4,(PipeOD+10)/2,0])
			polyhole(5,3);
		translate([PipeOD/4,(PipeOD+10)/2,2])
			cylinder(r1=1.5, r2=3.5, h=3);
		translate([PipeOD/4,(PipeOD+10)/2,5])
			polyhole(5,7);

		translate([PipeOD*1.3,(PipeOD+10)/2,0])
			polyhole(5,3);
		translate([PipeOD*1.3,(PipeOD+10)/2,2])
			cylinder(r1=1.5, r2=3.5, h=3);
		translate([PipeOD*1.3,(PipeOD+10)/2,5])
			polyhole(5,7);
		
	}
	

}

module MorganSpoolHolder(PipeOD, PipeID){

	intersection(){
		difference(){	
			union(){
				translate([0,0,PipeOD/2])
					cube([PipeOD+20,PipeOD+10,PipeOD], center = true);
				translate([-PipeOD+10,0,PipeOD/2-5])	
					rotate([0,270,0])
						cylinder(r=PipeID/2,h=25);

				translate([-PipeOD-40,0,0])	
					rotate([0,0,0]){
						cylinder(r=PipeID/2,h=25);
						cylinder(r=PipeID/1.5, h=5);
						translate([0,0,5])
							cylinder(r1=PipeID/1.5, r2=PipeID/2, h=10);
					}
			}
		
			polyhole(PipeOD*2+2,PipeOD);
			
			translate([PipeOD/1.6,PipeOD/1.2,PipeOD/3])
				rotate([90,0,0])
					polyhole(PipeOD+20, 4);

			translate([-PipeOD-40,0,0]){
				translate([0,0,20.4])
					polyhole(25, 8.5);
					//cylinder(r=4,h=25);
				cylinder(r=7.5, h=20, $fn = 6);
			}

			translate([-PipeOD+10,0,PipeOD/2-5])	
					rotate([0,270,0]){
						polyhole(25, 8.5);
						//cylinder(r=4,h=25);
						translate([0,0,-7])
						cylinder(r=7.5, h=20, $fn = 6);
					}
			
			translate([PipeOD / 2,0,PipeOD/2])
				cube([PipeOD, PipeOD - 2, PipeOD],center=true);
			translate([0,0,-PipeOD])
				cube([300,300,PipeOD*2],center=true);
			translate([0,0,+PipeOD*1.85])
				cube([300,300,PipeOD*2],center=true);
		
		}
		translate([PipeOD+10,0,PipeOD/2-5])	
				rotate([0,270,0])
					cylinder(r=PipeID/1.2,h=80+PipeOD*2);
					
	}
}


module MorganPVCsupport(PipeID = 29){

	difference(){
		union(){
			cylinder(r=(PipeID+6)/2, h=5, $fn = 100);
			cylinder(r=(PipeID)/2, h=35, $fn = 100);
			translate([0,0,35])
				cylinder(r1 = (PipeID)/2, r2=PipeID/2-1, h=3, $fn=100);	
			translate([0,0,15])
				rotate_extrude(convexity = 10, $fn = 100)
					translate([(PipeID)/2-1.5,0,0])
						circle(r=2, $fn = 20);	
		}
		translate([0,0,5])
			cylinder(r=(PipeID-4)/2, h=33, $fn=100); 
		translate([0,0,2])
			cylinder(r1=5/2, r2=9/2, h=3);
		cylinder(r=5/2,h=2);
	}

}

module MorganPVCsupport_ANG(PipeID = 29, target_x = 0, target_y = 0, target_z=1, pipe = false, port = false){

	PipeLength = sqrt (pow(target_x,2)+pow(target_y,2)+pow(target_z,2));
	echo (PipeLength);
	//hyp = sqrt( pow(target_x,2) + pow(target_z,2));
	//echo(hyp);
	

	deg_x = asin ( target_x / PipeLength);
	deg_y = -asin ( target_y / PipeLength) ;

	difference(){
		union(){
			cylinder(r=(PipeID+6)/2, h=5, $fn = 100);
			rotate([deg_y,deg_x,0]){
				
				difference(){
					union(){
						translate([0,0,-5])
							cylinder(r=(PipeID+6)/2, h=15, $fn = 100);
					
					// shaft body
						cylinder(r=(PipeID)/2, h=35, $fn = 100);
						translate([0,0,35])
							cylinder(r1 = (PipeID)/2, r2=PipeID/2-1, h=3, $fn=100);	

					// m4 trapped nut support
					//	translate([0,0,4])
					//		cylinder(r = 4, h=3, $fn = 6);

					// Rib anchor
						translate([0,0,30])
							rotate_extrude(convexity = 10, $fn = 100)
								translate([(PipeID)/2-1.5,0,0])
									circle(r=2, $fn = 20);	
						
					}
					translate([0,0,-5])
						cylinder(r=(PipeID-4)/2, h=43, $fn=100); 
				}
				
			}

				// m4 trapped nut support
				//		translate([0,0,4])
				//			cylinder(r = 6, h=3, $fn = 6);
		}
			
		
		// m4 trapped nut
		translate([0,0,3])
			//cylinder(r1=5/2, r2=9/2, h=3);
			cylinder(r=8.2/2, h=5, $fn=6);
			
			
		cylinder(r=4/2,h=10, $fn = 20);

		translate([0,0,-10])
			cylinder(r= PipeID, h=20, center = true);

		if (port == true){
			translate([0,0,0])
				rotate([0,0,225])
					translate([PipeID/2,0,6])
						teardrop(5, PipeID/1.8, 90);
						

		}
		
	}

	if (pipe == true){
		rotate([deg_y, deg_x, 0])
			translate([0,0,10])
			%cylinder(r=33/2, h=PipeLength-20);
	}

}

//module polyhole(h, d) {
//    n = max(round(2 * d),3);
//    rotate([0,0,180])
//        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
//}


module HoleCal(){
	difference(){
		cylinder(r=25, h=3, $fn=200);
		polyhole(3, 40);
		translate([0,0,3])
			rotate([45,0,0])
				cube([60,1,1],center=true);
		translate([0,0,3])
			rotate([0,0,90])
				cube([60,1,1],center=true);		
	}
}

module MorganBeltWheel2(){
	difference(){
		MorganBeltWheel();
		translate([0,0,7])			// Only widen pipe section
			polyhole(40,22);
			//cylinder(r=11*PipeFactor,h=40,$fn=100);
		//cylinder(r=11, h=7, $fn=100);		// Bearings press fit
		polyhole(7,22);
		//cylinder(r=25/2, h=1.5, $fn=100);	// Flanged bearings
		//polyhole(1.5, 25);						// not a good idea... messy prints

		//Magnet Hole (5mm)
		//rotate([0,0,155])
		//	translate([72,0,7])
				//cylinder(r=2.5, h=30, $fn=8);
		//		polyhole(30,5);
	}
}

module Fastener_stack()
{
	difference(){
		cylinder(r=15, h=40);
		translate([0,0,-1])
			cylinder(r=7.5, h=42, $fn=6);
			
	}
}

module MorganBeltWheel()
{
	difference(){	
		union(){
			// The Wheel itself
			cylinder(r1 = 77, r2 = 67, h=10, $fn=100);
			cylinder(r1 = 67, r2= 77, h=10, $fn=100);
			translate([0,0,1.5])
				cylinder(r=75, h=7, $fn = 100);

			for (sector = [0:3]){
				rotate([0,30,sector*90 - 45])
					translate([10,0,18])
						cube([20,5,8],center=true);


			}

		 
		}
	
		for (sector = [0:3]){
			rotate([0,0,sector*90]){
				translate([44,0,0])
					//cylinder(r=25,h=10,$fn=100);
					polyhole(10,50);
				translate([42,42,0])
					//cylinder(r=10,h=10,$fn=100);
					polyhole(10,20);

				translate([-1.75,60,1.5])
					cube([3.5,20,7]);

			}	
		}
		//cylinder(r=8,h=10);
		polyhole(10,16);

		
		// Magnet hole 5mm
		for (maghole = [0:7]){
			rotate([0,0,maghole*360/8+22.5])
			//rotate([0,0,155-40])
				translate([71,0,7])
					polyhole(30,5);
		}				
	}

	Fastener_stack();
}

module MorganPillar()
{
	difference(){
		union(){
			cylinder(r=12.5,h=27,$fn=100);
			cylinder(r=14.5,h=20);
			//cylinder(r=16,h=18);


		}
		translate([0,0,-1])
			polyhole(h=32, d=22*PipeFactor);
			//cylinder(r=11 * PipeFactor,h=32, $fn=100);

	}
}

module MorganPillarMount()
{
	difference(){
		union(){
			translate([0,0,1])
				minkowski(){	
					cube([30,30,2], center=true);
					cylinder(r=10,h=1);
				}
			cylinder(r=22,h=10, $fn=100);
		}
		translate([0,0,-1])
			//cylinder(r=15,h=12, $fn=100);
			polyhole(12,30);

		translate([0,0,3])
			//cylinder(r=18.5,h=8, $fn=100);
			polyhole(8,37);

		for (sign1 = [1,-1]){
			for (sign2 = [1,-1]){
				translate([sign1*19,sign2*19,-1])
					//cylinder(r=2, h=5, $fn=10);
					polyhole(5,4);
			}
		}
		
	}
}

module MorganShaftMount()
{
	difference(){
		union(){
			translate([0,0,1])
				minkowski(){	
					cube([30,30,2], center=true);
					cylinder(r=10,h=1);
				}
			cylinder(r=16,h=10, $fn=100);
		}
		translate([0,0,-1])
			//cylinder(r=8,h=12, $fn=100);
			polyhole(12,16);

		translate([0,0,3])
			//cylinder(r=22/2,h=8, $fn=100);
			polyhole(8,22);

		translate([0,0,8.5])
			//cylinder(r=25/2, h=8, $fn=100);	// Flanged bearings
			polyhole(8,25);			

		for (sign1 = [1,-1]){
			for (sign2 = [1,-1]){
				translate([sign1*19,sign2*19,-1])
					//cylinder(r=2, h=5, $fn=10);
					polyhole(5,4);
			}
		}
		
	}
}

module MorganSRodMount(rodsize = 8)
{
	difference(){
		union(){
			translate([0,0,1.5])
				minkowski(){	
					union(){
						rotate([0,0,45])
							translate([-8,0,0])
								cube([rodsize,1,3], center=true);
						rotate([0,0,-45])
							translate([-8,0,0])
								cube([rodsize,1,3], center=true);
					}
					cylinder(r=6,h=.0001);
				}
			cylinder(r=rodsize/2 +4,h=10, $fn=100);
		}
		translate([0,0,3])
			polyhole(8,rodsize);

		for (sign1 = [1,-1]){
			for (sign2 = [1,-1]){
				translate([sign1*(5+rodsize/2),sign2*(5+rodsize/2),-1])
					polyhole(5,4);
			}
		}
		
	}
}

module MorganZmountTop(rodspacing = 175, rodsize = 8) // Default morgan dimentions
{
  difference(){
	union(){	
		rotate([0,0,45])
			MorganPillarMount();	

		translate([-rodspacing/2,0,0])
			MorganSRodMount(rodsize);	
		translate([rodspacing/2,0,0])
			rotate([0,0,180])	
				MorganSRodMount(rodsize);

		translate([-rodspacing/3.5,0,1.5])
			cube([rodspacing/2.5,16,3], center=true);
		translate([rodspacing/3.5,0,1.5])
			cube([rodspacing/2.5,16,3], center=true);
	}
  

		translate([0,27,5])
			cube([50,10,10],center=true);
  }

}

module MorganZmountBot(rodspacing = 175, rodsize = 8) // Default morgan dimentions
{
	rotate([0,0,45])
		MorganShaftMount();	

	translate([-rodspacing/2,0,0])
			MorganSRodMount(rodsize);	
		translate([rodspacing/2,0,0])
			rotate([0,0,180])	
				MorganSRodMount(rodsize);

	translate([-rodspacing/3.5,0,1.5])
			cube([rodspacing/2.5,16,3], center=true);
		translate([rodspacing/3.5,0,1.5])
			cube([rodspacing/2.5,16,3], center=true);


}

//Beam(0,200);

//SupportCylinder (r1 = 4, r2 = 7, h=10);

module SupportCylinder(r1, r2, h,  slice = 0.4)
{
	union()
	{
		scale(2){
			for (radius = [r1/2:r2/2]){
				difference(){
					cylinder(r = radius, h/2, $fn = 50);
					cylinder(r = radius - (slice/2), h/2, $fn = 50);
				}
			}
		}
		cylinder(r = r2, h=slice, $fn = 50);
		translate([0,0,h])
			cylinder(r = r2, h=slice, $fn = 50);
	}
}

module Bearing_recess (){		// Single recess
	intersection(){
		cylinder(r=11,8);	
		//cylinder(10,20,7);
		
	}
	//cylinder(r=14,1.5);			// Washer recess
}

module Bearing_group (){			// Top and bottom
	translate([0,0,-1])
		union(){
			Bearing_recess();
			cylinder(r=9,h=50);
		}	
		translate([0,0,41])
			rotate([0,180,0])
				Bearing_recess();

}

module Bearing_stack()
{
	difference(){
		cylinder(r=15, h=40);	
		Bearing_group();
	}
}



module Extruder_Bowden_adaptor(support = true)
{
	//union(){
	difference(){
		union(){
			translate([-11,11,15])
				difference(){
					import("Base_and_Riser_2.stl");
					cube([50,50,40], center = true);
			}
			
		//	cylinder(r=30/2, h=25);
		//	cylinder(r=27/2, h=26);
		//	cylinder(r=25/2, h=33, $fn = 50);
			cylinder(r=15.8/2,h=35, $fn = 50);	
		}
			
		translate([0,0,-1])	
		union(){
		//	cylinder(r=15.8/2,h=35, $fn = 50);
			cylinder(r=4,h=80, $fn=36);
		}
		translate([0,0,4.76])	
			difference(){
					
				cylinder(r=(15.8/2), h=4.64, $fn = 50);		
				translate([0,0,4.64 - 2])	
					cylinder(r1=6, r2 = 15.8/2, h=2, $fn = 50);	
				cylinder(r=12/2, h=4.64, $fn=50);
			}
	}

	//SupportCylinder (r1 = 5, r2 = 7, h=10);

	
}

//Fastener_stack();
//%cylinder(r=6.5, h=45, $fn=100);

module Fastener_stack()
{
	difference(){
		cylinder(r=15, h=40);
		translate([0,0,-1])
			linear_extrude(height = 42)
				nutHole(8, proj = 1);
			//cylinder(r=7.5, h=42, $fn=6);
	}
}

module BeamProfile(){
	beamr = 13;
	intersection(){	
		translate([beamr-beamr*.4,0,0])
			//circle(r=beamr);
			projection()
				rotate([0,90,0])
					teardrop(beamr, 1, 90);

		translate([0,-beamr,0])
			square([beamr*2,beamr*2]);
	}
}

//translate([0,40,0])
//	BeamProfile();
//translate([0,-40,0])
//	Beam();

module SupBeamProfile(){
	beamr = 13;
	translate([3.5,0,0])
		square([7,beamr*2-7],center=true);
	translate([3.5,9,0])
		circle(r=3.5,$fn=20);
	translate([3.5,-9,0])
		circle(r=3.5,$fn=20);
}

module BeamCross(){

	rotate([0,0,180]){
		//translate([19,0,0])
		//	square([35,3],center = true);
		difference(){
			BeamProfile();
			translate([5,0,0])	
				scale(.6)	
					BeamProfile();	
		}
	}
}

module SupBeamCross(){

	rotate([0,0,180])
		SupBeamProfile();
}

module Beam(StackRadius = 13, BeamLength = 150){
	difference(){
		union(){
			rotate([0,90,0])
				linear_extrude(height = BeamLength)
					BeamCross();
			translate([BeamLength/2,8,13])
				rotate([180,0,0])
					teardrop(4, BeamLength, 90);

			translate([BeamLength/2,-8,13])
				rotate([180,0,0])
					teardrop(4, BeamLength, 90);

			//translate([0,-8,13])
			//	rotate([0,90,0])
			//		cylinder(r=5, h=BeamLength, $fn = 10);
		}

		cylinder(r=StackRadius, h=40, $fn=50);
		translate([BeamLength,0,0])
			cylinder(r=StackRadius, h=40, $fn = 50);
		translate([20,0,0])
			cylinder(r=4,h=40);
		translate([BeamLength-20,0,0])
			cylinder(r=4,h=40);
	}
}


module SupBeam(){
	difference(){
		rotate([0,90,0])
			linear_extrude(height = 150)
				SupBeamCross();
		cylinder(r=13, h=40);
		translate([150,0,0])
			cylinder(r=13, h=40);
	}
}	



module Primary_Arm(){
	
	Beam();

	difference(){
		Bearing_stack();
		rotate([0,45,0])
					cube([1,30,1],center=true);
	}	

	translate([150,0,0])
		difference(){
			Fastener_stack();
			rotate([0,45,0])
					cube([1,30,1],center=true);
		}

}

module Secondary_Arm(){
	difference(){
		union(){
			Beam(StackRadius = 29/2);

			translate([150,0,0])
				Fastener_stack();

			// Flat area for 90deg calibration - Set square
			translate([150*.75, 12.5, 5])
				cube([75,5,10], center=true);

			
			
		}
	
		translate([-3,8,13])
			rotate([0,90,0])
				cylinder(r=1.5, h=45, $fn = 10);

		translate([-3,-8,13])
			rotate([0,90,0])
				cylinder(r=1.5, h=45, $fn = 10);
		translate([150,0,0])
			rotate([0,45,0])
					cube([1,30,1],center=true);
	}
	
}
//translate([50,0,0])
//Hotend_stack();

module Hotend_stack(Hotend_D = 16.2, Hotend_H = 10)
{
	difference(){
		union(){
			translate([-11,11,5 + Hotend_H])
				difference(){
					import("Base_and_Riser_2.stl");
					cube([50,50,14], center = true);
			}
			
			cylinder(r=30/2, h=14 + Hotend_H, $fn=50);
			cylinder(r=27/2, h=15 + Hotend_H, $fn = 50);
			cylinder(r=25/2, h=23 + Hotend_H, $fn = 50);	
		}
			
		translate([0,0,-1])	
		union(){
			cylinder(r=Hotend_D/2,h=Hotend_H, $fn = 50);		// Mounting Hole for Hotend
			//translate([0,0,Hotend_H])
			//	cylinder(r=1.5, h=5, $fn=36);
			translate([0,0,Hotend_H])
				cylinder(r=3, h=8, $fn=36);
			translate([0,0,Hotend_H+8])
				cylinder(r1=3,r2 = 3.9,h=16, $fn=36);
		}

		rotate([0,45,0])
			cube([1,30,1],center=true);		
	}

	
}

//Hotend_stack_2();

module Hotend_stack_2(Hotend_D = 16.2, Hotend_H = 10)
{
	difference(){
		
		union(){
			translate([-11,11,20 + Hotend_H])
				rotate([20,0,0])
					difference(){
						import("Base_and_Riser_2.stl");
						cube([50,50,14], center = true);
					}
			
			cylinder(r=30/2, h=14 + Hotend_H, $fn=50);
			cylinder(r=27/2, h=15 + Hotend_H, $fn = 50);
			cylinder(r=25/2, h=22 + Hotend_H, $fn = 50);	
		}
			
		translate([0,0,-1])	
		
		union(){
			cylinder(r=Hotend_D/2,h=Hotend_H +1, $fn = 50);		// Mounting Hole for Hotend
			rotate([30,0,0])
				cylinder(r=2,h=100, $fn=36);
		}

		rotate([0,45,0])
			cube([1,30,1],center=true);		
	}

	
}

module Secondary_Arm_hotend_holder(Hotend_D = 16.2, Hotend_H = 12){
	difference(){
		
		union(){
			Hotend_stack(Hotend_D = Hotend_D, Hotend_H = Hotend_H);
			// mounting piece
			difference(){
				translate([13,0,Hotend_H-1])
					cube([8,12,20],center = true);
				
				translate([17,0,Hotend_H-10])
					rotate([0,45,0])
						cube([12,12,12],center = true);
			}
		}
		
	
		union(){

		// Arm mounting holes with "drop" openings
		translate([-3,8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=2, h=45, $fn = 10);
		translate([-6,8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=3.5, r2 = 2, h=3, $fn = 10);
		translate([-16,8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=4,h=10, $fn = 50);
		translate([-11,8,Hotend_H+5.828])
			rotate([45,0,0])
				cube([10,4,4], center = true);

		
		translate([-3,-8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=2, h=45, $fn = 10);
		translate([-6,-8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=3.5, r2 = 2, h=3, $fn = 10);
		
		translate([-16,-8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=4,h=10, $fn = 50);
		translate([-11,-8,Hotend_H+5.828])
			rotate([45,0,0])
				cube([10,4,4], center = true);
	
		// mounting holes for J-Head

		translate([6,20,Hotend_H-7])
			rotate([90,0,0])
				cylinder(r=1.5, h=40, $fn = 10);
		translate([-6,20,Hotend_H-7])
			rotate([90,0,0])
				cylinder(r=1.5, h=40, $fn = 10);

		// Subtract the beam
		translate([0,0,Hotend_H-10])
			Beam(StackRadius = 30/2);
		}
	}
	//SupportCylinder (r1 = 2, r2 = 7, h=10);
	translate([0,0,Hotend_H-1])
		cylinder(r=Hotend_D / 2, h=.4);
}

module Secondary_Arm_hotend_holder_2(Hotend_D = 16.2, Hotend_H = 12){
	difference(){
		
		union(){
			Hotend_stack_2(Hotend_D = Hotend_D, Hotend_H = Hotend_H);
			// mounting piece
			difference(){
				translate([13,0,Hotend_H-1])
					cube([8,12,20],center = true);
				
				translate([17,0,Hotend_H-10])
					rotate([0,45,0])
						cube([12,12,14],center = true);
			}
		}
		
	
		union(){
		translate([-3,8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=2, h=45, $fn = 10);
		translate([-6,8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=3.5, r2 = 2, h=3, $fn = 10);
		translate([-16,8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=4,h=10, $fn = 50);
		translate([-11,8,Hotend_H+5.828])
			rotate([45,0,0])
				cube([10,4,4], center = true);


		translate([-3,-8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=2, h=45, $fn = 10);
		translate([-6,-8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=3.5, r2 = 2, h=3, $fn = 10);
		
		translate([-16,-8,Hotend_H+3])
			rotate([0,90,0])
				cylinder(r=4,h=10, $fn = 50);
		translate([-11,-8,Hotend_H+5.828])
			rotate([45,0,0])
				cube([10,4,4], center = true);
	
		// mounting holes for J-Head

		translate([6,20,Hotend_H-5])
			rotate([90,0,0])
				cylinder(r=1.5, h=40, $fn = 10);
		translate([-6,20,Hotend_H-5])
			rotate([90,0,0])
				cylinder(r=1.5, h=40, $fn = 10);

		// Subtract the beam
		translate([0,0,Hotend_H-10])
			Beam(StackRadius = 30/2);
		}
	}
	//SupportCylinder (r1 = 2, r2 = 7, h=10);
	translate([0,0,Hotend_H])
		cylinder(r=Hotend_D / 2, h=.4);
}

module Sup_Arm1(){

	intersection(){
		union(){
			

			difference(){
				union(){
					SupBeam();
					cylinder(r=30/2, h=7, $fn = 50);
				}
				cylinder(r=22/2, h=7, $fn = 50);
				rotate([0,45,0])
					cube([1,30,1],center=true);
			}			

			//translate([150,0,0])
			//	Fastener_stack();
		}
		translate([-50,-25,0])
			cube([250,50,7]);
	}
	translate([150,0,0])
		difference(){
			cylinder(r=30/2, h=30, $fn = 50);
			cylinder(r=22/2, h=30, $fn = 50);
			rotate([0,45,0])
					cube([1,30,1],center=true);
		}	
		
}

module Sup_Arm2(){

	intersection(){
		union(){
			

			difference(){
				union(){
					SupBeam();
					cylinder(r=45/2, h=7, $fn = 50);
				}
				cylinder(r=37/2, h=7, $fn = 50);
				rotate([0,45,0])
					cube([1,50,1],center=true);
			}			

			translate([150,0,0])
				difference(){
					Fastener_stack();
					rotate([0,45,0])
						cube([1,30,1],center=true);
				}
		}
		translate([-50,-25,0])
			cube([250,50,7]);
	}

	difference(){
				cylinder(r=45/2, h=10, $fn = 50);
				translate([0,0,8])
					cylinder(r1=37/2, r2=35/2, h=1, $fn=50);
				cylinder(r=35/2,h=10, $fn=50);
				cylinder(r=37/2, h=8, $fn = 50);
				rotate([0,45,0])
					cube([1,50,1],center=true);
				//translate([150,0,0])
				//	rotate([0,45,0])
				//		cube([1,30,1],center=true);
	}	
}


motorshaft = 5;
motorshaftlenght = 15;
nutdiameter = 6;
nutheight = 3;
grubdiameter = 3;

leadscrewshaft = 7.5;
leadscrewshaftlenght = 13;
couplertopdiameter = 22;

module MorganZCoupler ()
{
	couplheight = motorshaftlenght+leadscrewshaftlenght+2;

	difference(){
		union(){
			cylinder(r=couplertopdiameter/2, h=couplheight);
			intersection(){
				translate([0,0,(couplheight*.75+5)/2])
					cube([couplertopdiameter,couplertopdiameter,couplheight*.75+5],center=true);
				cylinder(r1 = couplertopdiameter/1.45, r2=couplertopdiameter/2, h=couplheight*.75);
			}
		}

		polyhole (leadscrewshaftlenght,leadscrewshaft);
		translate([0,0,(leadscrewshaftlenght-1)/2])
			cube([2,couplertopdiameter,leadscrewshaftlenght-1],center=true);

		translate([0,0,leadscrewshaftlenght+2])
			polyhole(motorshaftlenght+1,motorshaft);

		for (i=[0:2]){
			rotate([0,0,i*(360/3)])
				translate([0,0,couplheight - (motorshaftlenght*.3)])
					rotate([0,90,0]){
						polyhole(couplertopdiameter, grubdiameter);
						
						translate([0,0,couplertopdiameter/5])
							for(j=[0:2])
								translate([-grubdiameter*j,0,0])
									nutHole(3);
					}

		}
		for (k=[-1,1])
			translate([-couplertopdiameter/2+2,k*(0.5+(leadscrewshaft/2)+grubdiameter/2),4])
				rotate([0,90,0]){
					translate([0,0,-1])
						#polyhole(couplertopdiameter,3);
					#boltHole(3,lenght=30);
					translate([0,0,couplertopdiameter-4])
						#nutHole(3);
				}
		
	}


}