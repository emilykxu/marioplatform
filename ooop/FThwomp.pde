class FThwomp extends FGameObject {

int frame = 0;
  int direction = L;

  FThwomp(float x, float y) {
    super(64, 64);
    setPosition(x+gridSize/2, y+gridSize/2);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
  }



  void act() {
    if (player.getX() >= this.getX() - 10 && player.getX() <= this.getX() + 10) {
      setStatic(false);
    }
    collide();
    animate();
  }


void animate() {
    if (frame >= thwomp.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(thwomp[frame]);
      if (direction == L) attachImage(reverseImage(thwomp[frame]));
      frame++;
    }
}

void collide() {
    if (isTouching("player")) {
      player.setPosition(1800, 0);
    }
  }
  
}
