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
      if (playerBoard.illegalPlaceCheck() || !allPlaced()) {
        showIncomplete = true;
        return;
      }
      switchToNextScene();
      return;
    }
    
    // Vertically flips if selected and already has been positioned
    if (rotateBtn.isMouseover() && selectedInd != -1 && playerBoard.battleships[selectedInd].positions[0][0] != -1) {
      playerBoard.battleships[selectedInd].flipVertical();
      playerBoard.illegalPlaceCheck();
      return;
    }

    // Checking if a place on the board was selected and battleship selected
    // if they are, then it sets the position of that battleship
    if (selectedInd != -1 &&
      (mouseX > (boardX - boardSize/2) && mouseX < (boardX + boardSize/2)) &&
      (mouseY > (boardY - boardSize/2) && mouseY < (boardY + boardSize/2))) {
      int x = int((mouseX - (boardX - boardSize/2))/sqSize);
      int y = int((mouseY - (boardY - boardSize/2))/sqSize);
      playerBoard.battleships[selectedInd].setPosition(x, y);
      playerBoard.illegalPlaceCheck();
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
    if (selectedInd != -1 && playerBoard.battleships[selectedInd].positions[0][0] != -1) {
      playerBoard.battleships[selectedInd].flipVertical();
      playerBoard.illegalPlaceCheck();
    }
    
  }


  // Checks if all ships are placed
  boolean allPlaced() {
    for (int i = 0; i < playerBoard.battleships.length; i++) {
      if (playerBoard.battleships[i].positions[0][0] == -1) return false;
    }
    return true;
  }

  
  
  void switchToNextScene() {
    gameState = "GUESS";
    comBoard = new Board();
    comBoard.setRandomShips();
    comBoard.finishSetup();
    playerBoard.finishSetup();
  }
}
