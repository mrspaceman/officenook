echo(version=version());

use <./Write.scad>

showExploded=0;
showSkins=0;

skinWidth=6;
bottomSkinWidth=18;

battenWidth=63;
battenDepth=38;
battenLength=2400;

nookWidth=1100;
nookLength=1550;
nookHeight=2200;

deskHeight=720;
deskThickness=20;

roofBottom=nookHeight+battenDepth+skinWidth+bottomSkinWidth;
sideBottom=battenDepth+bottomSkinWidth;

skinColour="yellow";
battenColour="green";
textColour="blue";


module hollowCylinder(d=5, h=10, wallWidth=1, $fn=128) {
    echo("Hollow Cylinder");
	difference()
	{
		cylinder(d=d, h=h);
		translate([0, 0, -0.1]) { cylinder(d=d-(wallWidth*2), h=h+0.2); }
	}
}

module addBase() {
    color(battenColour)
        cube([nookLength , battenWidth , battenDepth]);
    color(battenColour)
        translate([0 , nookWidth-(battenWidth) , 0])
            cube([nookLength , battenWidth , battenDepth]);

    nbrBattens=5;
    battenSpacing=(nookLength-battenWidth)/nbrBattens;
    for (a = [0:5]){
      color(battenColour)
        translate([battenSpacing*a , battenWidth , 0])
            cube([battenWidth , nookWidth-(battenWidth*2) , battenDepth]);
    }

    if (showSkins==1)
    {
        translate([0 , 0 , battenDepth])
            cube([nookLength , nookWidth , bottomSkinWidth]);
    }
}


module addFront() {
    color(battenColour)
        translate([(nookLength/2)-battenWidth , 0 , sideBottom])
            cube([battenWidth , battenDepth , nookHeight]);
    color(battenColour)
        translate([(nookLength/2) , 0 , nookHeight/2])
            cube([(nookLength/2)-battenWidth-skinWidth , battenDepth , battenWidth]);

    if (showSkins==1) {
        //front-outside
        translate([(nookLength/2)-battenWidth , 0-skinWidth , 0])
            cube([(nookLength/2)+battenWidth , skinWidth , nookHeight+sideBottom+battenDepth+skinWidth*2]);
        //front-inside
        translate([(nookLength/2)-battenWidth , battenDepth , sideBottom])
            cube([(nookLength/2)-skinWidth , skinWidth , nookHeight+skinWidth]);
    }
}


module addFrontSide() {
    color(battenColour)
        translate([nookLength-battenWidth , 0 , sideBottom])
            cube([battenWidth , battenDepth , nookHeight]);
    color(battenColour)
        translate([nookLength-battenWidth , nookWidth-battenDepth , sideBottom])
            cube([battenWidth , battenDepth , nookHeight]);
    color(battenColour)
        translate([nookLength-battenWidth , (nookWidth/2)-(battenDepth/2) , sideBottom+battenDepth])
            cube([battenWidth , battenDepth , nookHeight-(battenDepth*2)]);

    nbrBattens=5;
    battenSpacing=(nookHeight-battenDepth)/nbrBattens;
    for (a = [0:5]){
      color(battenColour)
          //  echo(batten_height=sideBottom+(battenSpacing*a))
        translate([nookLength-battenWidth , battenDepth , sideBottom+(battenSpacing*a)])
            cube([battenWidth , nookWidth-(battenDepth*2) , battenDepth]);
    }

    if (showSkins==1) {
    // Cable Cutout
            translate([nookLength-battenWidth-(skinWidth*2)-5 , (nookWidth/2)+80 , 1000])
                rotate([90, 0, 90]) color("red")
                    hollowCylinder(d=75, h=85, wallWidth=3);
            {
            // outside
            translate([nookLength , 0 , 0])
                cube([skinWidth , nookWidth , nookHeight+sideBottom+battenDepth+skinWidth*2]);

            // inside
            translate([nookLength-battenWidth-skinWidth , 0 , sideBottom])
                cube([skinWidth , nookWidth , nookHeight]);
            }
    }
}
module addBackSide() {
    color(battenColour)
        translate([0 , 0 , sideBottom])
            cube([battenWidth , battenDepth , nookHeight]);
    color(battenColour)
        translate([0 , nookWidth-battenDepth , sideBottom])
            cube([battenWidth , battenDepth , nookHeight]);
    color(battenColour)
        translate([0 , (nookWidth/2)-(battenDepth/2) , sideBottom+battenDepth])
            cube([battenWidth , battenDepth , nookHeight-(battenDepth*2)]);

    nbrBattens=5;
    battenSpacing=(nookHeight-battenDepth)/nbrBattens;
    for (a = [0:5]){
      color(battenColour)
          //  echo(batten_height=sideBottom+(battenSpacing*a))
        translate([0 , battenDepth , sideBottom+(battenSpacing*a)])
            cube([battenWidth , nookWidth-(battenDepth*2) , battenDepth]);
    }
    
   if (showSkins==1) {
        // inside
        translate([battenWidth-skinWidth , 0 , sideBottom])
            cube([skinWidth , nookWidth , nookHeight]);
    }
}
module addBack(){
    color(battenColour)
        translate([0 , nookWidth+skinWidth , 0])
            cube([battenWidth , battenDepth , nookHeight+sideBottom-skinWidth]);

    color(battenColour)
        translate([nookLength-battenWidth , nookWidth+skinWidth , 0])
            cube([battenWidth , battenDepth , nookHeight+sideBottom-skinWidth]);

    color(battenColour)
        translate([nookLength/2 , nookWidth+skinWidth , 0])
            cube([battenWidth , battenDepth , nookHeight+sideBottom-skinWidth]);

    nbrBattens=5;
    battenSpacing=(nookHeight-skinWidth*2)/nbrBattens;
    for (a = [0:5]){
      color(battenColour)
          //  echo(batten_height=sideBottom+(battenSpacing*a))
        translate([battenWidth , nookWidth+skinWidth , battenSpacing*a])
            cube([nookLength-battenWidth-skinWidth , battenDepth , battenWidth]);
    }

    if (showSkins==1) {
        translate([0 , nookWidth , 0])
            cube([nookLength , skinWidth , nookHeight+sideBottom]);
    }
}


module addRoof() {
color(battenColour)
    translate([0 , 0 , roofBottom])
        cube([nookLength , battenWidth , battenDepth]);
color(battenColour)
    translate([0 , nookWidth-(battenWidth-battenDepth)+skinWidth , roofBottom])
        cube([nookLength , battenWidth , battenDepth]);
    
    nbrBattens=4;
    battenSpacing=(nookLength-battenWidth)/nbrBattens;
    for (a = [0:5]){
      color(battenColour)
    translate([battenSpacing*a , battenWidth , roofBottom])
        cube([battenWidth , nookWidth-(battenWidth) , battenDepth]);
    }

    if (showSkins==1) {
    //roof
    translate([0 , 0 , roofBottom-skinWidth])
        cube([nookLength , nookWidth+battenDepth+skinWidth , skinWidth]);
    translate([0 , 0 , roofBottom+battenDepth])
        cube([nookLength , nookWidth+battenDepth+skinWidth , skinWidth]);
    }
}



module addDesk() {
    translate([(nookLength/2)+25 , skinWidth+battenDepth+(nookWidth/2) , deskHeight+battenWidth+bottomSkinWidth+20])
        scale([14 , 14 , 4]) rotate(a=[0 , 0 , 270])
    color(textColour)
            write("Desk" , t=2 , h=6 , center=false);
    color(skinColour)
        translate([(nookLength/2)-skinWidth , skinWidth+battenDepth , 720+battenWidth+bottomSkinWidth])
            cube([(nookLength/2)-(battenWidth) , nookWidth-(skinWidth+battenDepth) , deskThickness]);
}

module addPcShelf(pcNbr) {
    translate([nookLength+battenDepth*3 , battenDepth+10 , 600*pcNbr+deskThickness])
      scale([14 , 14 , 4])
        rotate(a=[0 , 0 , 90])
        color(textColour)
            write("PC Shelf" , t=2 , h=6 , center=false);
    color(skinColour)
        translate([nookLength , battenDepth , 600*pcNbr])
            cube([200 , 500 , deskThickness]);
}



addBase();
addFront();
addRoof();
addFrontSide();
addBackSide();
addBack();

addDesk();
addPcShelf(1);
addPcShelf(2);
