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
  //color c;

  Station(float _x, float _y) {
    x=_x;
    y=_y;
    d=22;
    hover=false;
    on=false;
    trigger=false;
    intersect=false;
    countPlus=0;
    //dis = dist(mouseX, mouseY, _x, _y);
    lastX=_x;
    lastY=_y-32;
    counter=0;
    isTransferStation=false;
    //c=_c;
  }

  void onOff() {  
    dis = dist(mouseX, mouseY, x, y);
    if (/*mousePressed && */dis<=d/2) {  
      on = !on;
    }
    if (on) {
      d=d+countPlus*.2;
    }
    else {
      d=22;
    }
  }

  void hover() {
    dis = dist(mouseX, mouseY, x, y);
    if (on && !mousePressed && dis<=d) {
      //d=25;
      hover = true;
    } /*
    else {
     hover = false;
     }*/
    if (hover && dis>d*2) {
      hover = false;
    }
  }

  void pitch() {
    if (hover /*&& mousePressed*/) {
      float pitch1=dist(mouseX, mouseY, x-d, y);
      float pitch2=dist(mouseX, mouseY, x+d, y);
      if (pitch1<d/4) {
        countPlus+=1;
      }
      if (pitch2<d/4) {
        countPlus-=1;
      }
      println(d);
    }
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

  void intersect() {
    if (intersect) {
      float intersectDis = dist(x, y, mouseX, mouseY);
      //println(intersect);
      if (intersectDis<=46) {
        //println("yeah");
        lastX=x+32*(mouseX-x)/ intersectDis;
        lastY=y+32*(mouseY-y)/ intersectDis;
      }
    }
  }

  void display(color c) {
    textAlign(CENTER);
    //println(dis);
    if (intersect) {
      fill(0);
      pushMatrix();
      translate(lastX, lastY);
      if (lastX-x>=0) {
        float dd = asin((lastY-y)/dist(lastX, lastY, x, y));
        float ang=map(dd, -PI/2, PI/2, 0, PI);
        rotate(ang);
        //println("right"+ang+" "+dd);
        //println(dd);
      }
      else {
        float dd = asin((lastY-y)/dist(lastX, lastY, x, y));
        float ang=map(dd, PI/2, -PI/2, PI, PI*2);
        rotate(ang);
        //println("left"+ang+" "+dd);
        //println(dd);
      }

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
        ellipse(x, y, d, d);
        fill(255);
        String t = Integer.toString(countPlus);
        text(t, x, y+5);
      }
      if (hover) {
        fill(c);
        ellipse(x, y, d, d);
        fill(255);
        String t = Integer.toString(countPlus);
        text(t, x, y+5);
        fill(0);
        ellipse(x-d, y, d/2, d/2);
        ellipse(x+d, y, d/2, d/2);
        fill(255);
        text("+", x-d, y+5);
        text("-", x+d, y+5);
      }
      if (trigger) {
        //d=30;
      }
      if (!trigger) {
        //d=25;
      }
    }
    if (!on) {
      //strokeWeight(2);
      //stroke(c);
      noStroke();
      fill(0);
      //noFill();
      ellipse(x, y, d, d);
      fill(255);
      //textSize(10);
      text("off", x, y+5);
    }
  }
}

