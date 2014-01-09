import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int gridWidth;
int gridHeight;
int squareSize;

boolean colored;

void setup(){
  size(480,480);
  squareSize = 48;
  gridWidth = width/squareSize;
  gridHeight = height/squareSize;
  System.out.println("Square Size is now: "+squareSize);
}

void draw(){
  rectMode(CORNER);
  for(int i=0; i<mouseX; i=i+squareSize){
      for (int j=0; j<mouseY; j=j+squareSize){
          noStroke();
          if (colored){
              fill((int)random(0,255),(int)random(0,255),(int)random(0,255));
          }
          else{
              fill((int)random(0,255));
          }
          rect(i,j,squareSize,squareSize);
      }
  }

}

void mousePressed() {
    colored = !colored; 
}

void keyReleased() {
    if (key == 'z'){
        if(squareSize < width){
            squareSize *= 2; 
            System.out.println("Square Size is now: "+squareSize); 
        }
    }
    if (key == 'x'){
        if(squareSize > 3){
            squareSize /= 2;
            System.out.println("Square Size is now: "+squareSize);
        }
    }
}

void stop(){
  
}

