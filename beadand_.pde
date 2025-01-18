import processing.sound.*;
Amplitude amp;
AudioIn in;

int tileSize = 10; 
int cols, rows;    // Kockák száma vízszintesen és függőlegesen
int currentX = 0;  // Aktuális X koordináta
int currentY = 0;  // Aktuális Y koordináta

PImage img;

void setup() {
  size(790,790);
  img = loadImage("Csipke.png"); 

  img.resize(width, height); 
  cols = width / tileSize;  // Hány kocka fér vízszintesen
  rows = height / tileSize; // Hány kocka fér függőlegesen
  
  frameRate(100);  // Reálisabb frame rate
  noStroke();
  background(255,235,200);
  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

void draw() {
  float volume = amp.analyze(); // Hangerő elemzése
  println(volume);

  // Ha van hangerő, a rajzolás folytatódik
  if (volume > 0.05 && currentY < rows) { // Érzékenyebb küszöbérték
    color c = img.get(currentX * tileSize + tileSize / 2, currentY * tileSize + tileSize / 2);
    fill(c);
    rect(currentX * tileSize, currentY * tileSize, tileSize, tileSize); // Kocka kirajzolása
    currentX++; // Következő kocka pozíció
    if (currentX >= cols) {
      currentX = 0;
      currentY++;
    }
  }
  
  // Ha az összes sor elkészült, leállítja a rajzolást
  if (currentY >= rows) {
    noLoop();
  }
  saveFrame("frames/####.png");
}
