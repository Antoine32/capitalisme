public class back {
  String name;
  PImage frames[];
  int amount;
  int turn;

  back(String tex, int a) {
    name = tex;
    frames = new PImage[a];
    amount = a;
    turn = 0;

    for (int i = 0; i < amount; i++) {
      frames[i] = loadImage("Backgrounds/" + name + i + ".png");
      frames[i].resize(int(float(height) * (float(frames[i].pixelWidth) / float(frames[i].pixelHeight))), height);
    }
  }

  void display() {
    for (int i = 0; i < amount; i++) {
      image(frames[i], int(((focus.x / float(frames[i].pixelWidth / width)) - ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / amount))) / frames[i].pixelWidth) * frames[i].pixelWidth + (width / 2) + ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / amount)), height / 2);
      image(frames[i], int(((focus.x / float(frames[i].pixelWidth / width)) - ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / amount))) / frames[i].pixelWidth) * frames[i].pixelWidth + (width / 2) + frames[i].pixelWidth + ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / amount)), height / 2);
      if (hitbox) {
        line(int(((focus.x / float(frames[i].pixelWidth / width)) - ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / frames[i].pixelWidth))) / width) * frames[i].pixelWidth + (width / 2) + ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / amount)) + (frames[i].pixelWidth / 2.0), 0, int(((focus.x / float(frames[i].pixelWidth / width)) - ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / frames[i].pixelWidth))) / width) * frames[i].pixelWidth + (width / 2) + ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / amount)) + (frames[i].pixelWidth / 2.0), height);
        line(int(((focus.x / float(frames[i].pixelWidth / width)) - ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / frames[i].pixelWidth))) / width) * frames[i].pixelWidth + (width / 2) + frames[i].pixelWidth + ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / amount)) + (frames[i].pixelWidth / 2.0), 0, int(((focus.x / float(frames[i].pixelWidth / width)) - ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / frames[i].pixelWidth))) / width) * frames[i].pixelWidth + (width / 2) + frames[i].pixelWidth + ((focus.x / float(frames[i].pixelWidth / width)) * ((amount - float(i + 1)) / amount)) + (frames[i].pixelWidth / 2.0), height);
      }
    }
  }

  void resizeW(float w) {
    for (int i = 0; i < amount; i++) {
      frames[i] = loadImage(name + i + ".png");
      frames[i].resize(int(w), int(w * (float(frames[i].pixelHeight) / float(frames[i].pixelWidth))));
    }
  }

  void resizeH(float h) {
    for (int i = 0; i < amount; i++) {
      frames[i] = loadImage(name + i + ".png");
      frames[i].resize(int(h * (float(frames[i].pixelWidth) / float(frames[i].pixelHeight))), int(h));
    }
  }
}
