/**
* Midi Test 00
*
* A Bouncing Sphere.
* The following mapped to midi controllers on Alesis QX49 keyboard:
*   Radius, x&y speed, color, xyz rotation, stroke weight, sphere detail
* 
* By John Boyle, June 7 2015
*/

import themidibus.*;

MidiBus myBus;

// Sphere detail
int ures = 5;
int vres = 5;

// Sphere size, position, speed, direction, color, and rotation speeds
float rad = 20;
float xpos, ypos;
float xspeed = 2.8;
float yspeed = 2.2;
int xdirection = 1;
int ydirection = 1;
float[] c1 = {
  100, 127, 30
};
float xrot = 0.001;
float yrot = 0.002;
float zrot = 0.001;
float sweight = 4;


void setup() {
  size(displayWidth/3, displayHeight/2 -50, P3D);
  frameRate(15);
  colorMode(RGB);
  
  // Set the starting position of the shape
  xpos = width/2;
  ypos = height/2;

  //  // List all our MIDI devices
//  MidiBus.list();

  // Connect to one of the devices
  myBus = new MidiBus(this, 0, 1);
}


void draw() {
  background(102);
  lights();

  // Update the position of the shape
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );

  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
  if (xpos > width-rad || xpos < rad) {
    xdirection *= -1;
  }
  if (ypos > height-rad || ypos < rad) {
    ydirection *= -1;
  }

  // Descriptive Text
  textSize(32);
  fill(0, 0, 0);
  text("HELLO", xpos+rad, ypos-16);

  translate(xpos, ypos, 0);
  rotateX(frameCount * xrot);
  rotateY(frameCount * yrot);
  rotateZ(frameCount * zrot);
  stroke(color(c1[0], c1[1], c1[2]));
  strokeWeight(sweight);
  noFill();
  sphereDetail(ures, vres);
  sphere(rad);

}
// This function is called each time a knob, slider or button is pressed
// in the MIDI controller. It's up to us to do something interesting
// with the received values.
void controllerChange(int channel, int number, int value) {
  // Here we print the controller number.
  println(number);

  switch(number) {
    // Modulation roller
  case 1:
    rad = map(value, 0, 127, 5, 400); 
    break;

    // K Knobs (K1=14, K8=21)
  case 14:
    xspeed = mapMIDI(value, 0, 40); 
    break;
  case 15:
    yspeed = mapMIDI(value, 0, 40); 
    break;
  case 18:
    xrot = mapMIDI(value, 0, 0.1);
    break;
  case 19:
    yrot = mapMIDI(value, 0, 0.1);
    break;
  case 20:
    zrot = mapMIDI(value, 0, 0.1);
    break;

      // S Pots (S1=22, S8=29)
  case 27:
    c1[0] = mapMIDI(value, 0, 255); 
    break;
  case 28:
    c1[1] = mapMIDI(value, 0, 255); 
    break;
  case 29:
    c1[2] = mapMIDI(value, 0, 255); 
    break;
  case 25:
    ures = int(mapMIDI(value, 0, 30)); 
    break;
  case 26:
    vres = int(mapMIDI(value, 0, 30)); 
    break;
  case 24:
    sweight = int(mapMIDI(value, 1, 8)); 
    break;
  }
}


float mapMIDI(int value, float start2, float stop2) {
  return map(value, 0, 127, start2, stop2);
}

