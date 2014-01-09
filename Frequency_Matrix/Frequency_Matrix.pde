import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
FFT fft;

int gridWidth;
int gridHeight;
int squareSize;

int amplitude;
int count;
int mode;
int numOfModes;

//Beat Detection
int threshold;
int wait;

void setup(){
  size(320,320);
  background(0);
  squareSize = 20;
  
  minim = new Minim(this);
  player = minim.loadFile("Mind Electric - Scream (Original Mix).mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  numOfModes = 5;
  mode = 0;
  
  threshold =35;
  wait = 30;
}

void draw(){
  count = 0;
  background(0);
  player.play();
  fft.forward(player.mix);
  
  rectMode(CORNER);
  for(int i=0; i<width; i=i+squareSize){
      for (int j=0; j<height; j=j+squareSize){ 
   
          //Second band seems the best for beat detection for this song
          switch (mode){
              //All 512 bands
              case 0:
                  noStroke();
                  amplitude = (int) map(fft.getBand(count), 0, 50, 0, 255);
                  fill(0,mouseX,mouseY,amplitude); 
                  rect(j,i,squareSize,squareSize);
                  count++;
                
//                  //Beat Detection
//                  if(fft.getBand(1) > threshold && wait < 0){
//                      mode = (int)random(-1,numOfModes);
//                      wait+=30;  
//                  }
//                  wait--;
                  break;
              //First 16 bands
              case 1:
                  noStroke();
                  amplitude = (int) map(fft.getBand(count), 0, 50, 0, 255);
                  fill(0,mouseX,mouseY,amplitude); 
                  rect(j,i,squareSize,squareSize);
                  count++;
                  if(count >= 16){
                      count = 0;  
                  }              
                  break;
              case 2:
                  noStroke();
                  amplitude = (int) map(fft.getBand(count), 0, 50, 0, 255);
                  fill(0,mouseX,mouseY,amplitude); 
                  rect(i,j,squareSize,squareSize);
                  count++;
                  if(count >= 16){
                      count = 0;  
                  }              
                  break; 
              //First 32 bands                 
              case 3:
                  noStroke();
                  amplitude = (int) map(fft.getBand(count), 0, 50, 0, 255);
                  fill(0,mouseX,mouseY,amplitude); 
                  rect(j,i,squareSize,squareSize);
                  count++;
                  if(count >= 32){
                      count = 0;  
                  }              
                  break;
              case 4:
                  noStroke();
                  amplitude = (int) map(fft.getBand(count), 0, 50, 0, 255);
                  fill(0,mouseX,mouseY,amplitude); 
                  rect(i,j,squareSize,squareSize);
                  count++;
                  if(count >= 32){
                      count = 0;  
                  }              
                  break;                                
          }
          //System.out.println(fft.getBand(1));
      }
  }
}

void mousePressed(){
    mode++;
    if (mode >= numOfModes){
        mode = 0; 
    } 
  
}

void stop() {
     player.close();
     minim.stop();
     super.stop(); 
}

