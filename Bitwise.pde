int loop1,loop2,loop3;
boolean rising = false;
PFont sidebarfont,axesfont;
PImage gbGrad,rGrad;
int leftSidebarSlide = 100;

void keyPressed(){
  if(key=='q'){loop1++;}
  if(key=='a' && loop1>1){loop1--;}
  if(key=='w'){loop2++;}
  if(key=='s' && loop2>1){loop2--;}
  if(key=='e'){loop3++;}
  if(key=='d' && loop3>1){loop3--;}
  if(key==' '){println("=======================================",
                     "\nFrame:",frameCount,
                     "\tFrames Left:",256*256-frameCount,
                     "\tPercent Complete:",100f*frameCount/(256*256),"%",
                     "\nfps:",frameRate,
                     "\tEstimated Time Remaining:",(256*256-frameCount)/(60*frameRate));}
}

void hilbertColors(){
  if(rising){
    loop1++;
    if(loop1 == 1024){rising=false;}
  } else {
    loop1--;
    if(loop1 == 1){rising=true;}
  }
  int[] p = hilbertXY(256,frameCount);
  loop2 = p[0] + 128;
  loop3 = p[1] + 128;
}


void setup() {
  loop1 = 1024;
  loop2 = 128;
  loop3 = 128;
  size(1920, 1080);
  gbGrad = loadImage("GB.bmp");
  rGrad = loadImage("R.bmp");
  sidebarfont = createFont("Consolas",36);
  axesfont = createFont("Consolas",22);
  strokeWeight(2);
}

void draw() {
  //hilbertColors();
  colorMode(RGB, loop1, loop2, loop3);
  background(0);
  
  //Display RGB Formulae
  textFont(sidebarfont);
  fill(loop1,0,0);
  stroke(loop1,0,0);
  textAlign(CENTER);
  text("R:(x XOR y) mod "+loop1+"\n"+loop1,224,50 + leftSidebarSlide);
  line(90,64 + leftSidebarSlide,396,64 + leftSidebarSlide);
  fill(0,loop2,0);
  stroke(0,loop2,0);
  text("G:(x AND y) mod "+loop2+"\n"+loop2,224,150 + leftSidebarSlide);
  line(90,164 + leftSidebarSlide,396,164 + leftSidebarSlide);
  fill(0,0,loop3);
  stroke(0,0,loop3);
  text("B:(x  OR y) mod "+loop3+"\n"+loop3,224,250 + leftSidebarSlide);
  line(90,264 + leftSidebarSlide,396,264 + leftSidebarSlide);
  fill(loop1, loop2, loop3);
  noStroke();
  
  //axes labels
  textFont(axesfont);
  text('0',448,height-12);//x label
  text('x',512+448,height-12);
  text("1023",1024+448,height-12);
  text('0',438,height-32);//y label
  text('y',438,height-32-512);
  text("1023",418,height-32-1024);

  
  stroke(loop1,loop2,loop3);
  fill(loop1,loop2,loop3);
  textAlign(LEFT);
  text("q/a control Red/XOR\nw/s control Green/AND\ne/d control Blue/OR\n\nValues greater than 1024 will\nmostly be boring.",
       1024+470,leftSidebarSlide);
  
  rect(446,23,1026,height-55);
  //the main event
  loadPixels();
  for (int y=1; y<1024; y++) {
    for (int x=0; x<1024; x++) {
      pixels[(height-y-32)*width + x + 448] = color((x^y)%loop1,(x&y)%loop2,(x|y)%loop3);
    }
  }
  updatePixels();
  
  saveFrame("frames/bitcarpets#######.png");
  
  if(frameCount>256*256){noLoop();println("STAHP");}
}
