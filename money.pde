public class money {
  PVector pos;
  boolean grabed = false;

  money(float x, float y) {
    pos = new PVector(x, y);
  }

  void display() {
    image(anim.get(1).imgUse, pos.x, pos.y);
    if (hitbox) {
      rect(pos.x, pos.y, 64 * scale, 64 * scale);
    }
  }

  boolean touch(float x, float y) {
    return (x <= (pos.x + (32 * scale)) & x >= (pos.x - (32 * scale)) & y <= (pos.y + (32 * scale)) & y >= (pos.y - (32 * scale)));
  }
}
