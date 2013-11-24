class Note {
  float x, y, d;
  boolean attach=false;
  int whichTrain;

  Note() {
    x=20;
    y=height-20;
    d=30;
  }

  void hover() {
  }

  void follow(Line l) {
    //all the trains in this line  
    if (!attach) {
      for (int i= 0; i<l.trains.size()-1;i++) {
        if (l.trains.get(i).history.size()<20) {
          //x=l.trains.get(i).pos.x;
          //y=l.trains.get(i).pos.y;
          whichTrain=i;
          attach=true;
          //break;
        }
      }
    }
    else {
      x=l.trains.get(whichTrain).pos.x;
      y=l.trains.get(whichTrain).pos.y;

      if (l.trains.get(whichTrain).arrived) {
        attach=false;
      }
    }


    //}
  }

  void appear() {
    fill(160); 
    ellipse(x, y, d, d);
  }
}

