void saveMap() {
  PrintWriter output = createWriter("maps/map_" + currentLevel + ".txt");

  output.println("#version");
  output.println(version);

  output.println("#ground"); 
  output.println(ground);

  output.println("#mapSize"); 
  output.println(mapSize);

  output.println("#flag"); 
  output.println((flag.pos.x / scale) + "," + (flag.pos.y / scale));

  output.println("#background"); 
  output.println(city.name + "," + city.amount);

  output.println("#coins");
  for (int i = 0; i < cash.size(); i++) {
    output.print((cash.get(i).pos.x / scale) + "," + (cash.get(i).pos.y / scale));
    if (i < cash.size() - 1) {
      output.print(TAB);
    }
  }
  output.println();

  output.println("#platform");
  for (int i = 0; i < plat.size(); i++) {
    output.print((plat.get(i).posA.x / scale) + "," + (plat.get(i).posA.y / scale) + "," + (plat.get(i).posB.x / scale) + "," + (plat.get(i).posB.y / scale));
    if (i < plat.size() - 1) {
      output.print(TAB);
    }
  }
  output.println();

  output.println("#message");
  output.println();

  output.flush();
  output.close();

  pause = false;
}

void loadMap() {
  music.stop();
  if (musicPlay) {
    music.loop();
  }
  startMoving = false;

  BufferedReader reader = createReader("maps/map_" + currentLevel + ".txt");
  String line = "";
  plat.clear();
  cash.clear();
  messageBox.text.clear();
  messageBox.textLength = 0;

  if (currentLevel <= MAXLEVEL) {
    try {
      while ((line = reader.readLine()) != null) {
        if (line.charAt(0) == '#') {
          if (sameString(line, "#version")) {
            line = reader.readLine();
            version = line;
          } else if (sameString(line, "#ground")) {
            line = reader.readLine();
            ground = float(line);
          } else if (sameString(line, "#mapSize")) {
            line = reader.readLine();
            mapSize = float(line);
          } else if (sameString(line, "#mapSize")) {
            line = reader.readLine();
            mapSize = float(line);
          } else if (sameString(line, "#flag")) {
            line = reader.readLine();
            String p[] = split(line, ',');
            flag = new flags(float(p[0]) * scale, float(p[1]) * scale);
          } else if (sameString(line, "#coins")) {
            cash = new ArrayList<money>();
            if ((line = reader.readLine()) != null) {
              String p[] = split(line, TAB);
              if (p != null) {
                for (String buf : p) {
                  String a[] = split(buf, ',');
                  if (a != null) {
                    cash.add(new money(float(a[0]) * scale, float(a[1]) * scale));
                  }
                }
              }
            }
          } else if (sameString(line, "#platform")) {
            if ((line = reader.readLine()) != null) {
              String p[] = split(line, TAB);
              if (p != null) {
                for (String buf : p) {
                  String a[] = split(buf, ',');
                  if (a != null) {
                    plat.add(new platform(float(a[0]) * scale, float(a[1]) * scale, float(a[2]) * scale, float(a[3]) * scale));
                  }
                }
              }
            }
          } else if (sameString(line, "#message")) {
            if ((line = reader.readLine()) != null) {
              String m[] = split(line, TAB);
              if (m != null) {
                for (String b : m) {
                  messageBox.addText(b);
                }
              }
            }
          }
        }
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }

    focus.x = 0;
    pause = false; 
    beginTime = millis(); 
    won = false; 
    startMoving = false; 
    level = true; 
    menuMode = false; 
    message = true; 
    playerOne = new player("player", 100 * scale, -160 * scale);
  } else {
    if (!menuMode) {
      boxs.add(new box(width / 2, height - (scale * 65), scale * 635, scale * 100, 15, color(#ff3d00), "INSERER 25¢", color(#FFE3CE)));
    }
    music.stop();
    level = false; 
    menuMode = true; 
    pause = false; 
    won = false;
  }
}

boolean sameString(String a, String b) {
  if (a.length() == b.length()) {
    for (int i = 0; i < a.length(); i++) {
      if (a.charAt(i) != b.charAt(i)) {
        return false;
      }
    }

    return true;
  } else {
    return false;
  }
}
