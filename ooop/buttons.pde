class Button {

  //instance variables
  int x, y, w, h;  //x, y is the center
  boolean clicked;
  color highlight, normal;
  String text;
  PImage img;

  //constructor
  Button(String t, int _x, int _y, int _w, int _h, color norm, color high) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    highlight = high;
    normal = norm;
    clicked = false;
    text = t;
  }

  Button(PImage pic, int _x, int _y, int _w, int _h, color norm, color high) {
    this("", _x, _y, _w, _h, norm, high);
    img = pic;
  }

  //Behaviour Functions
  void show() {
    drawBody();
    drawLabel();
    checkForClick();
  }

  void drawBody() {

    if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
      fill(highlight);
    } else {
      fill(normal);
    }
    stroke(0);
    strokeWeight(4);
    rect(x, y, w, h, 30);
  }


  void drawLabel() {
    textAlign(CENTER, CENTER);
    if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
      fill(normal);
    } else {
      fill(highlight);
    }
    if (img == null) {
      textSize(w/4);
      text(text, x, y);
    } else {
      image(img, x, y, w, h);
    }
  }

  void checkForClick() {
    if (mouseReleased && mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
      clicked  = true;
    } else {
      clicked = false;
    }
  }
}
