public class platform {
  PVector posA;
  PVector posB;
  PVector pos;
  boolean grabed = false;

  platform(float xa, float ya, float xb, float yb) {
    posA = new PVector(xa, ya);
    posB = new PVector(xb, yb);
    pos = new PVector(xa + (xb / 2.0), ya + (yb / 2.0));
  }

  void display() {
    imageMode(CORNER);
    image(imgPlat, posA.x, posA.y, posB.x, posB.y);
    imageMode(CENTER);

    fill(255, 0, 0, 50);
    if (hitbox) {
      rectMode(CORNER);
      rect(posA.x, posA.y, posB.x, posB.y);

      rectMode(CENTER);
    }
  }

  boolean touch(float x, float y) {
    return (x <= (pos.x + (posB.x / 2)) & x >= (pos.x - (posB.x / 2)) & y <= (pos.y + (posB.y / 2)) & y >= (pos.y - (posB.y / 2)));
  }
}
