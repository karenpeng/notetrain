class Note {
  float x, y, d;
  boolean attach=false;

  Note() {
    x=20;
    y=height-20;
    d=30;
  }

  void hover() {
  }

  Train pickTrain(Line l) {
    //all the trains in this line  
    if (!attach) {
      for (int i= 0; i<l.trains.size()-1;i++) {
        if (l.trains.get(i).history.size()<20) {
          attach=true;
          return l.trains.get(i);
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

