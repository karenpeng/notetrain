class Note {
  float x, y, d;
  boolean attach;
  float theta=0;
  Line lastLine;    //record the last line
  int passedStation=0;

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
      //when transfer, do not get on the same line
      if (ll == lastLine) {
        return null;
      }
      for (int i= 0; i<ll.trains.size();i++) {
        if (ll.trains.get(i).atStation(station)) {
          attach=true;
          lastLine = ll;
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
    passedStation = 0;
  }

  void appear() {
    fill(255,255,0); 
    ellipse(x, y, d, d);
  }
}

