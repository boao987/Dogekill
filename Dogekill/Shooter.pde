class Shooter {
  //VARIABLES~~~~~~~~~~~~~~~~~~~~~~~~`
  final static int MOVE=0;
  final static int DEAD=1;

  color c = color(255, 0, 0);
  float shoxcor;
  float shoycor;
  float size;
  float health;
  float speedx;
  float speedy;
  float tarxcor;
  float tarycor;
  float time;
  boolean shooterfire;
  int state;

  //CONSTRUCTOR~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
  Shooter() {
    health=100;
    state=0;
    shooterfire=false;
    shoxcor=random(300,1025); 
    shoycor=random(height-900*5/4)+450*5/4;
    tarxcor=random(width-200)+100;
    tarycor=random(height-900*5/4)+450*5/4;
    size = 30;
    time=20;
  }
  //STATE FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //STATE 0~~~~~~~~~~~~~~~~~~~~~~~~
  void display() {
    strokeWeight(2);
    stroke(255, 0, 0);
    fill(#FF0000);
    ellipse(shoxcor, shoycor, 10, 10);
    fill(#E0FC2E);
    ellipse(shoxcor-15, shoycor+10, 10, 10);
    ellipse(shoxcor+15, shoycor+10, 10, 10);
    ellipse(shoxcor-10, shoycor, 10, 10);
    ellipse(shoxcor+10, shoycor, 10, 10);
    ellipse(shoxcor-20, shoycor, 10, 10);
    ellipse(shoxcor+20, shoycor, 10, 10);
    ellipse(shoxcor-5, shoycor-10, 10, 10);
    ellipse(shoxcor+5, shoycor-10, 10, 10);
    ellipse(shoxcor-15, shoycor-10, 10, 10);
    ellipse(shoxcor+15, shoycor-10, 10, 10);
    ellipse(shoxcor, shoycor-20, 10, 10);
    ellipse(shoxcor, shoycor-30, 10, 10);
  }

  void displayHealth() {
    stroke(255);
    strokeWeight(3);
    fill(255, 0, 0);
    rect(shoxcor-20, shoycor-35, health*.5, 10);
  }

  void healthCheck() {
    if (health<=0) {
      state=DEAD;
      numEnemies--;
    }
  }
  
  void rot() {
    //println(shoxcor);
    PVector v1 = new PVector(0, 1);
    PVector v2;
    pushMatrix();
    float rot;
    if (xcor<=shoxcor) {
      v2 = new PVector(xcor-shoxcor, ycor-shoycor);
      rot =PVector.angleBetween(v1, v2);
    } else {
      v2 = new PVector(shoxcor-xcor, shoycor-ycor);
      rot = PVector.angleBetween(v1, v2) +PI;
    }
    translate(shoxcor, shoycor);
    rotate(rot);
    translate(-shoxcor, -shoycor);
    display();
    popMatrix();
  }

  void evade() {
    speedx = ((tarxcor-shoxcor-15)/time);
    speedy= ((tarycor-shoycor-15)/time);
    float speed = sqrt(speedx*speedx+speedy*speedy);
    speedx = (2*speedx)/speed;
    speedy = (2*speedy)/speed;
  }

  void move() {
    shoxcor += speedx;
    shoycor += speedy;
    if (dist(tarxcor, tarycor, shoxcor, shoycor)<25) {
      // println(dist(tarxcor, tarycor, shoxcor, shoycor));
      tarxcor=random(width-200)+100;
      tarycor=random(height-900*5/4)+450*5/4;
    }    
    //    if (shoxcor <=100 || shoycor >=width-100+10) {
    //      state = 0;
    //    }
    //    if (shoxcor <=50 || shoycor  >=height-100+10) {
    //      state =0;
    //    }
  }

  void act() {
    if (state==MOVE) {
      healthCheck();
      rot();
      evade();
      move();
      displayHealth();
      //     println(state==MOVE);
    }
  }
  //COLLISIONS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
  boolean isTouching (Shooter u) {
    return !(shoxcor > u.shoxcor+u.size || shoxcor+size < u.shoxcor 
      || shoycor > u.shoycor+u.size || shoycor+size < u.shoycor);
  }
}//END

