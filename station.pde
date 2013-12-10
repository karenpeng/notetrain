class Station {
  float x, y;
  float d;
  boolean on;
  boolean hover;
  boolean trigger;
  boolean intersect;
  float dis;
  int countPlus;
  float lastX, lastY;
  int counter;
  boolean isTransferStation;
  float ang;
  float a, b;
  //color c;
  int whichKey;
  int constrainKey;
  String tone;

  Station(float _x, float _y) {
    x=_x;
    y=_y;
    d=20;
    hover=false;
    on=false;
    trigger=false;
    intersect=false;
    countPlus=0;
    lastX=_x;
    lastY=_y-30;
    counter=0;
    isTransferStation=false;
    ang=0;
    //c=_c;
    a=0;
    b=2*PI;
  }

  void onOff() {  
    dis = dist(mouseX, mouseY, x, y);
    if (dis<=d*.6) {  
      on = !on;
    }
  }

  void hover() {
    dis = dist(mouseX, mouseY, x, y);
    if (on && !mousePressed && dis<=d) {
      //d=25;
      hover = true;
    } 
    if (hover && dis>d*2) {
      hover = false;
    }
  }

  void pitch() {
    if (hover ) {
      float pitch1=dist(mouseX, mouseY, x+d, y);
      float pitch2=dist(mouseX, mouseY, x-d, y);
      if (pitch1<d/4) {
        countPlus+=1;
      }
      if (pitch2<d/4) {
        countPlus-=1;
      }
      println(countPlus+whichKey);
    }   
    whichKey=7+countPlus;
    constrainKey=constrain(whichKey, 0, 20);
    tone=melody[constrainKey];
  }

  boolean trigger(PVector p) {
    //if (on) {
    float triggerDis=dist(p.x, p.y, x, y);
    if (triggerDis<1) {
      trigger=true;
      return true;
    }//}
    else {
      return false;
      //trigger=false;
    }
  }

  void countTrigger() {
    if (trigger) {
      counter++;
    }
    if (counter>=10) {
      trigger=false;
      counter=0;
    }
  }

  void direct() {
    if (intersect) {
      float intersectDis = dist(x, y, mouseX, mouseY);
      //println(intersect);
      if (intersectDis<=30) {
        //println("yeah");
        lastX=x+30*(mouseX-x)/ intersectDis;
        lastY=y+30*(mouseY-y)/ intersectDis;
      }
    }
  }


  void display(color c) {
    textAlign(CENTER);

    if (intersect) {
      //lastX=constrain(lastX,x-d,x);
      if (lastX-x>=0) {
        float dd = asin((lastY-y)/dist(lastX, lastY, x, y));
        ang=map(dd, -PI/2, PI/2, 0, PI);
      }
      else {
        float dd = asin((lastY-y)/dist(lastX, lastY, x, y));
        ang=map(dd, PI/2, -PI/2, PI, PI*2);
      }
      pushMatrix();
      fill(0);
      translate(lastX, lastY);
      rotate(ang);
      beginShape();    
      vertex(6, 6);
      vertex(0, -6);
      vertex(-6, 6);
      endShape(CLOSE);
      popMatrix();
      stroke(0);
      strokeWeight(2);
      line(x, y, lastX, lastY);
    }
    if (on) {
      noStroke();
      if (!hover) {
        fill(0);
        ellipse(x, y, d+4, d+4);
        fill(255);
        text(tone, x, y+5);
      }
      if (hover) {
        fill(0);
        ellipse(x, y, d+4, d+4);
        fill(255);
        text(tone, x, y+5);
        fill(0);
        ellipse(x-d, y, d/2, d/2);
        ellipse(x+d, y, d/2, d/2);
        fill(255);
        text("-", x-d, y+5);
        text("+", x+d, y+5);
      }
      if (trigger) {
        // d=25;
      }
      if (!trigger&&on) {
        // d=22;
      }
      if (!trigger&&!on) {
        //  d=20;
      }
    }
    if (!on) {
      noStroke();
      fill(0);
      ellipse(x, y, d, d);
    }
  }
}

