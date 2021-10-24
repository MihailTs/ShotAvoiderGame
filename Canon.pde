class Canon{
   
  int x;
  float y;
  float speed;
  int step;
  int up, down;
  // l - left side, r - right side
  char side;
  int aim;
  ArrayList<Shot> shots = new ArrayList<Shot>();
  
  Canon(char s, float ypos, int stp, int u, int d){
    step = stp;
    side = s;
    up = u; down = d;
    x = side == 'l'? 0 : width/step-1;
    y = ypos;
    speed = 0.06;
    target();
  }
  
  void show(){
       PImage img = loadImage(side=='l'? "canonL.png" : "canonR.png");
       image(img, x*step+7, y*step+7);
       for(Shot s: shots) {s.show(); s.move();}
  }
  
  void execute(float fr){
    show();
    shoot(fr);
    removeShots();
  }
  
  void target(){
    int target = 0;
     do{
      target = int(random(up, down));
     } while(aim == target);
      aim = target;
  }
  
  void shoot(float fr){
     if(round(y) > aim) y -= speed*fr;
     else if(round(y) < aim) y += speed*fr; 
     if(round(y) == aim){
       shots.add(new Shot((side == 'l'? 0: width/step-1), aim, step, (side == 'l'? 1: -1)));
       target();
     }
  }
  
  //Removes all but the last 10 shots
  void removeShots(){
    if(shots.size() > 10)
      shots.remove(0);
  }
  
}
