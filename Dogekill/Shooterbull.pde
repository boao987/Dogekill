class Shooterbull {
  //VARIABLES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final static int DEAD  = 0;
  final static int  SHOT  = 1;

  float size =10;
  float time;
  float sbxcor;
  float sbycor;
  color clr;
  float speedx;
  float speedy;
  int state;
  //CONSTRUCTOR~~~~~~~~~~~~~~~~~~~
  Shooterbull () {
    speedx=0;
    speedy=0;
    state=0;
    time=20;
  }
  //STATE FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
  
  //STATE 0~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  void display() {
    stroke(255);
    fill (#4D0B67);
    ellipse(sbxcor, sbycor, size, size);
  }

  void move() {
    sbxcor += speedx;
    sbycor += speedy;
    if (sbxcor <=100 || sbxcor >=width-100+10) {
      state = 0;
    }
    if (sbycor <=50 || sbycor  >=height-100+10) {
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
    float circleDistanceX = abs(sbxcor - h.x - h.w/2);
    float circleDistanceY = abs(sbycor - h.y - h.h/2);
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
  
  boolean isTouchingHero(Hero h) {
    float circleDistanceX = abs(sbxcor - xcor - 15);
    float circleDistanceY = abs(sbycor - ycor - 15);
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

}//END

