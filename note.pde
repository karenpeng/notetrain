class Note {
  float x, y, d;
  boolean attach;
  float theta=0;
  Line lastLine;    //record the last line
  int passedStation=0;
  boolean sound;
  Train t;
  int counter;
  boolean blink;
  int counterB;
  boolean still;

  Note(float _x, float _y) {
    x=_x;
    y=_y;
    d=30;
    attach=false;
    sound=false;
    counter=0;
    blink=false;
    counterB=0;
    still=true;
  }

  void hover() {
  }

  void drag() {
    if (dist(mouseX, mouseY, x, y)<d*2) {
      x=mouseX;
      y=mouseY;
      still=false;
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
      /* if (ll == lastLine) {
       return null;
       }*/
      for (int i= 0; i<ll.trains.size();i++) {
        if (ll.trains.get(i).atStation(station)) {
          attach=true;
          lastLine = ll;
          t=ll.trains.get(i);
          return ll.trains.get(i);
        }
      }
    }
    return null;
  }

  void sing() {
    if (attach) {
      for (Station s:lastLine.stations) {
        if (s.trigger(t.pos) && s.on) {
          sound=true;
          blink=true;
        }
      }
      println(sound);
    }/*
    if(sound){
     counter++;
     }
     if(counter>1){
     sound=false;
     counter=0;
     }*/

    if (counter>0) {
      sound=false;
      counter=0;
    }
    if (sound) {
      counter++;
    }
    if (blink) {
      counterB++;
    }
    if (counterB>9) {
      blink=false;
      counterB=0;
    }
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
    x=lastLine.stations.get(0).x;
    y=lastLine.stations.get(0).y;
  }

  void jump() {
    attach = false;
    passedStation = 0;
  }

  void appear() {
    strokeWeight(2);
    stroke(0);
    fill(255); 
    if (blink) {
      ellipse(x, y, d+8, d+8);
    }
    else {
      ellipse(x, y, d, d);
    }
  }
}

