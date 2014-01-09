import controlP5.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


//Globals
ControlP5 cp5;
Minim minim;
AudioPlayer player;
FFT fft, beatDetect;
boolean playing;
int r,g,b;
int mode, numOfModes;
boolean muting;

//Beat Detection Globals
int wait = 0;
int threshold = 30;

int UPPER_LEFT_CORNER_X;
int UPPER_LEFT_CORNER_Y;
int UPPER_RIGHT_CORNER_X;
int UPPER_RIGHT_CORNER_Y;
int BOTTOM_LEFT_CORNER_X;
int BOTTOM_LEFT_CORNER_Y;
int BOTTOM_RIGHT_CORNER_X;
int BOTTOM_RIGHT_CORNER_Y;
int SCREEN_WIDTH;
int SCREEN_HEIGHT;
int SCREEN_CENTER_X;
int SCREEN_CENTER_Y;
int MARGIN;

void setup() {
  //Window
  //Change window size to suit 512x384 screen size
  size(900,600,P3D);
  background(0);
  frameRate(30);
  
  //Screen Variables 
  //Change screen size to 600x300 //Prev 512x384
  UPPER_LEFT_CORNER_X      = 150; //Prev 150
  UPPER_LEFT_CORNER_Y      = 50;  //Prev 50
  UPPER_RIGHT_CORNER_X     = 750 ;  //Prev 662
  UPPER_RIGHT_CORNER_Y     = 50;  //Prev 50
  BOTTOM_LEFT_CORNER_X     = 150;  //Prev 150
  BOTTOM_LEFT_CORNER_Y     = 350;  //Prev 434
  BOTTOM_RIGHT_CORNER_X    = 750;  //Prev 662
  BOTTOM_RIGHT_CORNER_Y    = 350;  //Prev 434
  SCREEN_WIDTH             = BOTTOM_RIGHT_CORNER_X - BOTTOM_LEFT_CORNER_X; //600px
  SCREEN_HEIGHT            = BOTTOM_LEFT_CORNER_Y - UPPER_LEFT_CORNER_Y;   //300px
  SCREEN_CENTER_X          = ((UPPER_RIGHT_CORNER_X - UPPER_LEFT_CORNER_X)/2)+UPPER_LEFT_CORNER_X;
  SCREEN_CENTER_Y          = ((BOTTOM_LEFT_CORNER_Y - UPPER_LEFT_CORNER_Y)/2)+UPPER_LEFT_CORNER_Y;
  MARGIN                   = 20;

  //Screen 
  stroke(255);
  fill(0);
  rectMode(CORNER);
  rect(UPPER_LEFT_CORNER_X,
       UPPER_LEFT_CORNER_Y,
       SCREEN_WIDTH,
       SCREEN_HEIGHT);
  
  //Controls Container
  fill(32);
  stroke(32);
  rectMode(CORNER);
  rect(0,2*height/3,width,height/3);
  
  //GUI (ControlP5)
  cp5 = new ControlP5(this);
  cp5.addButton("Play/Pause")
     .setPosition(MARGIN,420);
  cp5.addButton("Mode")
     .setPosition(110,420);
  cp5.addButton("Mute")
     .setPosition(MARGIN,570);
  cp5.addSlider("Red",0,255,255,MARGIN,460,200,20);
  cp5.addSlider("Blue",0,255,255,MARGIN,500,200,20);
  cp5.addSlider("Green",0,255,255,MARGIN,540,200,20);
  cp5.addSlider("Threshold",0,100,25,(MARGIN*3)+200,420,20,155);
  
      
  //Audio Setup
  minim = new Minim(this);
  player = minim.loadFile(
      //"01 Power Glove.mp3"
      //"Tut Tut Child - Dragon Pirates.mp3"
      "Mind Vortex - Alive.mp3"
      );
  
  //FFT Setup
  fft = new FFT(player.bufferSize(), player.sampleRate());
  fft.window(FFT.HAMMING);
  
  beatDetect = new FFT(player.bufferSize(), player.sampleRate());
  beatDetect.linAverages(6);

  
  
  mode = 0;
  numOfModes = 11;
  playing = true;
  muting = false; //reset to false
  
  //Initial values for RGB
  r = g = b = 255;
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isController()) {
    //For Debugging
//    print("control event from: "+theEvent.controller().name());
//    println(", value: "+theEvent.controller().value());
    
    if(theEvent.controller().name()=="Play/Pause"){
      playing=!playing;
      if(playing){
        player.play(); 
      }
      else {
        player.pause();
      }   
    }
    
    if(theEvent.controller().name()=="Mode"){
      mode++;
      if (mode > numOfModes-1){
          mode = 0;
      }
    }
    
    if(theEvent.controller().name()=="Red"){
      r = (int) theEvent.controller().value();  
    }
    
    if(theEvent.controller().name()=="Green"){
      g = (int) theEvent.controller().value();  
    }
    
    if(theEvent.controller().name()=="Blue"){
      b = (int) theEvent.controller().value();  
    }    
    
    if(theEvent.controller().name()=="Mute"){
      muting=!muting;
      if(muting){
        player.unmute(); 
      }
      else {
        player.mute();
      } 
    }
    
    if(theEvent.controller().name()=="Threshold"){
      threshold = (int) theEvent.controller().value();  
    }  
    
  }  
}

void draw() {
 
   if (playing) {
        player.play();
        background(0);
  
        
  
        //Always draw Control Container for every mode
        switch (mode) {
          case 0:
            drawSingleSpectrum(r,g,b);
                //Debug for Beat Detection
                //drawBeatDetectSpectrum();
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 1:
            drawDoubleSpectrum(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 2:
            drawQuadSpectrum(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 3:
            drawCenteredSpectrum(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 4:
            drawCrossCenteredSpectrum(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 5:
            drawArrowedSpectrum(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;       
          case 6:
            drawRing(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 7:
            drawTheNeedle(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 8:
            drawWaveform(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 9:
            drawLevels(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          case 10:
            //drawBeatSphere(r,g,b);
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
            break;
          }
    }
    else {
            fill(32);
            stroke(32);
            rectMode(CORNER);
            rect(0,2*height/3,width,height/3);
    }  
}

void drawBeatDetectSpectrum(){
        background(0);
        beatDetect.forward(player.mix.toArray());
        noStroke();
        fill(r,g,b);
        int colWidth = int(SCREEN_WIDTH/beatDetect.avgSize());
        rectMode(CORNERS);
        for (int i=0; i<beatDetect.avgSize(); i++){
            rect(BOTTOM_LEFT_CORNER_X + (i*colWidth),
                 BOTTOM_LEFT_CORNER_Y,
                 BOTTOM_LEFT_CORNER_X + (i*colWidth) + colWidth,
                 BOTTOM_LEFT_CORNER_Y - beatDetect.getBand(i));   
        }
        System.out.println("Sub: "+beatDetect.getBand(0)
                           +" Bass: "+beatDetect.getBand(1)
                           +" LowMid: "+beatDetect.getBand(2)
                           +" HighMid: "+beatDetect.getBand(3)
                           +" High: "+beatDetect.getBand(4)
                           +" Ultra: "+beatDetect.getBand(5));  

}


void stop() {
    //Close Minim
    player.pause();
    player.close();
    minim.stop();
    super.stop();
}

