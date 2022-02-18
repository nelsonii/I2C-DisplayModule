fileDescription = "Display";
fileType = "SWD";
fileVersion = "1C";

//The Belfry OpenSCAD Library
//https://github.com/revarbat/BOSL
include <BOSL/constants.scad>
use <BOSL/shapes.scad>


caseWidthX = 15.5;
caseDepthY = 41.5;
caseHeightZ = 18;
wallThickness = 3;

standoffSize = 5; // size of standoffs/mounts for boards and case enclosure
overlap = 1; // overlap ensures that subtractions go beyond the edges
shift = 6;

mountingScrewDiameter = 2.5; // M2.5
mountingScrewHeadDiameter = 4.5; // M2.5
mountingScrewHeadHeight = 2.7; // M2.5 

emboss = false;
  
$fn=60; //circle smoothness
  
difference(){
  union() {
    difference(){
      //base
      //rounded cuboid is from the BOSL library
      //I'm using p1 setting to zero bottom (z). X/Y are centered on 0,0,0
      color("steelblue")
      cuboid([caseWidthX,caseDepthY,caseHeightZ], fillet=2, 
       p1=[-(caseWidthX/2), -(caseDepthY/2), 0]);
      //subtract out the inner cuboid
      cuboid([caseWidthX-wallThickness,caseDepthY-wallThickness,caseHeightZ-wallThickness], fillet=0, 
       p1=[-((caseWidthX-wallThickness)/2), -((caseDepthY-wallThickness)/2), (wallThickness/2)]);
      if (emboss) {
        //emboss version on inside case
        color("whitesmoke")
         translate([-8, 2, 1])
          linear_extrude(2)
           text(fileType, size=5);
        color("whitesmoke")
         translate([-4,-5, 1])
          linear_extrude(2)
           text(fileVersion, size=5);
      }
    }//difference (base)
    
      
  }//union----------------------------------------------------------------------
  
  
  // Start of Difference stuff ************************************************************

  //display
  color("darkorange")
   translate([0,-1, 0])
     cuboid([11, 26, 10]);

  //jack
  color("darkorange")
     translate([0, +(caseDepthY+wallThickness)/2-5, 10]) 
      rotate([-90,0,0])
          cylinder(h=10, d=8.25); 

  
  //-------------------------------------------------------------------------------------------------------

  splitAtZ=16;
  
  //remove the top for split
  color("crimson")  translate([-((caseWidthX+overlap)/2),-((caseDepthY+overlap)/2),splitAtZ])  cube([caseWidthX+overlap, caseDepthY+overlap, caseHeightZ+overlap]);
  // ******* OR ******
  //Remove everything but the top
  //color("crimson") translate([-((caseWidthX+overlap)/2),-((caseDepthY+overlap)/2),splitAtZ-caseHeightZ])  cube([caseWidthX+overlap, caseDepthY+overlap, caseHeightZ+overlap]);

  //-------------------------------------------------------------------------------------------------------
  
  
}//difference
  

