class Line {
  ArrayList<Station> stations= new ArrayList<Station>();
  ArrayList<Train> trains= new ArrayList<Train>();
  color c;
  int maxTrainNums;

  Line(ArrayList<Station> _s, ArrayList<Train> _t, color _c) {
    stations=_s;
    trains=_t;
    c = _c;
    maxTrainNums = 10;
  }

  void addTrain() {
    if (trains.size() >= maxTrainNums) {
      return;
    }
    Train t;
    Station startStation = stations.get(0);
    t = new Train(new PVector(startStation.x, startStation.y), c);
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
      strokeWeight(18);
      line(n.x, n.y, m.x, m.y);
    }
  }

  void showStation() {
    for (Station s: stations) {
      s.hover();
      s.display();
    }
  }

  void clickStation() {
    for (Station s: stations) {
      s.onOff();
      s.pitch();
    }
  }

  void DragStation() {
    for (Station s: stations) {
      s.intersect();
    }
  }
}

