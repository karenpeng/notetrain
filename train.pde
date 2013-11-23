class Train {
  PVector pos, vel, acc;  
  float maxforce;
  float maxspeed;
  float d;  
  color c;
  ArrayList<PVector> history;
  int nextIndex; 
  ArrayList<Station> stations; 
  boolean arrived;
  boolean headArrived;

  Train(PVector _p, color _c) {
    pos=_p;
    vel=new PVector (0.0, 0.0);
    acc=new PVector (0, 0);
    maxspeed = 6;
    maxforce = 4;
    d=20;
    c=_c;
    history = new ArrayList<PVector>();
    stations= new ArrayList<Station>(); 
    nextIndex = 0;
    arrived = false;
    headArrived = false;
  }

  void move() {
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
    history.add(pos.get());
    if (history.size() > 20) {
      history.remove(0);
    }
  }

  void appF(PVector f) {
    acc.add(f);
  }

  void seek() {
    if (nextIndex == 0) {
      return;
    }
    Station next = stations.get(nextIndex);
    PVector tar = new PVector(next.x, next.y);
    PVector desired = PVector.sub(tar, pos);
    float d = desired.mag();
    if (d < 40) {
      float m = map(d, 0, 40, .6, maxspeed);
      desired.setMag(m);
    } 
    else {
      desired.setMag(maxspeed);
    }
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce); 
    appF(steer);
  }

  void check() {
    Station next = stations.get(nextIndex);
    if (nextIndex == stations.size() - 1) {
      if (!headArrived && next.trigger(pos)) {
        headArrived = true;
      }
      PVector lastHis = (PVector)history.get(0);
      float distance = dist(next.x, next.y, lastHis.x, lastHis.y);
      if (distance < 1) {
        arrived = true;
      }
    }
    if (nextIndex < stations.size() - 1 && next.trigger(pos)) {
      nextIndex++;
    }
  }

  void setLine(ArrayList _s) {
    stations = _s;
    nextIndex = 0;
  }
  
  void show() {
    noStroke();
    fill(c);
    ellipse(pos.x, pos.y, d, d);
    //fill(c, 100);
    for (PVector v: history) {
      ellipse(v.x, v.y, d, d);
    }
  }
}

