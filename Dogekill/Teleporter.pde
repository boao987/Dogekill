class Teleporter {

  final static int INACTIVE=0;
  final static int ACTIVATED=1;

  int state;
  float txcor;
  float tycor;
  float size;

  Teleporter() {
    txcor=random(width-200)+100;
    tycor=random(height-900*5/4)+450*5/4;
    size = 50;
  }

  void display() {
    if (state==INACTIVE) {
      fill(255, 0, 0);
      strokeWeight(3);
      stroke(255);
      ellipse(txcor, tycor, 50, 50);
      line(txcor-25, tycor, txcor+25, tycor);
      line(txcor, tycor-25, txcor, tycor+25);
    } else if (state==ACTIVATED) {
      fill(0, 0, 255);
      strokeWeight(3);
      stroke(255);
      ellipse(txcor, tycor, 50, 50);
      line(txcor-25, tycor, txcor+25, tycor);
      line(txcor, tycor-25, txcor, tycor+25);
    }
  }

  boolean Touch(Hero h) {
    if (abs(xcor-txcor)<30&&abs(ycor-tycor)<30&&state==ACTIVATED) {
      return true;
    } else {
      return false;
    }
  }
}

