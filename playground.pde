ArrayList<Station>s;
ArrayList<Station> s1;
ArrayList<Station> s2;
ArrayList<Station> s3;
ArrayList<Station> s4;
ArrayList<Station> s5;
ArrayList<Train>t1;
ArrayList<Train>t2;
ArrayList<Train>t3;
ArrayList<Train>t4;
ArrayList<Train>t5;
ArrayList<Line>l1;
ArrayList<Line>l2;
ArrayList<Line>l3;
ArrayList<Line>l4;
ArrayList<Line>l5;

void setup() {
  size(1170, 740);
  textAlign(CENTER);
  s = new ArrayList<Station>();
  s1 = new ArrayList<Station>();
  s2 = new ArrayList<Station>();
  s3 = new ArrayList<Station>();
  s4 = new ArrayList<Station>();
  s5 = new ArrayList<Station>();
  t1 = new ArrayList <Train>();
  t2 = new ArrayList <Train>();
  t3 = new ArrayList <Train>();
  t4 = new ArrayList <Train>();
  t5 = new ArrayList <Train>();

  ////////////////////////////////////////////////////////////
  for (int i=8; i>0; i--) {
    s.add(new Station(width/6, height*i/8));
  }

  for (int j=3; j<6; j++) {
    s.add(new Station(width*j/8, height*8/8));
    s.add(new Station(width*j/8, height*7/8));
    s.add(new Station(width*j/8, height*6/8));
    s.add(new Station(width*j/8, height*5/8));
    s.add(new Station(width*j/8, height*4/8));
    s.add(new Station(width*j/8, height*3/8));
  }

  for (int k=3;k<5;k++) {
    s.add(new Station(width*k/8, height*2/8));
    s.add(new Station(width*k/8, height*1/8));
  }

  for (int l=5;l<9;l++) {
    s.add(new Station(width*l/8, height*2/8));
  }

  ///////////////////////////////////////////////////////////
  for (int m=0;m<8;m++) {
    s1.add(s.get(m));
  }

  for (int o=8;o<13;o++) {
    s2.add(s.get(o));
  }
  s2.add(s.get(26));
  s2.add(s.get(27));

  for (int q=13;q<18;q++) {
    s3.add(s.get(q));
  }
  s3.add(s.get(28));
  s3.add(s.get(29));

  for (int r=18;r<23;r++) {
    s4.add(s.get(r));
  }
  s4.add(s.get(30));
  s4.add(s.get(31));
  s4.add(s.get(32));
  s4.add(s.get(33));
  
  println(s.size());
  
  //////////////////////////////////////////////////////////////////////////////
  l1.add(s1,t1,color (255, 0, 255));
  l2.add(s2,t2,color (0, 255, 255));
  l3.add(s3,t3,color (10, 255, 10));
  l4.add(s4,t4,color (255, 10, 10));
 // l5.add(s5,t5,color (255, 255,0));
  
}

void draw() {
  background(255);
}

void mouseClicked() {
}

void mouseDragged() {
}

