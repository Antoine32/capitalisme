void won() {
  stroke(255, 0, 0);
  strokeWeight(3 * scale);
  fill(color(255));

  push();
  translate(-75 * scale, -75 * scale);
  float numb = 200;
  rectMode(CORNERS);
  rect(((numb / 2) * scale), ((numb / 2) * scale), (width - (((numb / 3) * 2) * scale)), height - (((numb * (float(height) / float(width))) / 2) * scale), 15);
  rectMode(CENTER);

  noFill();
  numb = 250;
  PVector adjust = new PVector((float(width) - (numb * scale)) / float(timeWon - beginTime), (float(height) - ((numb * (float(height) / float(width))) * scale)) / float(playerOne.netWorth));
  push();
  translate((numb / 2) * scale, height - (((numb * (float(height) / float(width))) / 2) * scale));
  beginShape();
  vertex(0, 14 * scale);
  for (int i = 0; i < playerOne.netWorth; i++) {
    vertex(constrain(float(playerOne.income[i] - beginTime) * adjust.x, 0, width - (numb * 1.1 * scale)), -1 * constrain(float(i) * adjust.y, 0, height - ((numb - 80) * scale)));
  }
  vertex((width - ((numb * 1.1) * scale)), -(height - ((numb - 80) * scale)));
  endShape();
  pop();
  pop();

  fill(color(#FFE3CE));
  stroke(0);
  strokeWeight(scale);

  textSize(50 * scale);
  text("P:" + playerOne.netWorth, (width / 8.0) * 7.35, (height / 2.0) - (75 * scale));
  text("T:" + int(constrain((playerOne.income[playerOne.netWorth - 1] - beginTime) / 1000, 0, pow(10, 10))), (width / 2.0) - (50 * scale), (height / 8.0) * 7.2);

  fill(255, 0, 0, 50);

  nextMap.display(nextMap.size.y / (restartMap.textLength / 1.15));
  restartMap.display(nextMap.size.y / (restartMap.textLength / 1.15));

  if (nextMap.clicked || keyCode == ENTER & keyPressed) {
    if (currentLevel < MAXLEVEL) {
      currentLevel++;
      loadMap();
    } else {
      music.stop();
      if (!menuMode) {
        boxs.add(new box(width / 2, height - (scale * 65), scale * 635, scale * 100, 15, color(#ff3d00), "INSERER 25¢", color(#FFE3CE)));
      }
      menuMode = true;
      won = false;
      currentLevel = 0;
      pause = false;
      level = false;
    }
  } else if (restartMap.clicked || keyCode == BACKSPACE) {
    loadMap();
  }
}
