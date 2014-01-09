import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
FFT fft;

BeatDetect beat;
int kickSize, snareSize, hatSize;

int amplitude;
float power;
int wait = 0;
//Should allow user to alter threshold for better control between songs
//There's no perfect algorithm to perfectly beat match these kind of visuals...
int threshold = 30;

float rotation = 0;
float radius = 5;

void setup() {
    //set up audio
    minim = new Minim(this);
    player = minim.loadFile(
        //"Doin' it right.mp3"
        "01 Power Glove.mp3"
    );
    //FFT  
    fft = new FFT(player.bufferSize(), player.sampleRate());
    fft.window(FFT.HAMMING);
    
    //Beat Detection
    beat = new BeatDetect(player.bufferSize(), player.sampleRate());
    beat.setSensitivity(32);
    
    
    //starting background
    size(320,240,P3D);
    background(0);
    
}


//Note: this approach erases and redraws every time draw() is called, this is probably the cause of the flashing. (Which in itself can be used as an added effect)


void draw() {
    background(0);
    player.play();
    
    fft.forward(player.mix);
    amplitude = (int) fft.getBand(20);
    
    power =  fft.calcAvg(20, 200);
    //System.out.println(power);
    

    
    
    //drawRotatingSystem();
    //drawBeatSystemOne();
    drawSphereBeat();
    //drawSphereAmp();
    
    //theEye();
    

}

void drawRotatingSystem() {
    //Beat Detection
    if (power > threshold && wait < 0) {
        rotation += PI/32;
        translate(width/2, height/2, 0);
        fill(255);
        noStroke();
        lights();
        rotateX(rotation);
        rotateY(rotation);
        rotateZ(rotation);
        box(power*2.5);
        wait+=10;
    }
    wait--;
    if (rotation >= 2*PI){
      rotation = 0;
    }    
}

void drawBeatSystemOne(){
    //Beat Detection

    if (power > threshold && wait < 0) {
      lights();
      pushMatrix();
        translate(width/2, height/2, 0);
        noFill();
        stroke(255);
        sphere(power*1.5);
      popMatrix();
            pushMatrix();
        translate(width/8, height/8, 0);
        fill(255);
        noStroke();
        box(power);
      popMatrix();
            pushMatrix();
        translate(width/8, 7*height/8, 0);
        fill(255);
        noStroke();
        box(power);
      popMatrix();
            pushMatrix();
        translate(7*width/8, height/8, 0);
        fill(255);
        noStroke();
        box(power);
      popMatrix();
            pushMatrix();
        translate(7*width/8, 7*height/8, 0);
        fill(255);
        noStroke();
        box(power);
      popMatrix();
      wait +=15;
    }
    wait--;  
}

void drawSphereBeat(){
    //Beat Detection
    beat.detect(player.mix);
    if (beat.isKick()){
        kickSize = 100;  
    }
    if (beat.isSnare()){
        snareSize = 50;  
    }
    if (beat.isHat()){
        hatSize = 50;  
    }
    
    pushMatrix();
      translate(width/2,height/2, -width/2);
      fill(255);
      noStroke();
      lights();
      sphere(kickSize);
    popMatrix();
    pushMatrix();
        translate(width/8, height/8, -width/2);
        fill(255);
        noStroke();
        box(hatSize);
      popMatrix();
      pushMatrix();
        translate(width/8, 7*height/8, -width/2);
        fill(255);
        noStroke();
        box(snareSize);
      popMatrix();
      pushMatrix();
        translate(7*width/8, height/8, -width/2);
        fill(255);
        noStroke();
        box(hatSize);
      popMatrix();
      pushMatrix();
        translate(7*width/8, 7*height/8, -width/2);
        fill(255);
        noStroke();
        box(snareSize);
      popMatrix();
    kickSize *= .95;
    snareSize *= .95;
    hatSize *= .95;
    
    
    
    
//    if (power > threshold && wait < 0) {
//      pushMatrix();
//        translate(width/2, height/2, -width/2);
//        fill(255);
//        stroke(255);
//        sphere(power*1.5);
//      popMatrix();
//      wait +=10;
//    }
//    wait--;  
}

PImage img;
void theEye(){
    img = loadImage("eye.jpg");
    image(img, -70, -115);
    
    beat.detect(player.mix);
    if (beat.isKick()){
        kickSize = 65;  
    }
    
    pushMatrix();
      translate(width/2, height/2, 0);
      noStroke();
      fill(0);
      sphere(kickSize);
    popMatrix();
    kickSize *= .95;
    if (kickSize < 50){
        kickSize = 50;
    }
}

void drawSphereAmp(){
    //Based on amplitude of specific FFT band
    amplitude *= 10;
    pushMatrix();
      translate(width/2, height/2, -width/2);
      noFill();
      stroke(255);
      sphere(amplitude);
    popMatrix();
    player.play();  
  
}

void stop() {
   player.close();
   minim.stop();
   super.stop(); 
}




