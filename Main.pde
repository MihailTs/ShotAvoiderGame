final int gridWidth = 40;

Walker walker;
Food food;
Canon leftCanon, rightCanon;

int score = 0; int bestScore = 0;
int x2Count = -1; int shieldCount = -1;

void setup(){
  size(720, 880);
  
  walker = new Walker(7, 1, gridWidth);
  food = new Food((int)random(0, (width-gridWidth)/gridWidth-1), (int)random(0, (height-gridWidth)/gridWidth-1), gridWidth);
  
  leftCanon = new Canon('l', 5, gridWidth, 1, (height/gridWidth)-1);
  rightCanon = new Canon('r', 5, gridWidth, 1, (height/gridWidth)-1);
  
}


void draw(){
  background(230, 230, 240);
  
  // if you are still alive
  if(walker.hearts > 0){
  
  showGrid(gridWidth);
  
  //Show the score
  score();
  hearts();
  //
  
  //Check if the shield and x2 are working
  shieldCount--;
  if(shieldCount == -1) walker.shield = false;
  
  if(x2Count == -1) {
    leftCanon.execute(1);
    rightCanon.execute(1);
  } else{
    leftCanon.execute(0.5);
    rightCanon.execute(0.5);
    x2Count--;
  }
  //
  
  food.show();
  
  // when you eat the food
  if(walker.eats(food)) {
    if(food.type == 1) {
      score++;
      if(score % 10 == 0) {leftCanon.speed += 0.04; rightCanon.speed += 0.04;} 
    }
    else if(food.type == 2) {walker.shield = true; shieldCount = 5*round(frameRate);}
    else if(food.type == 4 && walker.hearts < 3) walker.hearts++;
    else if(food.type == 3) x2Count = 5*round(frameRate);
    food = new Food(gridWidth);
  }
  //
  walker.show();
  
  for(Shot shot: leftCanon.shots)
    if(round(shot.x) == walker.x && shot.y == walker.y){
       if(!walker.shield) walker.hearts--; 
    }
  for(Shot shot: rightCanon.shots)
    if(round(shot.x) == walker.x && shot.y == walker.y){
       if(!walker.shield) walker.hearts--; 
    }

  }
  // if dead
  else{
    playAgain();
    exitGame();
    textSize(30); fill(174, 53, 250);
    text("SCORED: ", width/2-100, 380); 
    text(score, width/2+40, 380);
     
    if(score > bestScore) bestScore = score;
     
    textSize(30);
    text("BEST: ", width/2-100, 430); 
    text(bestScore, width/2-10, 430);
    
    PImage shl = loadImage("shield.png");
    image(shl, width/2-220, 575);
    textSize(20); fill(0);
    text("Makes you immune to shots for 5 seconds", width/2-170, 600); 
    
    PImage x2 = loadImage("x2.png");
    image(x2, width/2-220, 625);
    textSize(20); fill(0);
    text("Slows down the cannon speed for 5 seconds", width/2-170, 650); 
    
    PImage hrt = loadImage("heart.png");
    image(hrt, width/2-220, 675);
    textSize(20); fill(0);
    text("Gives you extra heart", width/2-170, 700); 
  }
  
}

void showGrid(int w){
  for(int i = w; i <= height-w; i += w){
    stroke(160); strokeWeight(1);
    line(w, i, width-w, i);}
  
  for(int i = w; i <= width-w; i += w){
    stroke(160); strokeWeight(1);
    line(i, w, i, height-w);}
    
   stroke(120); strokeWeight(3);
   line(w, w, w, height-w);
   line(width-w, w, width-w, height-w);
   line(w, w, width-w, w);
   line(w, height-w, width-w, height-w);
}

void keyReleased(){
   if(keyCode == UP) {delay(70); walker.move(0, -1);}
   else if(keyCode == DOWN) {delay(70); walker.move(0, 1);}
   else if(keyCode == LEFT) {delay(70); walker.move(-1, 0);}
   else if(keyCode == RIGHT) {delay(70); walker.move(1, 0);}
}

void score(){
   textSize(30); fill(147, 26, 234);
   text("SCORE: ", 450, 30); 
   fill(157, 26, 245);
   text(score, 570, 30);
   
   if(score > bestScore) bestScore = score;
}

void hearts(){
  for(int i = 1; i <= walker.hearts; i++){
      PImage img;
      img = loadImage("heart.png");
      image(img, i*45, 10);
  }
}

void playAgain(){
  stroke(30); strokeWeight(3); noFill();
  if(mouseX >= width/2-100 && mouseX <= width/2+100 && mouseY >= 200 && mouseY <= 250) fill(20, 255, 30);
  rect(width/2-100, 200, 200, 50);
  textSize(35); fill(20);
  text("Play again", width/2-85, 235);
}

void exitGame(){
  stroke(30); strokeWeight(3); noFill();
  if(mouseX >= width/2-100 && mouseX <= width/2+100 && mouseY >= 270 && mouseY <= 320) fill(255, 20, 30);
  rect(width/2-100, 270, 200, 50);
  textSize(35); fill(20);
  text("Exit", width/2-32, 308);
}

void mouseReleased(){
  if(walker.hearts <= 0 && mouseX >= width/2-100 && mouseX <= width/2 + 100 && mouseY >= 200 && mouseY <= 250) {
    score = 0;
    walker = new Walker(7, 1, gridWidth);
    food = new Food((int)random(0, (width-gridWidth)/gridWidth-1), (int)random(0, (height-gridWidth)/gridWidth-1), gridWidth);
  
    leftCanon = new Canon('l', 5, gridWidth, 1, (height/gridWidth)-1);
    rightCanon = new Canon('r', 5, gridWidth, 1, (height/gridWidth)-1);  
  }
  
  if(walker.hearts <= 0 && mouseX >= width/2-100 && mouseX <= width/2+100 && mouseY >= 270 && mouseY <= 320) 
    exit();
  
}
