import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer player;
FFT fft;

int sub, bass, mid, treb;
float subThreshold, bassThreshold, midThreshold, trebThreshold;

boolean randomize, refresh;

void setup() {
    //set up audio
    minim = new Minim(this);
    player = minim.loadFile("Mind Vortex - Alive.mp3");
    player.play();
    //FFT  
    fft = new FFT(player.bufferSize(), player.sampleRate());
    fft.window(FFT.HAMMING);
    
    //starting background
    size(320,240);
    background(0);
    
    sub = 0;
    bass = 10;
    mid = 50;
    treb = 100;
    subThreshold = 25;
    bassThreshold = 10;
    midThreshold = 5;
    trebThreshold = 5;
    
}

void draw() {
    player.play();
    if(keyPressed){
        if (key == 'b'){
            refresh = !refresh; 
        }
    }
    

    
    if (refresh){
        background(0);
    }
    fft.forward(player.mix);
    drawSub();
    drawBass();
    drawMid();
    drawTreble();
    
    //Debugging
    System.out.print("Sub: "+fft.getBand(sub));
    System.out.print(", Bass: "+fft.getBand(bass));
    System.out.print(", Mid: "+fft.getBand(mid));
    System.out.println(", Treble: "+fft.getBand(treb));

  
}

void drawSub() {
    float amplitude = fft.getBand(sub);
    int alpha = (int) map(amplitude, 0, 75, 0, 255);
    stroke(255);
    rectMode(CENTER);
    float x = random(0,width);
    float y = random(0,height);
    int sq_width = (int)random(0,125);
    int sq_height = (int)random(0,125);    
    if (amplitude > subThreshold) {
        fill(255, 255, 255, alpha);
        if (randomize){
            rect((int)x,(int)y,sq_width,sq_height);
        }
        else{
            rect((int)x,(int)y,50,50);
        }
    }
    
}

void drawBass() {
    float amplitude = fft.getBand(sub);
    int alpha = (int) map(amplitude, 0, 50, 0, 255);
    stroke(255);
    rectMode(CENTER);
    float x = random(0,width);
    float y = random(0,height);
    int sq_width = (int)random(0,125);
    int sq_height = (int)random(0,125);
    if (amplitude > bassThreshold) {
        fill(255, 0, 0, alpha);
        if (randomize){
            rect((int)x,(int)y,sq_width,sq_height);
        }
        else{
            rect((int)x,(int)y,50,50);
        }
    }

}

void drawMid() {
    float amplitude = fft.getBand(sub);
    int alpha = (int) map(amplitude, 0, 50, 0, 255);
    stroke(255);
    rectMode(CENTER);
    float x = random(0,width);
    float y = random(0,height);
    int sq_width = (int)random(0,125);
    int sq_height = (int)random(0,125);
    if (amplitude > midThreshold) {
        fill(0, 255, 0, alpha);
        if (randomize){
            rect((int)x,(int)y,sq_width,sq_height);
        }
        else{
            rect((int)x,(int)y,50,50);
        }    }
}

void drawTreble() {
    float amplitude = fft.getBand(sub);
    int alpha = (int) map(amplitude, 0, 25, 0, 255);
    stroke(255);
    rectMode(CENTER);
    float x = random(0,width);
    float y = random(0,height);
    int sq_width = (int)random(0,125);
    int sq_height = (int)random(0,125);
    if (amplitude > trebThreshold) {
        fill(0, 0, 255, alpha);
        if (randomize){
            rect((int)x,(int)y,sq_width,sq_height);
        }
        else{
            rect((int)x,(int)y,50,50);
        }    }
}

void mousePressed() {
    randomize = !randomize;  
}

void stop() {
   player.close();
   minim.stop();
   super.stop(); 
}




