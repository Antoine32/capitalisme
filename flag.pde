public class flags {
  PVector pos;
  PVector size = new PVector(140, 280);
  gif imgs;
  boolean grabed = false;

  flags(float x, float y) {
    pos = new PVector(x, y);
    imgs = new gif("flag/flag_", 6, 350);
  }

  void display() {
    imgs.turn();

    imageMode(CENTER);
    image(imgs.imgUse, pos.x, pos.y, size.x * scale, size.y * scale);

    if (hitbox) {
      rectMode(CENTER);
      fill(255, 0, 0, 50);
      rect(pos.x, pos.y, size.x * scale, size.y * scale);
    }
  }

  boolean touch(float x, float y) {
    return (x <= (pos.x + ((size.x / 2) * scale)) & x >= (pos.x - ((size.x / 2) * scale)) & y <= (pos.y + ((size.y / 2) * scale)) & y >= (pos.y - ((size.y / 2) * scale)));
  }
}
