class Hero {
  //VARIABLES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final static int Qsize=30;
  final static float DEFAULT_STEP=5;
  final static int LIVE=0;
  final static int DEAD=1;

  boolean stuck;
  float health;
  float standx;
  float standy;
  float step;
  int state=0;
  //CONSTRUCTOR~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Hero() {
    health = 300;
    standx=random(width-200)+100;
    standy=random(height-900*5/4)+450*5/4;
    step=DEFAULT_STEP;
  }
  //STATE FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //STATE 0~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void move() {
    if (keyPressed) {
      if (key=='w' || key=='W') {
        ycor-=step;
        if (touchingWall()||hroCrateColl()) {
          ycor+=step;
        }
      } else if (key=='s' || key=='S') {
        ycor+=step;
        if (touchingWall()||hroCrateColl()) {
          ycor-=step;
        }
      } else if (key=='a' || key=='A') {
        xcor-=step;
        if (touchingWall()||hroCrateColl()) {
          xcor+=step;
        }
      } else if (key=='d' || key=='D') {
        xcor+=step;
        if (touchingWall()||hroCrateColl()) {
          xcor-=step;
        }
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
    rect(xcor-25, ycor-35, health*.5, 10);
  }

  void display(int x, int y) {
    standx = x+15;
    standy = y+15;
    stroke(255);
    strokeWeight(2);
    fill(#0AFAE8);
    rect(standx, standy, Qsize, Qsize);
    fill(#422FC1);
    rect(standx+30, standy+5, Qsize-20, Qsize);
    rect(standx-10, standy+5, Qsize-20, Qsize);
    fill(#0091F0);
    rect(standx+5, standy+5, Qsize-10, Qsize-10);
    rect(standx+7.5, standy+30, Qsize-15, Qsize-15);
  }

  //ROTATE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
  void rot() {
    PVector v1 = new PVector(0, 1);
    PVector v2;
    pushMatrix();
    float rot;
    if (mouseX<=xcor) {
      v2 = new PVector(mouseX-xcor, mouseY-ycor);
      rot =PVector.angleBetween(v1, v2);
    } else {
      v2 = new PVector(xcor-mouseX, ycor-mouseY);
      rot = PVector.angleBetween(v1, v2) +PI;
    }
    translate(xcor, ycor);
    rotate(rot);
    hro.display(-30, -30);
    popMatrix();
  }

  //ACT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  void act() {
    healthCheck();
    if (state==LIVE) {
      move();
      rot();
      displayHealth();
      hroShoot();
    } else {
    }
  }

  //COLLISIONS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  boolean touchingRunner(Runner r) {
    return !(xcor+30 < r.runposx+30 || xcor-30 > r.runposx 
      || ycor+30 < r.runposy+30 || ycor-30 > r.runposy);
  }

  boolean touchingCrate(Crate u) {
    return !(xcor-30 > u.x+u.w || xcor+30 < u.x 
      || ycor-30 > u.y+u.h || ycor+30 < u.y);
  }

  boolean touchingWall() {
    return (ycor+Qsize/2>height-100)||(ycor-30<50)
      ||(xcor-30<100)||(xcor+30>width-100);
  }
}//END

