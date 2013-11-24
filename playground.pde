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
  frameRate(40);
  textAlign(CENTER);
  s = new ArrayList<Station>();
  s1 = new ArrayList<Station>();
  s2 = new ArrayList<Station>();
  s3 = new ArrayList<Station>();
  s4 = new ArrayList<Station>();
  s5 = new ArrayList<Station>();
  t = new ArrayList <Train>();
  l=new ArrayList<Line>();
  n= new Note();

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

  for (int q=11;q<18;q++) {
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
  Train t = n.pickTrain(l.get(0));
  if (t != null) {
    t.getOn(n);
  }
  n.appear();
  
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
}

