class Note {
  boolean hit;
  boolean on;
  boolean drag;
  float x, y; 
  float d;  
  float lastX, lastY;

  Note(float _x, float _y) {
    hit=false;
    on=false;
    x=_x;
    y=_y;
    d=20;
    lastX=_x-d;
    lastY=_y;
  }

  void onOff() {
    float dis = dist(mouseX, mouseY, x, y);
    if (dis<=d/2) {
      on = !on;
    }
  }

  void turn() {
    if (on) {
      float dis = dist(mouseX, mouseY, x, y);
      if (dis<d*2) {
        lastX=x+d*(mouseX-x)/dis;
        lastY=y+d*(mouseY-y)/dis;
      }
    }
  }

  void trigger() {
    hit=true;
  }

  void display() {
    stroke(0);
    strokeWeight(3);
    float dis=dist(mouseX, mouseY, x, y);
    if (on && hit) {
      fill(color(255, 255, 100));
    }
    else if (on) {
      fill(color(255, 255, 0));
    }
    else {
      fill(255);
    }
    ellipse(x, y, d, d);
    strokeWeight(1);
    line(x, y, lastX, lastY);
    if (on) {
      float gapX = lastX-x;
      float gapY = lastY-y;
      float t;

      if (gapY<=0) {
        t = map(acos((lastX-x)/dist(lastX, lastY, x, y)), PI, 0, 0, 300);
      }
      else {
        t = map(PI+(acos((lastX-x)/dist(lastX, lastY, x, y))), PI, 2*PI, 300, 600);
      }
      String s = Float.toString(t);
      if (gapY>=0) {
        text(s, lastX-10, lastY+20);
      }
      else {
        text(s, lastX-10, lastY-10);
      }
    }
    fill(0);
    noStroke();
    ellipse(lastX, lastY, d/4, d/4);
  }
}

