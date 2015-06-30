class Bullets {
  //VARIABLES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final static int DEAD  = 0;
  final static int  SHOT  = 1;
  
  float size =10;
  float time;
  float xcor;
  float ycor;
  color clr;
  float speedx;
  float speedy;
  int state;
  
  //CONSTRUCTOR~~~~~~~~~~~~~~~~~~~
  Bullets () {
    speedx=0;
    speedy=0;
    state=0;
    time=20;
  }
  //STATE FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
  //STATE 0~~~~~~~~~~~~~~~~~~~~~~~~~~
  void display() {
    noStroke();
    clr = color(random(255), random(255), random(255));
    fill (clr);
    ellipse(xcor, ycor, size, size);
  }

  void move() {
    xcor += speedx;
    ycor += speedy;
    if (xcor <=100 || xcor >=width-100+10) {
      state = 0;
    }
    if (ycor <=50 || ycor  >=height-100+10) {
      state =0;
    }
  }
  
//  void die(){
//    speedx=0;
//    speedy=0;
//    xcor=0;
//    ycor=0;
//    size=0;
//  }
  //ACT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
  void act() {
    if ( state == DEAD ) {
    } else if ( state == SHOT ) {
      display();
      move();
    }
  }

  //COLLISIONS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
  boolean isTouchingCrate(Crate h) {
    float circleDistanceX = abs(xcor - h.x - h.w/2);
    float circleDistanceY = abs(ycor - h.y - h.h/2);
    if (circleDistanceX > (h.w/2 + size/2)) { 
      return false;
    }
    if (circleDistanceY > (h.h/2 + size/2)) { 
      return false;
    }
    if (circleDistanceX <= (h.w/2)) { 
      return true;
    }
    if (circleDistanceY <= (h.h/2)) { 
      return true;
    }
    float cornerDistance_sq = pow(circleDistanceX - h.w/2, 2) +
      pow(circleDistanceY - h.h/2, 2);
    return (cornerDistance_sq <= pow(size/2, 2));
  }
  
  boolean isTouchingRunner(Runner r) {
    float circleDistanceX = abs(xcor - r.runposx - 15);
    float circleDistanceY = abs(ycor - r.runposy - 15);
    if (circleDistanceX > (15 + size/2)) { 
      return false;
    }
    if (circleDistanceY > (15 + size/2)) { 
      return false;
    }
    if (circleDistanceX <= (15)) { 
      return true;
    }
    if (circleDistanceY <= (15)) { 
      return true;
    }
    float cornerDistance_sq = pow(circleDistanceX - 15, 2) +
      pow(circleDistanceY - 15, 2);
    return (cornerDistance_sq <= pow(size/2, 2));
  }
  
  boolean isTouchingShooter(Shooter s) {
    float circleDistanceX = abs(xcor - s.shoxcor);
    float circleDistanceY = abs(ycor - s.shoycor);
    if (circleDistanceX > (30 + size/2)) { 
      return false;
    }
    if (circleDistanceY > (30 + size/2)) { 
      return false;
    }
    if (circleDistanceX <= (30)) { 
      return true;
    }
    if (circleDistanceY <= (30)) { 
      return true;
    }
    float cornerDistance_sq = pow(circleDistanceX - 30, 2) +
      pow(circleDistanceY - 30, 2);
    return (cornerDistance_sq <= pow(size/2, 2));
  }

}//END

