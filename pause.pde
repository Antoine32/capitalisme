void pause() {
  stroke(color(#FFE3CE));
  strokeWeight(scale * 3);
  fill(color(#ff3d00));
  rectMode(CENTER);
  if (!creationMode) {
    rect(width / 2, height / 2, scale * 300, scale * 266.66, 15);
    mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale) + (scale * 63));
  } else {
    rect(width / 2, height / 2, scale * 300, scale * 400, 15);
  }

  push();
  if (!creationMode) {
    translate(0, scale * -63);
  }
  for (int i = 0; i < pauseBox.size(); i++) {
    if (creationMode & i != 1 || i < 2) {
      pauseBox.get(i).display(pauseBox.get(i).size.y / (pauseBox.get(i).textLength / 1.2));
    }
  }
  pop();

  if (pauseBox.get(0).clicked) {
    pause = false;
    if (!menuMode) {
      level = false;
      won = false;
      message = false;
      music.stop();
      menuMode = true;
      boxs.add(new box(width / 2, height - (scale * 65), scale * 635, scale * 100, 15, color(#ff3d00), "INSERER 25¢", color(#FFE3CE)));
    } else {
      exit();
    }
  } else if (pauseBox.get(1).clicked & !creationMode || keyPressed & keyCode == ENTER & !creationMode) {
    loadMap();

    if (boxs.size() > 1) {
      boxs.remove(1);
    }
  } else if (pauseBox.get(2).clicked & creationMode) {
    level = true;
    menuMode = false;
    pause = false;
    hitbox = true;
    cash.clear();
    plat.clear();
    mapSize = 1280;
    ground = 104;
    flag = new flags((mapSize - 70) * scale, height - ((ground + 140) * scale));
    message = false;
    won = false;

    music.stop();
    if (musicPlay) {
      music.loop();
    }

    if (boxs.size() > 1) {
      boxs.remove(1);
    }
  } else if (pauseBox.get(3).clicked & creationMode || keyPressed & keyCode == ENTER & creationMode) {
    if (level & creationMode) {
      saveMap();
      level = true;
      pause = false;
    }
  }

  mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale));

  beginTime += millis() - timePause;
  timePause = millis();

  fill(color(#FFE3CE));
  textAlign(CENTER, CENTER);
  textSize(100 * scale);
  text(currentLevel, (width / 8.0) * 6.5, height / 2);
  if (level & !creationMode) {
    text("P:" + playerOne.netWorth, (width / 8.0) * 1.5, (height / 2) - (100 * scale));
    text("T:" + int(constrain((millis() - beginTime) / 1000, 0, pow(10, 10))), (width / 8.0) * 1.5, (height / 2) + (100 * scale));
  }

  strokeWeight(scale);
}
