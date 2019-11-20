public class player {
  String name;
  ArrayList<gif> animation = new ArrayList<gif>();
  int state = 0;
  PVector pos = new PVector(0, 0);
  PVector vit = new PVector(0, 0); 
  PVector acc = new PVector(0, 0);
  boolean side = true; // true == right | false == left
  boolean onGround = false;
  boolean doubleJump = true;
  float size = 160 ;
  PVector corDep = new PVector(3.03 / 5.64, 2.40 / 5.64);
  PVector corSiz = new PVector(2.96 / 5.64, 4.80 / 5.64);
  int netWorth = 0;
  int income[] = new int[0];
  int checkers = 12;
  PVector checkerR[] = new PVector[checkers];
  PVector checkerL[] = new PVector[checkers];

  player(String n, float x, float y) {
    name = n;
    pos = new PVector(x, y);

    animation.add(new gif(new String("player/" + name + "Idle_"), 4, 250));
    animation.add(new gif(new String("player/" + name + "Run_"), 5, 125));
    animation.add(new gif(new String("player/" + name + "Jump_"), 2, 999999));
    animation.add(new gif(new String("player/" + name + "Ting_"), 2, 250));

    corDep.x *= size;
    corDep.x -= size / 2;
    corDep.y *= size;
    corDep.y -= size / 2;

    corSiz.x *= size;
    corSiz.y *= size;

    checkerR[0] = new PVector(corDep.x * scale + (corSiz.x * scale) / 2 + 1, -1 * corDep.y * scale);
    checkerR[1] = new PVector(corDep.x * scale + (corSiz.x * scale) / 2 + 1, -1 * corDep.y * scale + (corSiz.y * scale) / 2);
    checkerR[2] = new PVector(corDep.x * scale + (corSiz.x * scale) / 2, -1 * corDep.y * scale + (corSiz.y * scale) / 2 + 1);
    checkerR[3] = new PVector(corDep.x * scale, -1 * corDep.y * scale + (corSiz.y * scale) / 2 + 1);
    checkerR[4] = new PVector(corDep.x * scale - (corSiz.x * scale) / 2, -1 * corDep.y * scale + (corSiz.y * scale) / 2 + 1);
    checkerR[5] = new PVector(corDep.x * scale - (corSiz.x * scale) / 2 - 1, -1 * corDep.y * scale + (corSiz.y * scale) / 2);
    checkerR[6] = new PVector(corDep.x * scale - (corSiz.x * scale) / 2 - 1, -1 * corDep.y * scale);
    checkerR[7] = new PVector(corDep.x * scale - (corSiz.x * scale) / 2, -1 * corDep.y * scale - (corSiz.y * scale) / 2 - 1);
    checkerR[8] = new PVector(corDep.x * scale - (corSiz.x * scale) / 2 - 1, -1 * corDep.y * scale - (corSiz.y * scale) / 2);
    checkerR[9] = new PVector(corDep.x * scale, -1 * corDep.y * scale - (corSiz.y * scale) / 2 - 1);
    checkerR[10] = new PVector(corDep.x * scale + (corSiz.x * scale) / 2, -1 * corDep.y * scale - (corSiz.y * scale) / 2 - 1);
    checkerR[11] = new PVector(corDep.x * scale + (corSiz.x * scale) / 2 + 1, -1 * corDep.y * scale - (corSiz.y * scale) / 2);

    checkerL[0] = new PVector(-1 * corDep.x * scale + (corSiz.x * scale) / 2 + 1, -1 * corDep.y * scale);
    checkerL[1] = new PVector(-1 * corDep.x * scale + (corSiz.x * scale) / 2 + 1, -1 * corDep.y * scale + (corSiz.y * scale) / 2);
    checkerL[2] = new PVector(-1 * corDep.x * scale + (corSiz.x * scale) / 2, -1 * corDep.y * scale + (corSiz.y * scale) / 2 + 1);
    checkerL[3] = new PVector(-1 * corDep.x * scale, -1 * corDep.y * scale + (corSiz.y * scale) / 2 + 1);
    checkerL[4] = new PVector(-1 * corDep.x * scale - (corSiz.x * scale) / 2, -1 * corDep.y * scale + (corSiz.y * scale) / 2 + 1);
    checkerL[5] = new PVector(-1 * corDep.x * scale - (corSiz.x * scale) / 2 - 1, -1 * corDep.y * scale + (corSiz.y * scale) / 2);
    checkerL[6] = new PVector(-1 * corDep.x * scale - (corSiz.x * scale) / 2 - 1, -1 * corDep.y * scale);
    checkerL[7] = new PVector(-1 * corDep.x * scale - (corSiz.x * scale) / 2, -1 * corDep.y * scale - (corSiz.y * scale) / 2 - 1);
    checkerL[8] = new PVector(-1 * corDep.x * scale - (corSiz.x * scale) / 2 - 1, -1 * corDep.y * scale - (corSiz.y * scale) / 2);
    checkerL[9] = new PVector(-1 * corDep.x * scale, -1 * corDep.y * scale - (corSiz.y * scale) / 2 - 1);
    checkerL[10] = new PVector(-1 * corDep.x * scale + (corSiz.x * scale) / 2, -1 * corDep.y * scale - (corSiz.y * scale) / 2 - 1);
    checkerL[11] = new PVector(-1 * corDep.x * scale + (corSiz.x * scale) / 2 + 1, -1 * corDep.y * scale - (corSiz.y * scale) / 2);
  }

  void display() {
    animation.get(state).turn();
    fill(255, 0, 0, 50);
    if (side) {
      image(animation.get(state).imgUse, pos.x, pos.y, size * scale, size * scale);

      if (hitbox) {
        rect(pos.x + corDep.x * scale, pos.y - corDep.y * scale, corSiz.x * scale, corSiz.y * scale);

        fill(color(#FFE3CE));
        noStroke();
        for (int i = 0; i < checkers; i++) {
          circle(pos.x + checkerR[i].x, pos.y + checkerR[i].y, scale);
        }
        strokeWeight(scale);
      }
    } else {
      push();
      scale(-1, 1);
      image(animation.get(state).imgUse, -pos.x, pos.y, size * scale, size * scale);
      pop();

      if (hitbox) {
        rect(pos.x - corDep.x * scale, pos.y - corDep.y * scale, corSiz.x * scale, corSiz.y * scale);

        fill(color(#FFE3CE));
        noStroke();
        for (int i = 0; i < checkers; i++) {
          circle(pos.x + checkerL[i].x, pos.y + checkerL[i].y, scale);
        }
        strokeWeight(scale);
      }
    }
  }

  void move() {
    int stat = state;

    if (pos.y + ((size * scale) / 2) >= height - (ground * scale)) {
      onGround = true;
      doubleJump =  true;
    }

    acc = new PVector(0, 0);
    float x = 1;
    if (shifting) {
      x = 2.0;
    }

    if (down & onGround) {
      state = 3;
      acc = new PVector(0, 0);
      vit.x = 0;

      if (right) {
        side = true;
      }
      if (left) {
        side = false;
      }
    } else {
      if (right) {        
        acc.x += x;
      }
      if (left) {
        acc.x -= x;
      }
      if (up & abs(vit.y) <= 0.01 & onGround || up & vit.y >= 0 & doubleJump) {
        acc.y = -20 * (frameRate / 60.0);
        vit.y = 0;
        up = false;

        if (!onGround) {
          doubleJump = false;
        }
      }

      if (acc.x > 0) {
        side = true;
      } else if (acc.x < 0) {
        side = false;
      }

      if (abs(acc.x) > 0) {
        if (!startMoving) {
          beginTime = millis();
        }
        startMoving = true;
      }
    }

    float bufX = abs(vit.x);
    vit.add(acc.x / (frameRate / 60.0), acc.y / (frameRate / 60.0));
    if (!onGround) {
      vit.add(gravity.x / (frameRate / 60.0), gravity.y / (frameRate / 60.0));
    }
    if (right || left) {
      if (shifting) {
        vit.x = constrain(vit.x, -20 * scale, 20 * scale);
      } else if (bufX > 10 & vit.x > 10) {
        vit.x = lerp(vit.x, constrain(vit.x, -10 * scale, 10 * scale), 0.5);
      } else {
        vit.x = constrain(vit.x, -10 * scale, 10 * scale);
      }
    }
    pos.add(vit.x / (frameRate / 60.0), vit.y / (frameRate / 60.0));
    if (side) {
      pos.x = constrain(pos.x, ((corSiz.x / 2.0) * scale) - (corDep.x * scale), (mapSize * scale) - ((corSiz.x * scale) / 2) - (corDep.x * scale));
    } else {
      pos.x = constrain(pos.x, ((corSiz.x / 2.0) * scale) + (corDep.x * scale), (mapSize * scale) - ((corSiz.x * scale) / 2) + (corDep.x * scale));
    }
    pos.y = constrain(pos.y, -height, height - (ground + (size / 2)) * scale);
    if (pos.y >= height - (ground + (size / 2)) * scale) {
      onGround = true;
      doubleJump = true;
      if (vit.y > 0) {
        vit.y = 0;
      }
    } else if (vit.y != 0) {
      onGround = false;
    }

    if (abs(vit.x) > 3 & onGround & !down) {
      state = 1;
      animation.get(state).time = constrain(int(1000.0 / abs(vit.x)), 50, 125);
    } else if (animation.get(state).turn == 0 & onGround & !down || state == 2 & onGround & !down) {
      state = 0;
    } else if (!onGround & !down) {
      state = 2;
      animation.get(state).last = millis() + animation.get(state).time;
      if (vit.y < 0) {
        animation.get(state).turn = 0;
      } else {
        animation.get(state).turn = 1;
      }

      animation.get(state).refresh();
    }

    if (abs(acc.x) == 0 & vit.x != 0) {
      boolean neg = (vit.x > 0);
      vit.x -= (abs(vit.x) / vit.x) * 0.6;
      if (vit.x < 0 & neg) {
        vit.x = 0;
      } else if (vit.x > 0 & !neg) {
        vit.x = 0;
      }
    }
    acc = new PVector(0, 0);

    if (state != stat & onGround) {
      animation.get(state).turn = 0;
      animation.get(state).last = millis() + animation.get(state).time;
    }
  }

  boolean touch(PVector p, PVector s) {
    return (side & (p.x - (s.x / 2)) <= (pos.x + ((corSiz.x / 2.0) * scale) + (corDep.x * scale)) & (p.x + (s.x / 2)) >= (pos.x - ((corSiz.x / 2.0) * scale) + (corDep.x * scale)) & (p.y - (s.y / 2)) <= (pos.y + ((corSiz.y / 2.0) * scale) - (corDep.y * scale)) & (p.y + (s.y / 2)) >= (pos.y - ((corSiz.y / 2.0) * scale) - (corDep.y * scale)) ||
      !side & (p.x - (s.x / 2)) <= (pos.x + ((corSiz.x / 2.0) * scale) - (corDep.x * scale)) & (p.x + (s.x / 2)) >= (pos.x - ((corSiz.x / 2.0) * scale) - (corDep.x * scale)) & (p.y - (s.y / 2)) <= (pos.y + ((corSiz.y / 2.0) * scale) - (corDep.y * scale)) & (p.y + (s.y / 2)) >= (pos.y - ((corSiz.y / 2.0) * scale) - (corDep.y * scale)));
  }

  void income(int cheque) {
    netWorth += cheque;
    int buf[] = income;
    income = new int[netWorth];
    for (int i = netWorth - cheque; i < netWorth; i++) {
      income[i] = millis();
      coinCollected.play();
    }
    for (int i = 0; i < netWorth - cheque; i++) {
      income[i] = buf[i];
    }
  }
}
