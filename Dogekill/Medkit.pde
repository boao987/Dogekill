class Medkit {
  final static int ACTIVE=0;  
  final static int DEAD=1; 
  
  int msize;
  float mxcor;
  float mycor;

  Medkit() {
    msize=30;
    mycor=300;
    mxcor=300;
  }

  void display() {
    fill(255);
    rect(mxcor, mycor, msize, msize);
    fill(255, 0, 0);
    rect(mxcor, mycor+13, 30, 5);
    rect(mxcor+13, mycor, 5, 30);
  }
}

