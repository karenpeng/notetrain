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

  Train pickTrain(Line ll, Station station) {
    //all the trains in this line  
    if (!attach) {
      for (int i= 0; i<ll.trains.size();i++) {
        if (ll.trains.get(i).atStation(station)) {
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
    fill(255,255,0); 
    ellipse(x, y, d, d);
  }
}

