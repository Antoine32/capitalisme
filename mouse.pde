void mouseEntered() {
  mousePresent = true;
  mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale));
}

void mouseExited() {
  mousePresent = false;
  mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale));
  pointerWait = millis();
  pointState = 4;
}

void mouseClicked() {
  mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale));
}

void mousePressed() {
  mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale));
  pointerWait = millis();

  if (mouseButton == LEFT) {
    pointState = 4;
  } else if (mouseButton == RIGHT) {
    pointState = 1;
  } else if (mouseButton == CENTER) {
    pointState = 3;
  }

  select = new PVector(mouse.x + focus.x, mouse.y);
}

void mouseMouved() {
  mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale));
}

void mouseReleased() {
  if (rectDetect(boxs.get(0).pos.x, boxs.get(0).pos.y, boxs.get(0).size.x, boxs.get(0).size.y)) {
    pause = !pause;
    timePause = millis();
  }

  mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale));

  if (creationMode) {
    if (pointState == 2) {
      if (object == 0) {
        cash.add(new money(constrain(mouse.x + focus.x, 32 * scale, (mapSize - 32) * scale), constrain(mouse.y, 32 * scale, height - (ground + 32) * scale)));
      } else if (object == 1) {
        if (mouse.x + focus.x > select.x) {
          if (mouse.y > select.y) {
            plat.add(new platform(select.x, select.y, (mouse.x + focus.x) - select.x, mouse.y - select.y));
          } else {
            plat.add(new platform(select.x, mouse.y, (mouse.x + focus.x) - select.x, select.y - mouse.y));
          }
        } else {
          if (mouse.y > select.y) {
            plat.add(new platform(mouse.x + focus.x, select.y, select.x - (mouse.x + focus.x), mouse.y - select.y));
          } else {
            plat.add(new platform(mouse.x + focus.x, mouse.y, select.x - (mouse.x + focus.x), select.y - mouse.y));
          }
        }
      }
    }
  }

  pointerWait = millis();
  pointState = 4;
}
