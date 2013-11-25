class Line {
  ArrayList<Station> stations/*= new ArrayList<Station>()*/;
  ArrayList<Train> trains/*= new ArrayList<Train>()*/;
  color c;
  int maxTrainNums;
  Station start;

  Line(ArrayList<Station> _s, color _c) {
    stations=_s;
    trains=new ArrayList<Train>();
    c = _c;
    maxTrainNums = 20;
   // start = _s.get(0);
  }

  void addTrain() {
    if (trains.size() >= maxTrainNums) {
      return;
    }
    Train t;
    Station start = stations.get(0);
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
      stroke(c);
      strokeWeight(8);
      line(n.x, n.y, m.x, m.y);
    }
  }

  void showStation() {
    for (Station s: stations) {
      s.hover();
      s.countTrigger();
      s.display(c);
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

