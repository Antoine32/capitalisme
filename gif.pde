public class gif {
  String name;
  PImage frames[];
  PImage imgUse;
  int amount;
  int turn;
  int time;
  int last;

  gif(String tex, int a, int t) {
    name = tex;
    frames = new PImage[a];
    amount = a;
    turn = 0;
    time = t;
    last = millis() + t;

    for (int i = 0; i < amount; i++) {
      frames[i] = loadImage(tex + i + ".png");
    }

    imgUse = frames[turn].copy();
  }

  void turn() {
    if (millis() >= last) {
      last = millis() + time;
      turn++;
      turn %= amount;

      imgUse = frames[turn].copy();
    }
  }

  void resizeW(float w) {
    for (int i = 0; i < amount; i++) {
      frames[i] = loadImage(name + i + ".png");
      frames[i].resize(int(w), int(w * (float(frames[i].pixelHeight) / float(frames[i].pixelWidth))));
    }

    imgUse = frames[turn];
  }

  void resizeH(float h) {
    for (int i = 0; i < amount; i++) {
      frames[i] = loadImage(name + i + ".png");
      frames[i].resize(int(h * (float(frames[i].pixelWidth) / float(frames[i].pixelWidth))), int(h));
    }

    imgUse = frames[turn];
  }

  void refresh() {
    imgUse = frames[turn];
  }
}
