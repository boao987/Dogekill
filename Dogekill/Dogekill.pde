//SETTINGS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int lvl=0;
float screenWidth=1000;
float screenHeight=450*5/4;
int numCrates = 4;
int frameNum=0;

//START~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
color c = 255;
color many0 = color(random(255), random(255), random(255));
color many1 = color(random(255), random(255), random(255));
color many2 = color(random(255), random(255), random(255));
color many3 = color(random(255), random(255), random(255));
color many4 = color(random(255), random(255), random(255));
color many5 = color(random(255), random(255), random(255));
color back;

//ENEMIES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int numShooters=10;
int numRunners=5;
int numEnemies=numRunners+numShooters;

//BULLETS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
final static int NUMBULL = 75;
boolean fire;
int bullnum = 0;
float dmg=50;

final static int NUMSHOBULL=1000;
//boolean shooterfire;
int shobullnum=0;
float shodmg=1;

//CHARACTERS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
float xcor = 300;
float ycor = 300;

//DECLARATION~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Bullets[] bullets;
Shooterbull[] shobulls;
Crate[] crates;
Runner[] runners;
Shooter[] shooters;
Hero hro;
Teleporter tele;

//DRIVERS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void setup() {
  size(1200, 700);
  makeRoom();
  initialize();
}

void draw() {
  //frameRate(10);
  background(0);
  frameNum++;
  if (lvl==0) {
    start();
  } else if (hro.state==Hero.LIVE) {
    display();
    hro.act();
    enemFire();
    hroColl();
    bulletColl();
    if (keyPressed) {
      if (key==' ') {
        hroShootSet();
      }
    }
//   
    if (tele.Touch(hro)) {
      initialize();
    }
  }
  if (hro.state==Hero.DEAD) {
    end();
  }
}

void end() {
  strokeWeight(35);
  if (mouseX>=350&&mouseX<=850&&mouseY>400&&mouseY<600) {
    stroke(100);
    fill(#7E8E09);
  } else {
    stroke(255);
    fill(#204804);
  }
  rect(350, 400, 500, 200);
  fill(255, 0, 0);

  PFont funt;
  funt=loadFont("Purisa-Bold-48.vlw");
  textFont(funt, 150);
  text("You Have Died...", 0, 350);
  textSize(50);
  text("Restart...", 475, 510);
}

void mouseClicked() {
  if (lvl==0&&mouseX>=350&&mouseX<=850&&mouseY>400&&mouseY<600) {
    lvl++;
  } else if (hro.state==Hero.LIVE) {
    hroShootSet();
    //shoShootSet();
  }
  if (hro.state==Hero.DEAD&&mouseX>=350&&mouseX<=850&&mouseY>400&&mouseY<600) {
    lvl=0;
    initialize();
  }
}

//FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//INIT FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void initialize() {
  initCrates();
  initShooters();
  initBullets();
  initShooterbulls();
  initRunners();
  tele = new Teleporter();
  hro=new Hero();
  back=color(random(100), random(100), random(100));
  numEnemies=numRunners+numShooters;
}

void initCrates() {  
  crates = new Crate[numCrates];
  for (int i=0; i<numCrates; i++) {
    crates[i]=new Crate();
  }
}

void initShooters() {
  shooters=new Shooter[numShooters];
  for (int i=0; i<numShooters; i++) {
    shooters[i]=new Shooter();
  }
}

void initShooterbulls() {
  shobulls=new Shooterbull[NUMSHOBULL];
  for (int i=0; i<NUMSHOBULL; i++) {
    shobulls[i]=new Shooterbull();
  }
}

void initBullets() {
  bullets = new Bullets[NUMBULL];
  for (int i =0; i<NUMBULL; i++) { 
    bullets[i] = new Bullets();
  }
}

void initRunners() {
  runners = new Runner[numRunners];
  for (int i =0; i<numRunners; i++) { 
    runners[i] = new Runner();
  }
}

//MAKE FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void display() {
  makeRoom();
  makeTeleporter();
  makeCrates();
  makeShooters();
  makeRunners();
}

void makeRoom() {
  background(0);
  stroke(255);
  strokeWeight(3);
  fill(back);
  rect(100, 50, 1000, 450*5/4);
  stroke(100);
  line(random(width-200)+100, random(height-900*5/4)+450*5/4, 
  random(width-200)+100, random(height-900*5/4)+450*5/4);
}

void makeCrates() {
  for ( int p=0; p < numCrates; p++ ) {
    for ( int j=p+1; j < numCrates; j++ ) {
      if ( crates[p].isTouching( crates[j] )||hroCrateColl()) {
        crates[p].state=Crate.DEAD;
      }
    }
  }
  for (int i=0; i<numCrates; i++) {
    crates[i].act();
  }
}

void makeShooters() {
  //  for ( int p=0; p < numShooters; p++ ) {
  //    for ( int j=p+1; j < numShooters; j++ ) {
  //      if ( shooters[p].isTouching (shooters[j] ) ) {
  //        shooters[p].state=Shooter.DEAD;
  //      }
  //    }
  //  }
  for (int i=0; i<numShooters; i++) {
    shooters[i].act();
  }
}

void makeTeleporter() {
  if (numEnemies<=0) {
    tele.state=Teleporter.ACTIVATED;
  }
  tele.display();
}

void makeRunners() {
  //  for ( int p=0; p < numRunners; p++ ) {
  //    for ( int j=p+1; j < numRunners; j++ ) {
  //      if ( runners[p].isTouching (runners[j] ) ) {
  //        runners[p].state=Runner.DEAD;
  //      }
  //    }
  //}
  for (int i=0; i<numRunners; i++) {
    runners[i].act();
  }
}

//HERO FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void hroShootSet() {
  fire =true;
  bullnum=((bullnum+1)%NUMBULL);
}

void hroShoot() {
  if (fire == true) {
    bullets[bullnum].state = 1;
    bullets[bullnum].xcor = xcor;
    bullets[bullnum].ycor = ycor;
    bullets[bullnum].speedx = ((mouseX-xcor-15)/bullets[bullnum].time);
    bullets[bullnum].speedy= ((mouseY-ycor-15)/bullets[bullnum].time);
    float speed = sqrt(bullets[bullnum].speedx*bullets[bullnum].speedx+bullets[bullnum].speedy*bullets[bullnum].speedy);
    bullets[bullnum].speedx = (10*bullets[bullnum].speedx)/speed;
    bullets[bullnum].speedy = (10*bullets[bullnum].speedy)/speed;
    fire =false;
  }
  for ( int i = 0; i <NUMBULL; i++ ) {
    bullets[i].act();
  }
}

//ENEMYSHOOT FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void enemFire() {
  shoFire();
  shoShoot();
}

void shoFire() {
  shoShootSet();
}

void shoShootSet() {
  for (int i=0; i<numShooters; i++) {
    if ((int)random(10)==1) {
      shooters[i].shooterfire =true;
    }
    shobullnum=((shobullnum+1)%NUMSHOBULL);
  }
}

void shoShoot() {
  int i=frameNum % numShooters;
  //for (int i=0; i<numShooters; i++) {
  //    println(shooters[0].state==MOVE);
  if (shooters[i].state==Shooter.MOVE) {
    //      println(frameNum);
    shoShootHelp(shooters[i]);
    //    println(i);
    //println(numShooters);
  }
  for ( int j = 0; j <NUMSHOBULL; j++ ) {
    //println(shobulls[i].state);
    shobulls[j].act();
  }
}
//}

void shoShootHelp(Shooter s) {
  //  println(shooterfire);
  if (s.shooterfire == true) {
    //   println(shobullnum);
    shobulls[shobullnum].state = Shooterbull.SHOT;
    shobulls[shobullnum].sbxcor = s.shoxcor;
    shobulls[shobullnum].sbycor = s.shoycor;
    //println(s.shoxcor);
    shobulls[shobullnum].speedx = ((xcor-s.shoxcor-15)/shobulls[shobullnum].time);
    shobulls[shobullnum].speedy= ((ycor-s.shoycor-15)/shobulls[shobullnum].time);
    float speed = sqrt(shobulls[shobullnum].speedx*shobulls[shobullnum].speedx+shobulls[shobullnum].speedy*shobulls[shobullnum].speedy);
    shobulls[shobullnum].speedx = (5*shobulls[shobullnum].speedx)/speed;
    shobulls[shobullnum].speedy = (5*shobulls[shobullnum].speedy)/speed;
    // s.shooterfire =false;
  }
}


//COLLISION FXNS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void hroColl() {
  hroRunnerColl();
}

void bulletColl() {
  bulletCrateColl();
  bulletRunnerColl();
  bulletShooterColl();
  shoBulletCrateColl();
  shoBulletHeroColl();
}


boolean hroCrateColl() {
  boolean ans=false;
  for (int i=0; i<numCrates; i++) {
    if (ans==false) {
      ans = (crates[i].state==Crate.STILL && hro.touchingCrate(crates [i]));
    }
  }
  return ans;
}

void hroRunnerColl() {
  for (int i=0; i<numRunners; i++) {
    if (hro.touchingRunner(runners[i])&&runners[i].state==Runner.ATTACK) {
      hro.health-=runners[i].dmg;
      runners[i].state=Runner.DEAD;
    }
  }
}

void bulletCrateColl() {
  for ( int p=0; p < NUMBULL; p++ ) {
    for ( int j=0; j < numCrates; j++ ) {
      if ( bullets[p].isTouchingCrate(crates[j])&&crates[j].state==Crate.STILL ) {
        crates[j].health-=dmg;
        bullets[p].state=0;
      }
    }
  }
}

void bulletRunnerColl() {
  for ( int p=0; p < NUMBULL; p++ ) {
    for ( int j=0; j < numRunners; j++ ) {
      if ( bullets[p].isTouchingRunner(runners[j])&&runners[j].state==Runner.ATTACK&&bullets[p].state==Bullets.SHOT ) {
        runners[j].health-=dmg;
        bullets[p].state=Bullets.DEAD;
      }
    }
  }
} 

void bulletShooterColl() {
  for ( int p=0; p < NUMBULL; p++ ) {
    for ( int j=0; j < numShooters; j++ ) {
      if ( bullets[p].isTouchingShooter(shooters[j])&&shooters[j].state==Shooter.MOVE&&bullets[p].state==Bullets.SHOT ) {
        shooters[j].health-=dmg;
        //numshooters
        bullets[p].state=Bullets.DEAD;
      }
    }
  }
} 


void shoBulletCrateColl() {
  for ( int p=0; p < NUMSHOBULL; p++ ) {
    for ( int j=0; j < numCrates; j++ ) {
      if ( shobulls[p].isTouchingCrate(crates[j])&&crates[j].state==Crate.STILL ) {
        crates[j].health-=shodmg;
        shobulls[p].state=0;
      }
    }
  }
}

void shoBulletHeroColl() {
  for ( int p=0; p < NUMSHOBULL; p++ ) {
    if ( shobulls[p].isTouchingHero(hro)&&hro.state==Hero.LIVE ) {
      hro.health-=shodmg;
      shobulls[p].state=0;
    }
  }
}

//START MENU~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void start() {
  PFont font;
  fill(c);
  rect(350, 400, 500, 200); 
  fill(0);
  font=loadFont("Purisa-Bold-48.vlw");
  textFont(font, 150);
  strokeWeight(10);
  stroke(#FCFF74);
  text("start", width/2-230, height/2+200);
  textSize(200);
  fill(#FCFF74);
  text("Doge Kill!", width/2-570, 250);
  textSize(30);
  fill(many0);
  text("many fun", 100, 400);
  fill(many1);
  text("such kill", 1050, 100);
  fill(many2);
  text("very robot", 600, 300);
  fill(many3);
  text("wow", 600, 100);
  fill(many4);
  text("so game", 1000, 600);
  fill(many5);
  text("play pls", 100, 700);
  if (mouseX>=350&&mouseX<=850&&mouseY>400&&mouseY<600) {
    c=50;
  } else {
    c=255;
  }
}
//END

