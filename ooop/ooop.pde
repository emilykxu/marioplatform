//Mario platform game
//Emily

import fisica.*;
FWorld world;


final int INTRO    = 0;
final int PLAY     = 1;
final int GAMEOVER = 2;
int mode;

//colours
color white = #FFFFFF;
color black = #000000;
color red = #ed1c23;
color yellow = #fff200;
color cyan = #00FFFF;
color green = #00FF00;
color brown = #FF9500;
color purple = #6f3198;
color pink = #ffa3b1;
color grey = #b4b4b4;
color lblue = #99d9ea;
color lorange = #ffc30e;
color lgreen = #a6e61d;



PImage map, ice, stone, treeTrunk, treeIntersect, treeMiddle, treeEndWest, treeEndEast, spike, bridge, trampoline, hammer;
int gridSize = 32;
float zoom = 1.5;
FPlayer player;
Button start;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, qkey, ekey, spacekey;
boolean mouseReleased;
boolean wasPressed;


//arrays
ArrayList<FGameObject> terrain;

ArrayList<FGameObject> enemies;

//
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] thwomp;
PImage []goomba;
PImage[] lava;
PImage[] hammerbro;


void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  size(600, 600);
  Fisica.init(this);
  terrain = new ArrayList <FGameObject>();
  enemies = new ArrayList<FGameObject>();
  loadImages();
  makeButtons();
  mode = 0;
}

void loadImages() {
  map = loadImage("pixilart-drawing (30).png");
  ice = loadImage("ice.png");
  stone = loadImage("stone.png");
  treeTrunk = loadImage("MicrosoftTeams-image (19).png");
  treeIntersect = loadImage("MicrosoftTeams-image (20).png");
  treeMiddle = loadImage("MicrosoftTeams-image (22).png");
  treeEndWest = loadImage("MicrosoftTeams-image (23).png");
  treeEndEast = loadImage("MicrosoftTeams-image (21).png");
  spike = loadImage("MicrosoftTeams-image (24).png");
  bridge = loadImage("MicrosoftTeams-image (7).png");
  trampoline = loadImage("MicrosoftTeams-image (35).png");
  hammer = loadImage("MicrosoftTeams-image (36).png");
  loadWorld(map);
  loadPlayer();

//load mario animations
  idle = new PImage[2];
  idle[0] = loadImage("MicrosoftTeams-image (25).png");
  idle[1] = loadImage("MicrosoftTeams-image (26).png");

  jump = new PImage[1];
  jump[0] = loadImage("MicrosoftTeams-image (27).png");

  run = new PImage[3];
  run[0] = loadImage("MicrosoftTeams-image (28).png");
  run[1] = loadImage("MicrosoftTeams-image (29).png");
  run[2] = loadImage("MicrosoftTeams-image (30).png");

  action = idle;


  //enemies
  goomba = new PImage[2];
  goomba[0] = loadImage("MicrosoftTeams-image (31).png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("MicrosoftTeams-image (32).png");
  goomba[1].resize(gridSize, gridSize);

  //thwomp
  thwomp = new PImage[2];
  thwomp[0] = loadImage("MicrosoftTeams-image (33).png");
  thwomp[1] = loadImage("MicrosoftTeams-image (34).png");

  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5] = loadImage("lava5.png");

  //hammer
  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("MicrosoftTeams-image (37).png");
  hammerbro[1] = loadImage("MicrosoftTeams-image (38).png");
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);


  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);// current pixel
      color s = img.get(x, y+1);// down of current pixel
      color w = img.get(x-1, y);
      color e = img.get(x+1, y);

      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) {//stone
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      } else if (c == grey) {
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      } else if (c == cyan) {//ice
        b.setFriction(0);
        b.attachImage(ice);
        b.setName("ice");
        world.add(b);
      } else if (c == brown) {//ice
        //  b.setFriction(0);
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("treeTrunk");
        world.add(b);
      } else if (c == green && s == brown) {//intersection
        b.attachImage(treeIntersect);
        // b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && w == green && e == green) {//intersection
        b.attachImage(treeMiddle);
        // b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && w != green) {//intersection
        b.attachImage(treeEndWest);
        // b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && e != green) {//intersection
        b.attachImage(treeEndEast);
        // b.setSensor(true);
        b.setName("treetop");
        world.add(b);
      } else if (c == purple) {//intersection
        b.attachImage(spike);
        // b.setSensor(true);
        b.setName("spike");
        world.add(b);
      } else if (c == pink) {//intersection
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == lblue) {
        FThwomp tmp = new FThwomp(x*gridSize, y*gridSize);
        enemies.add(tmp);
        world.add(tmp);
      } else if (c == lorange) {
        FLava l = new FLava(x*gridSize, y*gridSize);
        terrain.add(l);
        world.add(l);
      } else if (c == lgreen) {
        FHammerBro hmb = new FHammerBro(x*gridSize, y*gridSize);
        enemies.add(hmb);
        world.add(hmb);
      } else if (c == red) {
        b.attachImage(trampoline);
        b.setVelocity(x, -800);
        b.setName("trampoline");
        world.add(b);
      }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  background(white);
  //drawWorld();
  //actWorld();

  click();
  if (mode == INTRO) {
    intro();
  } else if (mode == PLAY) {
    play();
  } else if (mode == GAMEOVER) {
    gameOver();
  }
}

void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }

  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();

  popMatrix();
}

void makeButtons() {
  //INTRO - Start
  start = new Button("START", width/2, 3*height/4, 200, 100, white, black);

  //PLAY - Next Wave, To Build Mode

  //BUILD - To play mode, Buy Sniper, Buy Gun, Buy AoE

  //GAMEOVER - Reset
}
