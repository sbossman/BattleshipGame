class SetupScreen extends Screen {
  Button setupDoneBtn;
  Button rotateBtn;
  int selectedInd = -1;

  int boardX = 240;
  int boardY = height/2;
  boolean showIncomplete = false;


  SetupScreen() {
    //textFont(DejaVu40);
    setupDoneBtn = new Button(5 * width/8 - 1, 552, 150, 50, "Done");
    rotateBtn = new Button(7 * width/8, 550, 152, 50, "Rotate");
  }

  // Responsible for visuals of the setup screen
  void display() {

    background(bgColor);
    textFont(Oswald70);
    fill(255);
    text("Place your ships!", width/2, 80);
    stroke(255);

    playerBoard.drawBoard(boardX, boardY, true);
    // Drawing the done button
    setupDoneBtn.drawButton();
    rotateBtn.drawButton();
    
    fill(225, 0, 0);
    textFont(DejaVu20);
    if (showIncomplete) text("Cannot continue until all ships placed in valid positions", width/2, 97);
  }

  // Responsible for handling all mouse clicks on setup screen
  void handleMouseclick() {
    showIncomplete = false;

    // Checking if done button hit
    // Only goes on to next screen if everything's placed correctly
    if (setupDoneBtn.isMouseover()) {
      if (illegalPlaceCheck() || !allPlaced()) {
        showIncomplete = true;
        return;
      }
      switchToNextScene();
      return;
    }
    // Vertically flips if selected
    if (rotateBtn.isMouseover() && selectedInd != -1) {
      playerBoard.battleships[selectedInd].flipVertical();
      illegalPlaceCheck();
    }

    // Checking if a place on the board was selected and battleship selected
    // if they are, then it sets the position of that battleship
    if (selectedInd != -1 &&
      (mouseX > (boardX - boardSize/2) && mouseX < (boardX + boardSize/2)) &&
      (mouseY > (boardY - boardSize/2) && mouseY < (boardY + boardSize/2))) {
      int x = int((mouseX - (boardX - boardSize/2))/sqSize);
      int y = int((mouseY - (boardY - boardSize/2))/sqSize);
      playerBoard.battleships[selectedInd].setPosition(x, y);
      illegalPlaceCheck();
      return;
    }
    // Checking if battleship selected, otherwise selects battleship
    selectedInd = -1;
    for (int i = 0; i < playerBoard.battleships.length; i++) {
      playerBoard.battleships[i].unselect();
      if (playerBoard.battleships[i].isMouseover()) {
        selectedInd = i;
      }
    }
    if (selectedInd != -1) {
      playerBoard.battleships[selectedInd].select();
    }
  }
  
  void handleMousescroll() {
    if (selectedInd != -1) {
      playerBoard.battleships[selectedInd].flipVertical();
      illegalPlaceCheck();
    }
    
  }


  // Checks if all ships are placed
  boolean allPlaced() {
    for (int i = 0; i < playerBoard.battleships.length; i++) {
      if (playerBoard.battleships[i].positions[0][0] == -1) return false;
    }
    return true;
  }

  boolean illegalPlaceCheck() {
    boolean[] notOverEdge = new boolean[playerBoard.battleships.length];
    boolean[] noOverlap = new boolean[playerBoard.battleships.length];

    // Initializing all ships to be in valid positions
    for (int i = 0; i < playerBoard.battleships.length; i++) {
      notOverEdge[i] = true;
      noOverlap[i] = true;
    }

    // Checking individual ships
    for (int i = 0; i < playerBoard.battleships.length; i++) {
      Battleship bshp = playerBoard.battleships[i];
      if (bshp.positions[0][0] == -1) continue; // Checks if this ship hasn't yet been initialized

      // Checking if a ship is over the edge of the board
      if (!withinBounds(bshp.positions[bshp.size - 1]) || !withinBounds(bshp.positions[0])) {
        notOverEdge[i] = false;
      }

      int x = bshp.positions[0][0];
      int y = bshp.positions[0][1];
      int xSize = bshp.size;
      int ySize = 1;
      if (bshp.vertical) {
        ySize = bshp.size;
        xSize = 1;
      }

      // Checking if it overlaps with another ship
      for (int j = 0; j < playerBoard.battleships.length; j++) {
        Battleship bshp2 = playerBoard.battleships[j];
        if (i == j || bshp2.positions[0][0] == -1) continue; // Ensures ship is initialized and a ship isn't checking itself

        for (int p = 0; p < bshp2.positions.length; p++) {
          int xB = bshp2.positions[0][0];
          int yB = bshp2.positions[0][1];
          if (xB >= x && xB < x + xSize && yB >= y && yB < y + ySize) {
            notOverEdge[i] = false;
            notOverEdge[j] = false;
          }
        }
      }
    }

    // Uses the previous flags to flag certain ships as illegally placed
    boolean flag = false;
    for (int i = 0; i < playerBoard.battleships.length; i++) {
      if (!notOverEdge[i] || !noOverlap[i]) {
        playerBoard.battleships[i].setIllegallyPlaced(true);
        flag = true;
      } else {
        playerBoard.battleships[i].setIllegallyPlaced(false);
      }
    }

    return flag;
  }
  
  void switchToNextScene() {
    gameState = "GUESS";
    comBoard = new Board();
    comBoard.setRandomShips();
    comBoard.finishSetup();
    playerBoard.finishSetup();
  }
}
