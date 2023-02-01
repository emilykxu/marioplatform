class FPlayer extends FGameObject {
  
int frame;
int direction;


  FPlayer() {
  
    super();
    setPosition(100, -100);
      frame = 0;
      direction = R;
    setFillColor(black);
    setRotatable(false);
    setName("player");
  }


  void act() {
    handInput();
    input();
    collisions();
    animate();
  }
  
  
  void animate(){
    if(frame >= action.length) frame = 0;
    if(frameCount % 5 == 0){
      if(direction == R) attachImage(action[frame]);
      if(direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
    
    
  }
  
  
  void input(){
    float vy = getVelocityY();
    float vx = getVelocityX();
    
    if(abs(vy) < 0.1 ){
      action = idle;
    }
    
    if(akey){
      setVelocity(-200, vy);
      action = run;
      direction = L;
      
    }
    
    if(dkey) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    if(wkey){
      setVelocity(vx, -250);
    }
    if(abs(vy) > 0.1)
     action = jump;
    
  }

void collisions(){
  if(isTouching("spike")){
    setPosition(0, 0);
  
}
}

  void handInput() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    
    
    
    if (akey) setVelocity(-200, vy);
    if (dkey) setVelocity(200, vy);
    if (wkey) setVelocity(vx, -200);
  }
   
}
