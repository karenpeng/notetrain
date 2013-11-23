ArrayList notes;
Note n ;
ArrayList trains;
Train t;
int j, interval;
PVector station;
Note m;

void setup() {
  size(800,600);
  background(100);
  j=0;
  station = new PVector(width, height);
  interval=60;
  
  notes = new ArrayList<Note>();
  notes.add(new Note(width/2, height*3/4));
  notes.add(new Note(width/2, height/2));
  notes.add(new Note(width/2, height/4));
   notes.add(new Note(width/4, height/4));
  m = (Note)notes.get(0);

  trains = new ArrayList<Train>();
  PVector inti = new PVector(width, height);
  trains.add(new Train(inti, color(255, 0, 255)));
  //trains.add(new Train(width,height,color(255,0,255)));
  t = (Train)trains.get(0);
}
void draw() {
  background(100);
  fill(100,10);
  rect(0,0,width,height);

  if (frameCount%interval==0) {
    if (j<notes.size()) {
       m = (Note)notes.get(j);
      station=new PVector(m.x, m.y);
      j++;
    }
  }
  
  t.seek(station);
  t.move();
  t.show();  

  for (int i=0; i<notes.size();i++) {
    n = (Note)notes.get(i);
    n.display();
  }
}

void mousePressed() {
  for (int i=0; i<notes.size();i++) {
    n = (Note)notes.get(i);
    n.onOff();
  }
}

void mouseDragged() {
  for (int i=0; i<notes.size();i++) {
    n = (Note)notes.get(i);
    n.turn();
  }
}

