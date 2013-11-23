class Train {

  PVector pos, vel, acc;
  float maxforce;    
  float maxspeed;
  float d;  
  color c;

  Train(PVector _p, color _c) {
    pos=_p;
    vel=new PVector (0, 0);
    acc=new PVector (0, 0);
    maxspeed = 4;
    maxforce = 1;
    d=20;
    c=_c;
  }

  void move() {
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
  }

  void appF(PVector f) {
    acc.add(f);
  }

  void seek(PVector tar) {
    
    PVector desired = PVector.sub(tar, pos);
    float d = desired.mag();
    if (d < 100) {
      float m = map(d, 0, 100, 0, maxspeed);
      desired.setMag(m);
    } 
    else {
      desired.setMag(maxspeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce); 
    appF(steer);
   /*
        PVector desired = PVector.sub(tar,pos);  // A vector pointing from the location to the target
    
    // Scale to maximum speed
    desired.setMag(maxspeed);

    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired,vel);
    steer.limit(maxforce);  // Limit to maximum steering force
    
    appF(steer);*/
    
  }

  void show() {
    noStroke();
    fill(c);
    ellipse(pos.x, pos.y, d, d);
  }
  
  /*
  float x,y,d;
  color c;
  Train(float _x, float _y, color _c){
    x=_x;
    y=_y;
    c=_c;
    d=40;
  }
  void move(float a, float b){
    float theta=.1;
    x=lerp(x,a,theta);
    y=lerp(y,b,theta);
    theta++;
  }
  void show(){
    noStroke();
    fill(c);
    ellipse(x, y, d, d);
  }
  */
}

