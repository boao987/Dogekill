class Crate {
  //VARIABLES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final static int STILL=0;
  final static int DEAD=1;
  float x;
  float y;
  int state = 0;
  float w;
  float h;

  float health;
  //CONSTRUCTOR~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Crate() {
    health=100;
    w=random(30)+20;
    h=random(30)+20;
    x=random(width-w-200)+100;
    y=random(height-h-900*5/4)+450*5/4;
  }
  //STATE FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //STATE 0~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void display() {
    if (state!=DEAD) {
      stroke(255);
      strokeWeight(2);
      fill(#580107);
      rect(x, y, w, h);
      fill(#020A36);
      if (w>h) {
        rect(x+(w/4), y, w/8, h);
        rect(x+(w*5/8), y, w/8, h);
      } else {
        rect(x, y+(h/4), w, h/8);
        rect(x, y+(h*5/8), w, h/8);
      }
    }
  }

  void healthCheck() {
    if (health<=0) {
      state=DEAD;
    }
  }

  void displayHealth() {
    stroke(255);
    strokeWeight(3);
    fill(255, 0, 0);
    rect(x-5, y-25, health*.5, 10);
  }
  //ACT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void act() {
    healthCheck();
    if (state==STILL) {
      display();
      displayHealth();
    } else if (state==DEAD) {
      w=0;
      h=0;
    }
  }
  //COLLISIONS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  boolean isTouching(Crate u) {
    return !(x > u.x+u.w || x+w < u.x 
      || y > u.y+u.h || y+h < u.y);
  }
}//END

