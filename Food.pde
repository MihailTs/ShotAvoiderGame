class Food extends Walker{
 
  // 1-star, 2-shield, 3-2x, 4-heart
  int type;
  
  Food(int xD, int yD, int s){
    super(xD, yD, s);
    chooseType();
  }
  
  Food(int s){
    x = (int)random(1, (width-gridWidth)/gridWidth-1);
    y = (int)random(1, (height-gridWidth)/gridWidth-1);
    step = s;
    chooseType();
  }
  
  void chooseType(){
    float t = random(0, 50);
    if(t <= 45) type = 1;
    else if(t <= 47) type = 2;
    else if(t <= 49) type = 3;
    else type = 4;
  }
  
  @Override
  void show(){
   if(type == 1){
     stroke(250, 28, 8); strokeWeight(1); fill(246, 255, 15);
     star((x+0.5)*step, (y+0.5)*step, 6, 14, 5);}
   else if(type == 2){
     PImage img = loadImage("shield.png");
     image(img, (x)*step+7, (y)*step+5);}
   else if(type == 3){
     PImage img = loadImage("x2.png");
     image(img, (x)*step+5, (y)*step+5);
   }
   else {
     PImage img = loadImage("heart.png");
     image(img, (x)*step+5, (y)*step+8);
   }
  }

  private void star(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2;
    beginShape();
    for (float a = -PI/2; a < 3*PI/2; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
 }
 
}
