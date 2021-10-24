class Walker{
  
  int x, y;
  int step;
  boolean shield;
  color appearance;
  int hearts = 1;
  
  Walker(int xD, int yD, int s){
    x = xD+1;
    if(xD < 0) x = 1;
    y = yD+1;
    if(yD < 0) y = 1;
    step = s;
    shield = false;
    appearance = color(random(30,200), random(30,200), random(30, 200));
  }
  
  Walker(){
   x = 0; y = 0; 
  }
  
  void show(){
     fill(appearance);
     if(!shield) noStroke();
     else{ stroke(0); strokeWeight(3);}
     rect(x*step, y*step, step, step, 255); 
  }

  final void move(int d1, int d2){
       if(x > 1 && d1 < 0) x += d1; 
       else if(x < (width-step)/step-1 && d1 > 0) x += d1;
    
       if(y > 1 && d2 < 0) y += d2;
       else if(y < (height-step)/step-1 && d2 > 0) y += d2;
  }
  
  boolean eats(Walker Food){
    return Food.x == x && Food.y == y;
  }  
  
}
