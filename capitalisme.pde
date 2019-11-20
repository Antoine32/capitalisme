import processing.sound.*;

String version = "dev_1";
float scale = 1;
PFont font;
ArrayList<box> boxs = new ArrayList<box>();
ArrayList<box> pauseBox = new ArrayList<box>();
ArrayList<gif> anim = new ArrayList<gif>();
ArrayList<money> cash = new ArrayList<money>();
ArrayList<platform> plat = new ArrayList<platform>();
PImage pointer[];
PImage imgPlat;
int pointState = 0;
int pointerWait = millis();
int object = 0;
float mapSize = 1280;
float ground = 104;
PVector gravity = new PVector(0, 1);
PVector mouse = new PVector(mouseX, mouseY);
PVector select = new PVector(mouse.x, mouse.y);
PVector focus = new PVector(0, 0);
PVector offCenter;
boolean shifting = false;
boolean right = false;
boolean left = false;
boolean up = false;
boolean down = false;
boolean hitbox = true;
boolean creationMode = false;
boolean pause = false;
int timePause = millis();
int currentLevel = 0;
int timeWon = millis();
SoundFile music;
SoundFile coinCollected;
SoundFile endLevel;
boolean musicPlay = true;

/////////////////////////////////////////// MENU
boolean menuMode = true;
boolean mousePresent = true;
boolean coinJump = false;
boolean blackout = false;
PVector posCoin;
int blacking = millis();
float distCoin;
PVector distCoinV;

/////////////////////////////////////////// LEVEL
boolean level = false;
boolean message = false;
box messageBox;
player playerOne;
back city;
flags flag;
boolean won = false;
int beginTime = millis();
boolean startMoving = false;
box nextMap;
box restartMap;

final int MAXLEVEL = 4;// there is a level 0

void settings() {
  if ((16.0 / 9.0) * displayHeight < width) {
    size(int((16.0 / 9.0) * (displayHeight * 0.9)), int(displayHeight * 0.9), P2D);
  } else if ((9.0 / 16.0) * displayWidth < height) {
    size(int(displayWidth * 0.9), int((9.0 / 16.0) * (displayWidth * 0.9)), P2D);
  } else {
    size(int(displayWidth * 0.9), int(displayHeight * 0.9), P2D);
  }
}

void setup() {
  BufferedReader reader = createReader("save.txt");
  String line = null;

  try {
    while ((line = reader.readLine()) != null) {
      if (line.charAt(0) == '#') {
        if (sameString(line, "#version")) {
          line = reader.readLine();
          version = line;
        } else if (sameString(line, "#currentLevel")) {
          line = reader.readLine();
          currentLevel = int(line);
        } else if (sameString(line, "#creationMode")) {
          line = reader.readLine();
          if (sameString(line, "1")) {
            creationMode = true;
          } else {
            creationMode = false;
          }
        } else if (sameString(line, "#hitbox")) {
          line = reader.readLine();
          if (sameString(line, "1")) {
            hitbox = true;
          } else {
            hitbox = false;
          }
        } else if (sameString(line, "#musicPlay")) {
          line = reader.readLine();
          if (sameString(line, "1")) {
            musicPlay = true;
          } else {
            musicPlay = false;
          }
        }
      }
    }
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  music = new SoundFile(this, "sound/music.mp3");
  music.amp(0.25);
  coinCollected = new SoundFile(this, "sound/coinCollected.wav");
  endLevel = new SoundFile(this, "sound/endLevel.wav");

  rectMode(CENTER);
  scale = sqrt(sq(width) + sq(height)) / sqrt(sq(1280.0) + sq(720.0));

  font = createFont("SF-Compact-Rounded-Heavy.otf", scale * 25);
  textFont(font);

  focus = new PVector(width / 2, height / 2);

  pointer = new PImage[8];
  for (int i = 0; i < 8; i++) {
    pointer[i] = loadImage("grab hand/hand_" + i + ".png");
    pointer[i].resize(int(32 * scale), int(32 * scale));
  }

  boxs.add(new box(width - (scale * 35), scale * 35, scale * 64, scale * 64, 15, color(#ff3d00), "II", color(#FFE3CE)));
  if (menuMode) {
    boxs.add(new box(width / 2, height - (scale * 65), scale * 635, scale * 100, 15, color(#ff3d00), "INSERT 25¢", color(#FFE3CE)));
  }

  anim.add(new gif("coinDispenser_", 3, 500));
  anim.get(0).resizeW(width);
  anim.add(new gif("coin/Gold_", 10, 125));
  anim.get(1).resizeW(64 * scale);

  playerOne = new player("player", 100 * scale, -160 * scale);
  city = new back("City/Classic City/city_", 4);
  imgPlat = loadImage("Backgrounds/City/Classic City/platform.png");

  imageMode(CENTER);

  flag = new flags((mapSize - 70) * scale, height - ((ground + 140) * scale));

  nextMap = new box(width - (105 * scale), height  - (55 * scale), scale * 200, scale * 100, 15, color(#ff3d00), "NEXT", color(#FFE3CE));
  restartMap = new box(width - (310 * scale), height  - (55 * scale), scale * 200, scale * 100, 15, color(#ff3d00), "RESTART", color(#FFE3CE));

  messageBox = new box(width / 2, height / 2, width - (200 * scale), height - (200 * scale * (float(height) / float(width))), 15, color(#ff3d00), "", color(#FFE3CE));

  pauseBox.add(new box(width / 2, (height / 2) + (scale * 125), scale * 250, scale * 100, 15, color(#ff3d00), "QUIT", color(#FFE3CE)));
  pauseBox.add(new box(width / 2, (height / 2), scale * 250, scale * 100, 15, color(#ff3d00), "LOAD MAP", color(#FFE3CE)));
  pauseBox.add(new box(width / 2, (height / 2), scale * 250, scale * 100, 15, color(#ff3d00), "NEW MAP", color(#FFE3CE)));
  pauseBox.add(new box(width / 2, (height / 2) - (scale * 125), scale * 250, scale * 100, 15, color(#ff3d00), "SAVE MAP", color(#FFE3CE)));
}

void draw() {
  background(55);
  mouse = new PVector(mouseX - ((.85 / 1.13) * 16 * scale), mouseY - ((.42 / 1.13) * 16 * scale));

  if (pointState == 1 & millis() - pointerWait > 75 & mousePressed || pointState == 6 & millis() - pointerWait > 75 || pointState == 4 & millis() - pointerWait > 75 & mousePressed) {
    pointState++;
    pointerWait = millis();
  } else if (pointState == 4 & millis() - pointerWait > 75) {
    pointState = 0;
    pointerWait = millis();
  }

  for (int i = 0; i < anim.size(); i++) {
    anim.get(i).turn();
  }

  if (pause) {
    cursor(pointer[pointState]);
    pause();
  } else if (menuMode) {
    menu();
    beginTime = millis();
  } else {
    cursor(pointer[pointState]);

    if (won) {
      won();
    } else if (message) {
      messageBox.display(messageBox.size.y / (messageBox.textLength / 1.2));
      beginTime = millis();

      if (messageBox.clicked || keyPressed & keyCode == ENTER) {
        message = false;
        level = true;
      }
    } else if (level) {
      level();
    }
  }

  for (int i = 0; i < boxs.size(); i++) {
    if (i == 0 || !pause) {
      boxs.get(i).display(boxs.get(i).size.y * 0.35);
    }
  }

  if (hitbox) {
    fill(color(#FFE3CE), 155);
    stroke(0);
    circle(mouse.x, mouse.y, 5);
  }
}

void exit() {
  PrintWriter output;
  output = createWriter("save.txt");

  output.println("#version");
  output.println(version);

  output.println("#currentLevel");
  output.println(currentLevel);

  output.println("#creationMode");
  if (creationMode) {
    output.println("1");
  } else {
    output.println("0");
  }

  output.println("#hitbox");
  if (hitbox) {
    output.println("1");
  } else {
    output.println("0");
  }

  output.println("#musicPlay");
  if (musicPlay) {
    output.println("1");
  } else {
    output.println("0");
  }

  output.flush();
  output.close();

  super.exit();
}
