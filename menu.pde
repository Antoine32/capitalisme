void menu() {
  image(anim.get(0).imgUse, width / 2, height / 2.0);
  final float x = 983 * scale;
  final float y = 364 * scale;

  if (!coinJump & !blackout) {
    cursor(anim.get(1).imgUse);

    if (boxs.get(1).clicked || keyPressed & keyCode == ENTER & mouse.x <= x & mouse.y >= y) {
      boxs.remove(1);
      coinJump = true;
      posCoin = new PVector(mouse.x, mouse.y);
      distCoin = sqrt(sq(posCoin.x - x) + sq(posCoin.y - y));
      distCoinV = new PVector(x - posCoin.x, y - posCoin.y);

      anim.get(1).time = 125;
      coinCollected.play();
    }
  } else if (coinJump & !blackout) {
    cursor(pointer[pointState]);
    posCoin.add(distCoinV.x / 50, distCoinV.y / 50);
    posCoin.x = constrain(posCoin.x, 0, x);
    posCoin.y = constrain(posCoin.y, y, height);
    image(anim.get(1).imgUse, posCoin.x, posCoin.y, constrain((1.0 - (sqrt(sq(posCoin.x - x) + sq(posCoin.y - y)) / distCoin)) * (128.0 * scale), 64.0 * scale, 128 * scale), constrain((1.0 - (sqrt(sq(posCoin.x - x) + sq(posCoin.y - y)) / distCoin)) * (128.0 * scale), 64.0 * scale, 128 * scale));

    if (sqrt(sq(posCoin.x - x) + sq(posCoin.y - y)) < 100) {
      anim.get(1).time = 250;
    }

    if (sqrt(sq(posCoin.x - x) + sq(posCoin.y - y)) < 10 & anim.get(1).turn == 0) {
      coinJump = false;
      blackout = true;
      blacking = millis();
      endLevel.play();
    }
  } else if (blackout) {
    fill(0, 0, 0, (float(millis() - blacking) / 2500.0) * 255.0);
    stroke(0, 0, 0, (float(millis() - blacking) / 2500.0) * 255.0);
    rect(width / 2, height / 2, width + 1, height + 1);

    if ((float(millis() - blacking) / 2500.0) >= 1) {
      blackout = false;
      loadMap();
    }
  }
}
