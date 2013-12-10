import java.util.Map; 
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

ArrayList<Station> s;
ArrayList<Station> s1;
ArrayList<Station> s2;
ArrayList<Station> s3;
ArrayList<Station> s4;
ArrayList<Station> s5;
ArrayList<Station> s6;
ArrayList<Line>l;
int between;
ArrayList<Note>notes;
Note n;
String [] melody= {
  "C3", "D3", "E3", "F3", "G3", "A3", "B3", "C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", "A5", "B5",
};
//record how many line pass by each station
HashMap<Integer, Integer> stationsMap = new HashMap<Integer, Integer>();

void initLine(int [] line, ArrayList<Station> stations) {
  for (int i=0;i<line.length;i++) {
    int stationIndex = line[i];
    stations.add(s.get(stationIndex));

    Integer nums = stationsMap.get(stationIndex);
    if (nums == null) {
      stationsMap.put(stationIndex, 1);
    } 
    else {
      stationsMap.put(stationIndex, nums + 1);
    }
  }
}

void setup() {
  size(900, 700);
  minim = new Minim(this);
  out = minim.getLineOut();
  frameRate(40);
  textAlign(CENTER);
  between=60;
  s = new ArrayList<Station>();
  s1 = new ArrayList<Station>();
  s2 = new ArrayList<Station>();
  s3 = new ArrayList<Station>();
  s4 = new ArrayList<Station>();
  s5 = new ArrayList<Station>();
  s6 = new ArrayList<Station>();
  l=new ArrayList<Line>();
  notes=new ArrayList<Note>();
  //n= new Note(50, height-40);
  for (int i=0;i<6;i++) {
    notes.add(new Note(90+i*140, height-40));
  }
  ////////////////////////////////////////////////////////////
  for (int i=0; i<=width; i+=between) {
    for (int j=0; j<height-between; j+=between) {
      s.add(new Station(i, j));
    }
  }

  ///////////////////////////////////////////////////////////

  int [] lineOne = {
    21, 20, 30, 41, 52, 51, 40, 39, 38, 37, 36, 25, 24, 23, 22
  };
  initLine(lineOne, s1);

  int [] lineTwo = {
    164, 163, 162, 161, 160, 149, 138, 127, 116, 105, 94, 83, 72, 61, 60, 59, 48, 37, 26, 15, 14, 13, 12, 1
  };
  initLine(lineTwo, s2);

  int [] lineThree = {
    43, 54, 65, 76, 75, 74, 73, 72, 71, 70, 69, 68, 78, 88
  };
  initLine(lineThree, s3);

  int [] lineFour = {
    98, 97, 108, 119, 118, 117, 116, 115, 114, 113, 112, 100, 88
  };
  initLine(lineFour, s4);

  int [] lineFive = {
    155, 144, 145, 146, 135, 124, 113, 102, 91, 92, 93, 82, 71, 60, 49, 38, 27, 17, 7
  };
  initLine(lineFive, s5);

  int [] lineSix = {
    159, 148, 137, 126, 115, 104, 93, 94, 95, 96, 107, 118, 129, 140, 141, 153
  };
  initLine(lineSix, s6);


  for (Map.Entry me : stationsMap.entrySet()) {
    //if more than one line pass by, set this station to a transfer station
    if ((Integer)(me.getValue()) > 1) {
      s.get((Integer)(me.getKey())).isTransferStation = true;
      s.get((Integer)(me.getKey())).intersect=true;
    }
  }  

  //////////////////////////////////////////////////////////////////////////////

  l.add( new Line(s1, color (255, 0, 255)));
  l.add( new Line(s2, color (0, 255, 255)));
  l.add( new Line(s3, color (10, 255, 10)));
  l.add( new Line(s4, color (255, 10, 10)));
  l.add( new Line(s5, color (20, 20, 255)));
  l.add( new Line(s6, color (255, 255, 0)));
  println(s.size());
}

void draw() {
  background(255);
  strokeWeight(2);

  for (Line ll: l) {
    ll.drawLine();
    if ( frameCount%140==0) {
      ll.addTrain();
    }
    ll.moveTrain();
    ll.showStation();
  }

  // note pick which train to get on
  // if already in a train, return null
  for (Note n:notes) {
    if (!mousePressed) {
      for (Line ll:l) {
        for (Station station:ll.stations) {
          float dis=dist(station.x, station.y, n.x, n.y);
          if (!n.attach && dis<n.d) {
            Train t = n.pickTrain(ll, station);
            if (t != null) {
              t.getOn(n);
              break;
            }
          }
        }
      }
    }
    n.jigger();
    n.sing();
    n.appear();
  }
  /*  
   for (int i=0; i<=14; i++) {
   for (int j=0; j<12; j++) {
   int s =i*11+j;
   String t = Integer.toString(s);
   fill(0);
   text(t, i*between, j*between+24);
   }
   }
   */
  float s =frameRate;
  String t = Float.toString(s);
  fill(0);
  text(t, width-100, 40);
}

void mousePressed() {
  for (Line ll: l) {
    ll.clickStation();
  }
  for ( Station ss: s) {
    ss.onOff();
  }
}

void mouseDragged() {
  for (Line ll: l) {
    ll.dragStation();
  }
  for (Note n:notes) {
    n.drag();
  }
}

void keyPressed() {
  if (key=='j') {
    for (Note n :notes) {
      if (n.attach) {
        n.jump();
      }
    }
  }
}

