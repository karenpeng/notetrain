ArrayList<Station>s;
ArrayList<Station> s1;
ArrayList<Station> s2;
ArrayList<Station> s3;
ArrayList<Station> s4;
ArrayList<Station> s5;
ArrayList<Train>t;
ArrayList<Line>l;
int between;

Note n;

void setup() {
  size(900, 700);
  frameRate(40);
  textAlign(CENTER);
  between=60;
  s = new ArrayList<Station>();
  s1 = new ArrayList<Station>();
  s2 = new ArrayList<Station>();
  s3 = new ArrayList<Station>();
  s4 = new ArrayList<Station>();
  s5 = new ArrayList<Station>();
  t = new ArrayList <Train>();
  l=new ArrayList<Line>();
  n= new Note(50, height-50);

  ////////////////////////////////////////////////////////////
  for (int i=0; i<=width; i+=between) {
    for (int j=0; j<height-between; j+=between) {
      s.add(new Station(i, j));
    }
  }
  ///////////////////////////////////////////////////////////
  int [] lineOne = {21, 20, 30, 41, 52, 51, 40, 39, 38, 37, 36, 25, 24, 23, 22, 22};
  for (int i=0;i<lineOne.length-1;i++) {
    s1.add(s.get(lineOne[i]));
  }

  int [] lineTwo = {164, 163, 162, 161, 160, 149, 138, 127, 116, 105, 94, 83, 72, 61, 60, 59, 48, 37, 26, 15, 14, 13, 12, 1, 1};
  for (int i=0;i<lineTwo.length-1;i++) {
    s2.add(s.get(lineTwo[i]));
  }

  int [] lineThree = {43, 54, 65, 76, 75, 74, 73, 72, 71, 70, 69, 68, 78, 78};
  for (int i=0;i<lineThree.length-1;i++) {
    s3.add(s.get(lineThree[i]));
  }

  int [] lineFour = {87, 79, 80, 81, 82, 83, 84, 85, 86, 87};
  for (int i=0;i<lineFour.length-1;i++) {
    s4.add(s.get(lineFour[i]));
  }

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
    if (frameCount==0 || frameCount%60==0) {
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

  for (int i=0; i<=14; i++) {
    for (int j=0; j<12; j++) {
      int s =i*11+j;
      String t = Integer.toString(s);
      fill(0);
      text(t, i*between, j*between+24);
    }
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

