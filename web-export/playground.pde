ArrayList<Station>s;
ArrayList<Station> s1;
ArrayList<Station> s2;
ArrayList<Station> s3;
ArrayList<Station> s4;
ArrayList<Station> s5;
ArrayList<Train>t;
ArrayList<Line>l;

Note n;

void setup() {
  size(1200, 800);
  //frameRate(40);
  textAlign(CENTER);
  s = new ArrayList<Station>();
  s1 = new ArrayList<Station>();
  s2 = new ArrayList<Station>();
  s3 = new ArrayList<Station>();
  s4 = new ArrayList<Station>();
  s5 = new ArrayList<Station>();
  t = new ArrayList <Train>();
  l=new ArrayList<Line>();
  n= new Note(100, height-100);

  ////////////////////////////////////////////////////////////
  for (int i=7; i>=0; i--) {
    s.add(new Station(width/6, height*i/8));
  }

  for (int j=3; j<6; j++) {
    s.add(new Station(width*j/8, height*7/8));
    s.add(new Station(width*j/8, height*6/8));
    s.add(new Station(width*j/8, height*5/8));
    s.add(new Station(width*j/8, height*4/8));
    s.add(new Station(width*j/8, height*3/8));
  }

  for (int k=3;k<5;k++) {
    s.add(new Station(width*k/8, height*2/8));
    s.add(new Station(width*k/8, height*1/8));
    s.add(new Station(width*k/8, -height*1/8));
  }

  for (int l=5;l<9;l++) {
    s.add(new Station(width*l/8, height*2/8));
  }

  //s.get(21).intersect=true;
  ///////////////////////////////////////////////////////////
  for (int m=0;m<8;m++) {
    s1.add(s.get(m));
  }

  for (int o=8;o<13;o++) {
    s2.add(s.get(o));
  }
  s2.add(s.get(23));
  s2.add(s.get(24));
  s2.add(s.get(25));

  for (int q=13;q<18;q++) {
    s3.add(s.get(q));
  }
  s3.add(s.get(26));
  s3.add(s.get(27));
  s3.add(s.get(28));
  s3.get(1).intersect=true;
  s4.add(s3.get(2));

  for (int r=18;r<23;r++) {
    s4.add(s.get(r));
  }
  s4.add(s.get(29));
  s4.add(s.get(30));
  s4.add(s.get(31));
  s4.add(s.get(32));

  println(s.size());

  //////////////////////////////////////////////////////////////////////////////

  l.add( new Line(s1, t, color (255, 0, 255)));
  l.add( new Line(s2, t, color (0, 255, 255)));
  l.add( new Line(s3, t, color (10, 255, 10)));
  l.add( new Line(s4, t, color (255, 10, 10)));
}

void draw() {
  background(255);
  strokeWeight(2);

  for (Line ll: l) {
    ll.drawLine();
    if (frameCount==0 || frameCount%40==0) {
      ll.addTrain();
    }
    ll.moveTrain();
    ll.showStation();
  }

  // note pick which train to get on
  // if already in a trian, return null

  for (Line ll:l) {
    float dis=dist(ll.stations.get(0).x, ll.stations.get(0).y, n.x, n.y);
    if (!n.attach && dis<n.d) {
      Train t = n.pickTrain(ll);
      if (t != null) {
        t.getOn(n);
      }
    }
    n.jigger();
    n.appear();
  }
}

  void mousePressed() {
    for (Line ll: l) {
      ll.clickStation();
    }
  }

  void mouseDragged() {
    for (Line ll: l) {
      ll.dragStation();
    }
    n.drag();
  }

class Line {
  ArrayList<Station> stations/*= new ArrayList<Station>()*/;
  ArrayList<Train> trains/*= new ArrayList<Train>()*/;
  color c;
  int maxTrainNums;
  Station start;

  Line(ArrayList<Station> _s, ArrayList<Train> _t, color _c) {
    stations=_s;
    trains=_t;
    c = _c;
    maxTrainNums = 8;
    start = _s.get(0);
  }

  void addTrain() {
    if (trains.size() >= maxTrainNums) {
      return;
    }
    Train t;
    //Station startStation = stations.get(0);
    t = new Train(new PVector(start.x, start.y), c);
    t.setLine(stations);
    trains.add(t);
  }

  void moveTrain() {
    Train train;
    for (int i = 0; i < trains.size(); i++) {
      train = trains.get(i);
      train.check();    
      train.seek();
      train.move();
      train.show();
      if (train.arrived) {
        trains.remove(i);
      }
    }
  }

  void drawLine() {
    Station n, m;
    for (int i = 0; i < stations.size() - 1; i++) {
      n = stations.get(i);
      m = stations.get(i+1);
      stroke(c, 100);
      strokeWeight(18);
      line(n.x, n.y, m.x, m.y);
    }
  }

  void showStation() {
    for (Station s: stations) {
      s.hover();
      s.countTrigger();
      s.display();
    }
  }

  void clickStation() {
    for (Station s: stations) {
      s.onOff();
      s.pitch();
    }
  }

  void dragStation() {
    for (Station s: stations) {
      s.intersect();
    }
  }

}

class Note {
  float x, y, d;
  boolean attach;
  float theta=0;

  Note(float _x, float _y) {
    x=_x;
    y=_y;
    d=30;
    attach=false;
  }

  void hover() {
  }

  void drag() {
    if (dist(mouseX, mouseY, x, y)<d*2) {
      x=mouseX;
      y=mouseY;
    }
  }

  void jigger() {    
    d=sin(theta)*4+30;
    theta+=.1;
  }

  Train pickTrain(Line ll) {
    //all the trains in this line  
    if (!attach) {
      for (int i= 0; i<ll.trains.size()-1;i++) {
        if (ll.trains.get(i).history.size()<20) {
          attach=true;
          return ll.trains.get(i);
        }
      }
    }
    return null;
  }

  void follow (PVector trainPos) {
    if (attach) {
      x=trainPos.x;
      y=trainPos.y;
    }
  }
  void unfollow() {
    attach = false;
    // move the note out of screen
    x = -100;
    y = -100;
  }

  void appear() {
    fill(160); 
    ellipse(x, y, d, d);
  }
}


class Station {
  float x, y;
  float d;
  boolean on;
  boolean hover;
  boolean trigger;
  boolean longer;
  boolean intersect;
  float dis;
  int countPlus;
  float lastX, lastY;
  int counter;

  Station(float _x, float _y) {
    x=_x;
    y=_y;
    d=25;
    hover=false;
    on=false;
    trigger=false;
    longer=false;
    intersect=false;
    countPlus=0;
    //dis = dist(mouseX, mouseY, _x, _y);
    lastX=_x;
    lastY=_y-32;
    counter=0;
  }

  void onOff() {  
    dis = dist(mouseX, mouseY, x, y);
    if (/*mousePressed && */dis<=d/2) {  
      on = !on;
    }
  }

  void hover() {
    dis = dist(mouseX, mouseY, x, y);
    if (on && !mousePressed && dis<=d) {
      //d=25;
      hover = true;
    } /*
    else {
     hover = false;
     }*/
    if (hover && dis>d*1.5) {
      hover = false;
    }
  }

  void pitch() {
    if (hover /*&& mousePressed*/) {
      float pitch1=dist(mouseX, mouseY, x-d, y);
      float pitch2=dist(mouseX, mouseY, x+d, y);
      if (pitch1<d/4) {
        countPlus+=1;
      }
      if (pitch2<d/4) {
        countPlus-=1;
      }
    }
  }

  boolean trigger(PVector p) {
    //if (on) {
      float triggerDis=dist(p.x, p.y, x, y);
      if (triggerDis<1) {
        trigger=true;
        return true;
      }//}
      else {
        return false;
        //trigger=false;
      }
  }
  
  void countTrigger(){
    if(trigger){
      counter++;
    }
    if(counter>=10){
      trigger=false;
      counter=0;
    }
  }

  void intersect() {
    if (intersect) {
      float intersectDis = dist(x, y, mouseX, mouseY);
      //println(intersect);
      if (intersectDis<=46) {
        //println("yeah");
        lastX=x+32*(mouseX-x)/ intersectDis;
        lastY=y+32*(mouseY-y)/ intersectDis;
      }
    }
  }

  void display() {
    //println(dis);
    if (intersect) {
      fill(0);
      pushMatrix();
      translate(lastX, lastY);
      if (lastX-x>=0) {
        float dd = asin((lastY-y)/dist(lastX, lastY, x, y));
        float ang=map(dd, -PI/2, PI/2, 0, PI);
        rotate(ang);
        //println("right"+ang+" "+dd);
        //println(dd);
      }
      else {
        float dd = asin((lastY-y)/dist(lastX, lastY, x, y));
        float ang=map(dd, PI/2, -PI/2, PI, PI*2);
        rotate(ang);
        //println("left"+ang+" "+dd);
        //println(dd);
      }

      beginShape();    
      vertex(6, 6);
      vertex(0, -6);
      vertex(-6, 6);
      endShape(CLOSE);
      popMatrix();
      strokeWeight(2);
      line(x, y, lastX, lastY);
    }
    if (on) {
      /*
      stroke(0);
       fill(255);
       ellipse(x, y, d, d);
       text("0", x, y);
       if (hover) {*/
      strokeWeight(2);
      stroke(0);
      fill(255);
      ellipse(x, y, d, d);
      fill(0);
      String t = Integer.toString(countPlus);
      text(t, x, y+5);
      if (hover) {
        fill(0);
        ellipse(x-d, y, d/2, d/2);
        ellipse(x+d, y, d/2, d/2);
        fill(255);
        text("+", x-d, y+5);
        text("-", x+d, y+5);
      }
      if (trigger) {
        d=30;
      }
      if(!trigger){
        d=25;
      }
    }
    if (!on) {
      strokeWeight(2);
      stroke(0);
      fill(255);
      //noFill();
      ellipse(x, y, d, d);
      fill(0);
      //textSize(10);
      text("Off", x, y+5);
    }
  }
}

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
  ArrayList<Note> notes;  //passengers in this train

  Train(PVector _p, color _c) {
    pos=_p;
    vel=new PVector (0.0, 0.0);
    acc=new PVector (0, 0);
    maxspeed = 4;
    maxforce = 4;
    d=20;
    c=_c;
    history = new ArrayList<PVector>();
    stations = new ArrayList<Station>(); 
    notes = new ArrayList<Note>();
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
    //move the passengers
    for (Note n: notes) {
      n.follow(pos);
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
        for (Note n : notes) {
          n.unfollow(); //get down the train
        }
      }
    }
    if (nextIndex < stations.size() - 1 && next.trigger(pos)) {
      nextIndex++;
    }
  }

  void getOn(Note n) {
    notes.add(n);
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


