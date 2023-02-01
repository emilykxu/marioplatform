class FHammerBro extends FGameObject {

  int frame = 0;
  int moveTimer = 100;
  int speed = 10;
  int direction = -1;

  FHammerBro(float _x, float _y) {
    setPosition(_x, _y);
    setName("hammerbro");
    setRotatable(false);
  }


  void act() {
    animate();
    collide();
    move();
    hammer();
  }


  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }

  void hammer() {
    if (frameCount % 150 == 0) {
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(getX(), getY() - 20);
      b.attachImage(hammer);
      b.setSensor(true);
      b.setVelocity(-100 *direction, -600);
      b.setAngularVelocity(50);
      b.setName("hammer");
      world.add(b);
    }
  }
  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX()+direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        player.setPosition(0, 0);
      }
    }
  }
  void animate() {
    if (frame >= hammerbro.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(hammerbro[frame]);
      if (direction == L) attachImage(reverseImage(hammerbro[frame]));
      frame++;
    }
  }
}
