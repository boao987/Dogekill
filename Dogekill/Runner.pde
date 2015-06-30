class Runner {
  //VARIABLES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  final static int ATTACK =0;
  final static int DEAD = 1;

  float runposx;
  float runposy;
  int state;
  float health;
  float speedx;
  float speedy;
  float time;
  float dmg;

  //CONSTRUCTOR~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Runner() {
    dmg=10;
    health=100;
    time =20;
    runposx = random(300, 1025);
    runposy = random(height-900*5/4)+450*5/4;
    state = 0;
  }
  //STATE FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  //STATE 0~~~~~~~~~~~~~~~~~~~~~~
  void display() {
    if (state!=DEAD) {
      strokeWeight(4);
      stroke(255, 0, 0);
      fill(#790202);
      rect(runposx+30, runposy+10, -10, -20);
      rect(runposx+10, runposy+10, -10, -20);
      rect(runposx+20, runposy, 20, 10);
      rect(runposx+10, runposy, -20, 10);
      rect(runposx+10, runposy+20, -20, 10);
      rect(runposx+10, runposy+20, -10, 20);
      rect(runposx+20, runposy+20, 10, 20);
      rect(runposx+20, runposy+20, 20, 10);
      stroke(255, 0, 0);
      strokeWeight(3);
      fill(#E0FC2E);
      rect(runposx, runposy, 30, 30);
      fill(255);
      stroke(0);
      ellipse(runposx+15, runposy+15, 20, 20);
      fill(0);
      ellipse(runposx+15, runposy+15, 5, 5);
    }
  }

  void displayHealth() {
    stroke(255);
    strokeWeight(3);
    fill(255, 0, 0);
    rect(runposx-7.5, runposy-30, health*.5, 10);
  }

  void healthCheck() {
    if (health<=0) {
      state=DEAD;
      numEnemies--;
    }
  }
  void attack() {
    speedx = ((xcor-runposx-15)/time);
    speedy= ((ycor-runposy-15)/time);
    float speed = sqrt(speedx*speedx+speedy*speedy);
    speedx = (2*speedx)/speed;
    speedy = (2*speedy)/speed;
  }

  void move() {
    runposx += speedx;
    runposy += speedy;
    if (runposx <=100 || runposy >=width-100+10) {
      state = 0;
    }
    if (runposx <=50 || runposy  >=height-100+10) {
      state =0;
    }
  }
  //ACT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`  
  void act() {
    if (state == ATTACK) {
      healthCheck();
      display();
      attack();
      move();
      displayHealth();
    }
  }
}//END

