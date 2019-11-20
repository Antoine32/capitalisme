void keyPressed() {
  if (key == ESC) {
    key = 0;
  }

  if (keyCode == SHIFT) {
    shifting = true;
  }

  if (keyCode == RIGHT || keyCode == 68) {
    right = true;
  }

  if (keyCode == LEFT || keyCode == 65) {
    left = true;
  }

  if (keyCode == UP || keyCode == 87 || keyCode == 32) {
    up = true;
  }

  if (keyCode == DOWN || keyCode == 83) {
    down = true;
  }

  if (keyCode == ESC & menuMode) {
    exit();
  }
}

void keyReleased() {
  if (key == ESC) {
    key = 0;
  }

  if (keyCode == SHIFT) {
    shifting = false;
  }

  if (keyCode == RIGHT || keyCode == 68) {
    right = false;
  }

  if (keyCode == LEFT || keyCode == 65) {
    left = false;
  }

  if (keyCode == UP || keyCode == 87 || keyCode == 32) {
    up = false;
    if (pause) {
      currentLevel = constrain(currentLevel + 1, 0, MAXLEVEL);
    }
  }

  if (keyCode == DOWN || keyCode == 83) {
    down = false;
    if (pause) {
      currentLevel = constrain(currentLevel - 1, 0, 9);
    }
  }

  if (keyCode == 67) {
    creationMode = !creationMode;
    beginTime = millis();
  }
  if (keyCode == 72) {
    hitbox = !hitbox;
  }

  if (keyCode == 48) {// COIN
    object = 0;
  } else if (keyCode == 49) {// PLATFORM
    object = 1;
  } else if (keyCode == 50) {// FLAG
    object = 2;
  } else if (keyCode == 51) {// MAPSIZE
    object = 3;
  } else if (keyCode == 52) {// GROUND
    object = 4;
  }

  if (keyCode == ESC || keyCode == TAB) {
    pause = !pause;
    timePause = millis();
  }

  if (keyCode == 77) {
    musicPlay = !musicPlay;

    music.stop();
    if (musicPlay & level) {
      music.loop();
    }
  }
}
