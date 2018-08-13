//UT47 Case Cad file
// -Rev 2: add rotate to make it easier to print.
// -Rev 3: increase case height, increase plateHeight.
// -Rev 3a: remove screw holes.
// -Rev 3b: lowered plate holder slightly.
// -Rev 4: included pegs, moved usb hole over, slighty raised lip.
// -Rev 4a: updated pegs to hopefully fit better.
// -Rev 5: Decreased length by 1, increase peg holes, fit usb hole

//Gap to split in half
plateGap=20;

//Enter Plate dimensions
plateLength=91;
plateWidth=253+plateGap;
plateHeight=2.3;

//How large of a lip do you want the plate to sit in
plateHolderWidth=14;
//How far down do you want the plate to sit from the top
plateDepth=8;

//Enter how much you want the case to extrude from the plate
extrude = 10;
length=plateLength+extrude;
width=plateWidth+extrude;

//Enter the total height of the case
height=25.5;

//Enter how far from the edge the holes should be
holeOffset=5;

//Calculate the necessary inner dimensions
innerLength=plateLength-plateHolderWidth;
innerWidth=plateWidth-plateHolderWidth;
innerHeight=height;

//Enter desired slant angle of case
angle=3.5;
flattenHeight=(cos(90-angle))*width;

//Enter desired edge settings
edgeCutAngle=45;
edgeCutWidth=7;
edgeCutHeight1=edgeCutWidth*(cos(90-edgeCutAngle));
edgeCutHeight2=edgeCutHeight1*(cos(90-edgeCutAngle));
edgeCutTranslate=edgeCutHeight1;

//Helpful Rotation axis
xAxisRotate=[1,0,0];
yAxisRotate=[0,1,0];
zAxisRotate=[0,0,1];


//Create base of the case
rotate(a=-angle,v=(yAxisRotate))
difference()
{
        //Create bottom fill
        cube([length,width,1]);
        
	    //Create the block to cut it in half
        translate([0,(width-plateGap)/2,0])
        cube([length,plateGap,height]);
}

//Create the rest of the case
rotate(a=-angle,v=(yAxisRotate))
{
    difference()
    {
        rotate(a=angle,v=(yAxisRotate))
        difference()
        {
            //Create initial block
            cube([length,width,height]);
            
            //Create the block to cut it in half
            translate([0,(width-plateGap)/2,0])
            cube([length,plateGap,height]);
            
            //Crea//Create the rest of the casete initial inner cut (upper most cutout)
            translate([(length-innerLength)/2,(width-innerWidth)/2,0])
            cube([innerLength,innerWidth,innerHeight]);
            
            //Create plate holder cut
            translate([((length-innerLength)/2)-(plateHolderWidth/2),((width-innerWidth)/2)-(plateHolderWidth/2),height-plateDepth])
            cube([plateLength,plateWidth,plateHeight]);
            
            //Create USB hole
            translate([0,((width)-(((width-innerWidth)/2)-(plateHolderWidth/2)))-41,height-plateDepth-11.5])
            cube([20,14,9]);
            
            //create second inner cut (bottom most cutout)
            translate([((length-innerLength)/2)-2,((width-innerWidth)/2)-2,-plateDepth+4])
            cube([plateLength-(plateHolderWidth/2)-3,plateWidth-(plateHolderWidth/2)-3,height-plateHeight]);
            
            //Create edge cuts
            translate([0,0,height-edgeCutTranslate])
            rotate(a=-edgeCutAngle,v=yAxisRotate)
            cube([edgeCutWidth,width,edgeCutHeight2]);
            
            translate([0,0,height-edgeCutTranslate])
            rotate(a=edgeCutAngle,v=xAxisRotate)
            cube([length,edgeCutWidth,edgeCutHeight2]);    
            
            translate([length-edgeCutTranslate,0,height])
            rotate(a=edgeCutAngle,v=yAxisRotate)
            cube([edgeCutWidth,width,edgeCutHeight2]);
            
            translate([0,width-edgeCutTranslate,height])
            rotate(a=-edgeCutAngle,v=xAxisRotate)
            cube([length,edgeCutWidth,edgeCutHeight2]);  
        }
        
        //Flatten the base
        translate([0,0,-flattenHeight])
        cube([length+100,width+100,flattenHeight]);
        
        //Create peg holes, slightly larger than the pegs
        translate([5,(width+plateGap)/2,5])
        rotate(a=-90,v=(xAxisRotate))
        cylinder(5.2,d=5,$fn=20);
        translate([length-5,(width+plateGap)/2,5])
        rotate(a=-90,v=(xAxisRotate))
        cylinder(5.2,d=5.3,$fn=20);
    }

    //Create pegs
    translate([5,(width-plateGap)/2,5])
    rotate(a=-90,v=(xAxisRotate))
    difference()
    {
        cylinder(5,d=5);
        cylinder(5,d=2.5,$fn=20);
    }
    translate([length-5,(width-plateGap)/2,5])
    rotate(a=-90,v=(xAxisRotate))
    difference()
    {
        cylinder(5,d=5);
        cylinder(5,d=2.5,$fn=20);
    }

}