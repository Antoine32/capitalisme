void level() {
  push();
  if (creationMode) {
    focus.x = constrain(playerOne.pos.x - (width / 2), 0, width * 9.1);
  } else {
    focus.x = constrain(playerOne.pos.x - (width / 2), 0, (mapSize * scale) - (width));
  }
  translate(-focus.x, 0);

  city.display();

  fill(255, 0, 0, 50);

  boolean OG = false; //safeCheck for onGround of the playerOne
  for (int i = 0; i < plat.size(); i++) {
    plat.get(i).display();

    if (hitbox) {
      fill(color(#FFE3CE));
      circle(plat.get(i).pos.x - (plat.get(i).posB.x / 2), plat.get(i).pos.y - (plat.get(i).posB.y / 2), 5);
      circle(plat.get(i).pos.x - (plat.get(i).posB.x / 2), plat.get(i).pos.y + (plat.get(i).posB.y / 2), 5);
      circle(plat.get(i).pos.x + (plat.get(i).posB.x / 2), plat.get(i).pos.y - (plat.get(i).posB.y / 2), 5);
      circle(plat.get(i).pos.x + (plat.get(i).posB.x / 2), plat.get(i).pos.y + (plat.get(i).posB.y / 2), 5);
    }

    if (plat.get(i).touch(select.x, select.y) & pointState == 5 & object == 1 & creationMode || plat.get(i).grabed & pointState == 5 & object == 1 & creationMode) {
      if (!plat.get(i).grabed) {
        offCenter = new PVector(plat.get(i).pos.x - (mouse.x + focus.x), plat.get(i).pos.y - mouse.y);
      }
      plat.get(i).grabed = true;
      plat.get(i).pos.x = constrain((mouse.x + focus.x) + offCenter.x, (plat.get(i).posB.x / 2), (mapSize * scale) - (plat.get(i).posB.x / 4));
      plat.get(i).pos.y = constrain(mouse.y + offCenter.y, (plat.get(i).posB.y / 2), height - ((ground * scale) + (plat.get(i).posB.y / 2)));
      plat.get(i).posA.x = plat.get(i).pos.x - (plat.get(i).posB.x / 2);
      plat.get(i).posA.y = plat.get(i).pos.y - (plat.get(i).posB.y / 2);
    } else if (plat.get(i).touch(select.x, select.y) & pointState == 3 & object == 1 & creationMode) {
      plat.remove(i);
      i--;
    } else if (playerOne.touch(plat.get(i).pos, plat.get(i).posB)) {
      float checkX = (plat.get(i).pos.x - playerOne.pos.x);
      float checkY = (plat.get(i).pos.y - playerOne.pos.y);

      if (abs(checkY) * (plat.get(i).posB.x / plat.get(i).posB.y) * (playerOne.corSiz.x / playerOne.corSiz.y) > abs(checkX) & !plat.get(i).grabed) {
        if (playerOne.pos.y - (playerOne.corSiz.y * scale) / 2 - playerOne.corDep.y * scale <= plat.get(i).pos.y + (plat.get(i).posB.y / 2) & checkY <= 0) {
          playerOne.vit.y = constrain(playerOne.vit.y, 0, height);
          playerOne.pos.y = constrain(playerOne.pos.y, plat.get(i).pos.y + (plat.get(i).posB.y / 2) + (playerOne.corSiz.y * scale) / 2 + playerOne.corDep.y * scale, height - (ground * scale));
        } 

        if (playerOne.pos.y + (playerOne.size * scale) / 2 >= plat.get(i).pos.y - (plat.get(i).posB.y / 2) & checkY >= 0) {
          playerOne.vit.y = constrain(playerOne.vit.y, -height, 0);
          playerOne.doubleJump = true;
          playerOne.pos.y = constrain(playerOne.pos.y, -height, (plat.get(i).pos.y - (plat.get(i).posB.y / 2)) - ((playerOne.size * scale) / 2));
          OG = true;
        }
      } else {
        if (playerOne.pos.x - (playerOne.corSiz.x * scale) / 2 - playerOne.corDep.x * scale >= plat.get(i).pos.x - (plat.get(i).posB.x / 2) & checkX <= 0) {
          playerOne.vit.x = constrain(playerOne.vit.x, 0, width);
          playerOne.pos.x = constrain(playerOne.pos.x, (plat.get(i).pos.x + (plat.get(i).posB.x / 2)) + (playerOne.corSiz.x * scale) / 2 + playerOne.corDep.x * scale, (mapSize * scale));
        } 

        if (playerOne.pos.x + (playerOne.corSiz.x * scale) / 2 + playerOne.corDep.x * scale <= plat.get(i).pos.x + (plat.get(i).posB.x / 2) & checkX >= 0) {
          playerOne.vit.x = constrain(playerOne.vit.x, -width, 0);
          playerOne.pos.x = constrain(playerOne.pos.x, -width, (plat.get(i).pos.x - (plat.get(i).posB.x / 2)) - (playerOne.corSiz.x * scale) / 2 - playerOne.corDep.x * scale);
        }
      }
    } else {
      plat.get(i).grabed = false;
    }
  }
  playerOne.onGround = OG;
  if (OG) {
    playerOne.doubleJump = true;
  }

  flag.display();
  if (flag.touch(select.x, select.y) & pointState == 5 & object == 2 & creationMode || flag.grabed & pointState == 5 & object == 2 & creationMode || flag.touch(select.x, select.y) & pointState == 2 & object == 2 & creationMode || flag.grabed & pointState == 2 & object == 2 & creationMode) {
    if (!flag.grabed) {
      offCenter = new PVector(flag.pos.x - (mouse.x + focus.x), flag.pos.y - mouse.y);
    }
    flag.grabed = true;
    flag.pos.x = constrain((mouse.x + focus.x) + offCenter.x, (flag.size.x * scale) / 2, (mapSize * scale) - ((flag.size.x * scale) / 2));
    flag.pos.y = constrain(mouse.y + offCenter.y, (flag.size.y * scale) / 2, height - (ground + (flag.size.y / 2)) * scale);
  } else if (playerOne.touch(flag.pos, flag.size) & !flag.grabed & !creationMode) {
    endLevel.play();
    timePause = millis();
    won = true;
    playerOne.income(int(constrain(1 * int(mapSize / 1280.0), 1, 10)) - int(constrain(float(millis() - beginTime) / 5000.0, 0, int(constrain(1 * int(mapSize / 1280.0), 1, 10)))));
    level = false;//subject to change
    //music.stop();
    timeWon = int(millis() + 1000);
  } else {
    flag.grabed = false;
  }

  for (int i = 0; i < cash.size(); i++) {
    fill(255, 0, 0, 50);
    cash.get(i).display();

    if (cash.get(i).touch(select.x, select.y) & pointState == 5 & object == 0 & creationMode || cash.get(i).grabed & pointState == 5 & object == 0 & creationMode) {
      if (!cash.get(i).grabed) {
        offCenter = new PVector(cash.get(i).pos.x - (mouse.x + focus.x), cash.get(i).pos.y - mouse.y);
      }
      cash.get(i).grabed = true;
      cash.get(i).pos.x = constrain((mouse.x + focus.x) + offCenter.x, 32 * scale, (mapSize - 32) * scale);
      cash.get(i).pos.y = constrain(mouse.y + offCenter.y, 32 * scale, height - (ground + 32) * scale);
    } else if (cash.get(i).touch(select.x, select.y) & pointState == 3 & object == 0 & creationMode) {
      cash.remove(i);
      i--;
    } else if (playerOne.touch(cash.get(i).pos, new PVector(64 * scale, 64 * scale)) & !cash.get(i).grabed & !creationMode) {
      cash.remove(i);
      i--;
      playerOne.income(1);
    } else {
      cash.get(i).grabed = false;
    }
  }

  if (creationMode) {
    if (pointState == 2) {
      if (object == 0) {
        fill(255, 0, 0, 50);
        image(anim.get(1).imgUse, constrain(mouse.x + focus.x, 32 * scale, (mapSize - 32) * scale), constrain(mouse.y, 32 * scale, height - (ground + 32) * scale));
        if (hitbox) {
          rect(constrain(mouse.x + focus.x, 32 * scale, (mapSize - 32) * scale), constrain(mouse.y, 32 * scale, height - (ground + 32) * scale), 64 * scale, 64 * scale);
        }
      } else if (object == 1) {
        PVector posA;
        PVector posB;
        if (mouse.x > select.x) {
          if (mouse.y > select.y) {
            posA = new PVector(select.x, select.y);
            posB = new PVector((mouse.x + focus.x) - select.x, mouse.y - select.y);
          } else {
            posA = new PVector(select.x, mouse.y);
            posB = new PVector((mouse.x + focus.x) - select.x, select.y - mouse.y);
          }
        } else {
          if (mouse.y > select.y) {
            posA = new PVector(mouse.x + focus.x, select.y);
            posB = new PVector(select.x - (mouse.x + focus.x), mouse.y - select.y);
          } else {
            posA = new PVector(mouse.x + focus.x, mouse.y);
            posB = new PVector(select.x - (mouse.x + focus.x), select.y - mouse.y);
          }
        }

        imageMode(CORNER);
        image(imgPlat, posA.x, posA.y, posB.x, posB.y);
        imageMode(CENTER);

        fill(255, 0, 0, 50);
        if (hitbox) {
          rectMode(CORNER);
          rect(posA.x, posA.y, posB.x, posB.y);
          rectMode(CENTER);
        }
      } else if (object == 3) {
        mapSize = constrain((mouse.x + focus.x) / scale, 1280, 1280 * 10);
      } else if (object == 4) {
        ground = constrain((float(height) - mouse.y) / scale, 0, 720 - (playerOne.corSiz.y));
      }
    } else if (pointState == 5) {
      if (object == 3) {
        mapSize = constrain((mouse.x + focus.x) / scale, 1280, 1280 * 10);
      } else if (object == 4) {
        //ground = constrain((float(height) - mouse.y) / scale, 0, 1280 - ((playerOne.corSiz.y + playerOne.corDep.y + playerOne.size)));
      }
    }
  }

  if (hitbox) {
    stroke(255, 0, 0);
    strokeWeight(3 * scale);
    line(mapSize * scale, 0, mapSize * scale, height);
    line(focus.x, height - (ground * scale), width + focus.x, height - (ground * scale));
    stroke(0);
    strokeWeight(scale);
  }

  playerOne.display();
  playerOne.move();

  pop();

  if (!startMoving || creationMode) {
    beginTime = millis();
  }

  fill(color(#FFE3CE));
  textSize(25 * scale);
  text("P:" + playerOne.netWorth, (textWidth("P:" + playerOne.netWorth) / 2) + (20 * scale), (35 * scale));
  text("T:" + int(constrain((millis() - beginTime) / 1000, 0, pow(10, 10))), (textWidth("T:" + int(constrain((millis() - beginTime) / 1000, 0, pow(10, 10)))) / 2) + (20 * scale), (80 * scale));
}
