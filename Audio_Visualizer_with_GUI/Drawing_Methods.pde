//Modifying FFT values according to frequency region
//This is where interpolation should take place
float getModifiedBand(int f) {
  float amplitude = fft.getBand(f);
  if (f < 41) {
    amplitude *= 2;
  }
  else if (f < 1000 && f > 40) {
    amplitude *= 6;
  }
  else {
    amplitude *= 120;
  }

  //Scaling to dB scale
  //amplitude = Math.round(2*20*Math.log10(100*amplitude));
  return amplitude;
}

//Thresholding FFT Bands
float getLimitedBand(int f) {
    float amplitude = getModifiedBand(f);
    if(amplitude > SCREEN_HEIGHT){
        amplitude = SCREEN_HEIGHT-20;  
    }
    return amplitude;
}

//Thresholding FFT Bands if visualization is translated to center
float getLimitedBandForCenter(int f, int radius) {
    float amplitude = getModifiedBand(f);
    if (SCREEN_HEIGHT > SCREEN_WIDTH){
        if (amplitude > (SCREEN_WIDTH/2)-radius){
            amplitude = (SCREEN_WIDTH/4)-radius;
        }
        return amplitude;  
    }
    else {
        if(amplitude > (SCREEN_HEIGHT/2)-radius){
            amplitude = (SCREEN_HEIGHT/4)-radius;  
        }
        return amplitude;  
    }
}

//Method accepts RGB values for color changes
void drawSingleSpectrum(int r, int g, int b){ 
        // perform a forward FFT on the samples in the input buffer
        fft.forward(player.mix.toArray());
        stroke(r,g,b);
        for (int i = 0; i < SCREEN_WIDTH; i++) {
            line(BOTTOM_LEFT_CORNER_X+i,
                BOTTOM_LEFT_CORNER_Y,
                BOTTOM_LEFT_CORNER_X+i,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
        }
}

//Method accepts RGB values for color changes
void drawDoubleSpectrum(int r, int g, int b){ 
        // perform a forward FFT on the samples in the input buffer
        fft.forward(player.mix.toArray());
        stroke(r,g,b);
        for (int i = 0; i < SCREEN_WIDTH; i++) {
            line(BOTTOM_LEFT_CORNER_X+i,
                BOTTOM_LEFT_CORNER_Y,
                BOTTOM_LEFT_CORNER_X+i,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
            line(UPPER_RIGHT_CORNER_X-i,
                 UPPER_RIGHT_CORNER_Y,
                 UPPER_RIGHT_CORNER_X-i,
                 UPPER_RIGHT_CORNER_Y+getLimitedBand(i));
        }
}

//Method accepts RGB values for color changes
void drawQuadSpectrum(int r, int g, int b){ 
        // perform a forward FFT on the samples in the input buffer
        fft.forward(player.mix.toArray());
        stroke(r,g,b);
        for (int i = 0; i < SCREEN_WIDTH; i++) {
            //Bottom Spectrum
            line(BOTTOM_LEFT_CORNER_X+i,
                BOTTOM_LEFT_CORNER_Y,
                BOTTOM_LEFT_CORNER_X+i,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
            //Top Spectrum
            line(UPPER_RIGHT_CORNER_X-i,
                 UPPER_RIGHT_CORNER_Y,
                 UPPER_RIGHT_CORNER_X-i,
                 UPPER_RIGHT_CORNER_Y+getLimitedBand(i));
        }
        for (int i=0; i < SCREEN_HEIGHT; i++) { 
            //Left Spectrum
            line(UPPER_LEFT_CORNER_X,
                 UPPER_LEFT_CORNER_Y+i,
                 UPPER_LEFT_CORNER_X+getLimitedBand(i),
                 UPPER_LEFT_CORNER_Y+i);
            //Right Spectrum
            line(BOTTOM_RIGHT_CORNER_X,
                 BOTTOM_RIGHT_CORNER_Y-i,
                 BOTTOM_RIGHT_CORNER_X-getLimitedBand(i),
                 BOTTOM_RIGHT_CORNER_Y-i);
        }
}

//Method accepts RGB values for color changes ^
void drawCenteredSpectrum(int r, int g, int b){ 
        // perform a forward FFT on the samples in the input buffer
        fft.forward(player.mix.toArray());
        stroke(r,g,b);
        for (int i = 3; i < SCREEN_WIDTH/2; i++) {
            line(SCREEN_CENTER_X+i-3,
                BOTTOM_LEFT_CORNER_Y,
                SCREEN_CENTER_X+i-3,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
            line(SCREEN_CENTER_X-i+3,
                BOTTOM_LEFT_CORNER_Y,
                SCREEN_CENTER_X-i+3,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
        }
}

//Method accepts RGB values for color changes
void drawCrossCenteredSpectrum(int r, int g, int b){ 
        // perform a forward FFT on the samples in the input buffer
        fft.forward(player.mix.toArray());
        stroke(r,g,b);
        for (int i = 3; i < SCREEN_WIDTH/2; i++) {
            line(SCREEN_CENTER_X+i-3,
                BOTTOM_LEFT_CORNER_Y,
                SCREEN_CENTER_X+i-3,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
            line(SCREEN_CENTER_X-i+3,
                BOTTOM_LEFT_CORNER_Y,
                SCREEN_CENTER_X-i+3,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
            line(SCREEN_CENTER_X-i+3,
                 UPPER_RIGHT_CORNER_Y,
                 SCREEN_CENTER_X-i+3,
                 UPPER_RIGHT_CORNER_Y+getLimitedBand(i));
            line(SCREEN_CENTER_X+i-3,
                 UPPER_RIGHT_CORNER_Y,
                 SCREEN_CENTER_X+i-3,
                 UPPER_RIGHT_CORNER_Y+getLimitedBand(i));
        }
}

//Method accepts RGB values for color changes
void drawArrowedSpectrum(int r, int g, int b){ 
        // perform a forward FFT on the samples in the input buffer
        fft.forward(player.mix.toArray());
        stroke(r,g,b);
        for (int i = 3; i < SCREEN_WIDTH/2; i++) {
            line(SCREEN_CENTER_X+i-3,
                BOTTOM_LEFT_CORNER_Y,
                SCREEN_CENTER_X+i-3,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
            line(SCREEN_CENTER_X-i+3,
                BOTTOM_LEFT_CORNER_Y,
                SCREEN_CENTER_X-i+3,
                BOTTOM_LEFT_CORNER_Y-getLimitedBand(i));
            line(UPPER_LEFT_CORNER_X+i+3,
                 UPPER_LEFT_CORNER_Y,
                 UPPER_LEFT_CORNER_X+i+3,
                 UPPER_LEFT_CORNER_Y+getLimitedBand(i));
            line(UPPER_RIGHT_CORNER_X-i-3,
                 UPPER_RIGHT_CORNER_Y,
                 UPPER_RIGHT_CORNER_X-i-3,
                 UPPER_RIGHT_CORNER_Y+getLimitedBand(i));
        }    
}

void drawRing(int r, int g, int b){
        // perform a forward FFT on the samples in the input buffer
        fft.forward(player.mix.toArray());
        stroke(r,g,b);
        noFill();
        int radius = 50;
        for (int degree=0; degree<360; degree++){
            pushMatrix();
            translate(SCREEN_CENTER_X, SCREEN_CENTER_Y);
            rotate(radians(degree));            
            line(0,radius,0,radius+getLimitedBandForCenter(degree,radius));
            popMatrix();  
        }
}

void drawTheNeedle(int r, int g, int b){
        // perform a forward FFT on the samples in the input buffer
        fft.forward(player.mix.toArray());
        stroke(r,g,b);
        noFill();
        int radius = 50;
        for (int degree=0; degree<360; degree++){
            pushMatrix();
            translate(SCREEN_CENTER_X, SCREEN_CENTER_Y);
            rotate(radians(degree));            
            if (degree < 180){
              line(0,radius,0,radius+getLimitedBandForCenter(degree,radius));
            }
            else {
              line(0,radius,0,radius+getLimitedBandForCenter(degree-180,radius));          
            }
            popMatrix();  
        }
        
}

//Very basic, must improve or remove
void drawWaveform(int r, int g, int b){
        for(int i = 0; i < player.bufferSize(); i++) {
            ellipse(i, 50 + player.mix.get(i)*10, 2, 2);
        }
}

//Add color
void drawLevels(int r, int g, int b){
        fft.logAverages(40,3);
        fft.forward(player.mix.toArray());
        noStroke();
        fill(r,g,b);
        int colWidth = int(SCREEN_WIDTH/fft.avgSize());
        rectMode(CORNERS);
        for (int i=0; i<fft.avgSize(); i++){
            rect(BOTTOM_LEFT_CORNER_X + (i*colWidth),
                 BOTTOM_LEFT_CORNER_Y,
                 BOTTOM_LEFT_CORNER_X + (i*colWidth) + colWidth,
                 BOTTOM_LEFT_CORNER_Y - getLimitedBand(i));   
        }
}
         
void drawBeatSphere(int r, int g, int b){
    beatDetect.forward(player.mix.toArray());
    float power = beatDetect.getBand(2);
    System.out.println("Power: "+power);
    if (power > threshold && wait == 0) {
        pushMatrix();
            translate(SCREEN_CENTER_X, SCREEN_CENTER_Y, 0);
            //noFill();
            fill(r,g,b);
//            stroke(r,g,b);
            noStroke();
            sphere(power*.5);
        popMatrix();
        //wait=4;
    }
   // wait--;   
  
  
  
  
  
//  fft.forward(player.mix.toArray());
//  float power = fft.calcAvg(20,200);
//  System.out.println("Power: "+power+" Thresh: "+threshold);

//  //Beat Detection
//  if (power > threshold && wait < 0) {
//      pushMatrix();
//          translate(SCREEN_CENTER_X, SCREEN_CENTER_Y, 0);
//          //noFill();
//          fill(r,g,b);
//          stroke(r,g,b);
//          sphere(power);
//      popMatrix();
//      wait+=10;
//  }
//  wait--;  
}




void drawAVC(int r, int g, int b){
        fft.logAverages(40,3);
        fft.forward(player.mix.toArray());
        noStroke();
        fill(r,g,b);
        int colWidth = int(SCREEN_WIDTH/fft.avgSize());
        rectMode(CORNERS);
        for (int i=0; i<fft.avgSize(); i++){
            rect(BOTTOM_LEFT_CORNER_X + (i*colWidth),
                 BOTTOM_LEFT_CORNER_Y,
                 BOTTOM_LEFT_CORNER_X + (i*colWidth) + colWidth,
                 BOTTOM_LEFT_CORNER_Y - getLimitedBand(i));   
        }
}


    
