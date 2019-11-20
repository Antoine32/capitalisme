public class box {
  PVector pos;
  PVector size;
  float round;
  color col;
  ArrayList<String> text = new ArrayList<String>();
  color textCol;
  float textLength = scale;
  boolean overing = false;
  boolean clicked = false;

  box(float x, float y, float w, float h, float r, color c, String t, color tc) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    round = r;
    col = c;
    text.add(t);
    textLength = t.length();
    textCol = tc;
  }

  void addText(String t) {
    text.add(t);

    if (t.length() > textLength) {
      textLength = t.length();
    }
  }

  void display(float siz) {
    float mult = 1;

    if (rectDetect(pos.x, pos.y, size.x, size.y)) {
      if (mousePressed & mouseButton == LEFT) { 
        fill(col);
        mult = 1.025;
        overing = true;
        clicked = true;
      } else {
        fill((red(col) * 200) / 255, (green(col) * 200) / 255, (blue(col) * 200) / 255);
        mult = 1.005;
        overing = true;
        clicked = false;
      }
    } else {
      fill((red(col) * 155) / 255, (green(col) * 155) / 255, (blue(col) * 155) / 255);
      overing = false;
      clicked = false;
    }
    stroke(textCol);
    strokeWeight(scale * 3);
    rect(pos.x, pos.y, size.x * mult, size.y * mult, round);
    strokeWeight(scale);

    fill(textCol);
    textAlign(CENTER, CENTER);
    textSize(siz * mult * scale); 
    for (int i = 0; i < text.size(); i++) {
      text(text.get(i), pos.x, pos.y - (2 * scale) - (((text.size() / 2) - (i)) * siz * mult * scale * 2));
    }
  }
}

boolean rectDetect(float x, float y, float w, float h) {
  return(mouse.x >= x - (w / 2) & mouse.x <= x + (w / 2) & mouse.y >= y - (h / 2) & mouse.y <= y + (h / 2) & mousePresent);
}
