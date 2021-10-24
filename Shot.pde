class Shot{
  
  float x;
  int y;
  int step;
  int dir;
  
  Shot(float xD, int yD, int s, int d){
    x = xD;
    y = yD;
    step = s;
    dir = d;
  }
  
 void show(){
    if(x >= 1 && x <= width/step-1){
    fill(255, 0, 0); stroke(20);
    rect(floor(x)*step, y*step, step, step); }
 }
  
 void move(){
    x += dir*0.1; 
 }
   
}
