class SetupScreen extends Screen {
  Button setupDoneBtn;
  Button rotateBtn;
  int selectedInd = -1;
  
  int boardX = 300;
  int boardY = height/2;
  boolean showIncomplete = false;
  
  
  SetupScreen(){
    setupDoneBtn = new Button(width/2, 550, 200, 50, "Done");
    rotateBtn = new Button(3 * width/4, 550, 150, 50, "Rotate");
    playerBoard = new Board();
  }
  
  // Responsible for visuals of the setup screen
  void display(){
    
    background(bgColor);
    textSize(30);
    fill(255);
    text("Place your ships!", width/2, 50);
    fill(225, 0, 0);
    if(showIncomplete) text("Cannot continue until all ships placed in valid positions", width/2, 100);
    
    stroke(255);
    
    playerBoard.drawBoard(boardX, boardY);
    // Drawing the done button
    setupDoneBtn.drawButton();
    rotateBtn.drawButton();
  }
  
  // Responsible for handling all mouse clicks on setup screen
  void handleMouseclick(){
    showIncomplete = false;
    
    // Checking if button selected
    if(setupDoneBtn.isMouseover()){
      if(illegalPlaceCheck() || !allPlaced()){
        showIncomplete = true;
        return;
      }
      gameState = "GUESS";
      return;
    }
    if(rotateBtn.isMouseover() && selectedInd != -1){
      playerBoard.battleships[selectedInd].flipVertical();
    }
    
    // Checking if a place on the board was selected and battleship selected
    
    if(selectedInd != -1 &&
        (mouseX > (boardX - boardSize/2) && mouseX < (boardX + boardSize/2)) &&
        (mouseY > (boardY - boardSize/2) && mouseY < (boardY + boardSize/2))){
      int x = int((mouseX - (boardX - boardSize/2))/sqSize);
      int y = int((mouseY - (boardY - boardSize/2))/sqSize);
      playerBoard.battleships[selectedInd].setPosition(x, y);
      return;
    }
    
    // Checking if battleship selected
    selectedInd = -1;
    for(int i = 0; i < playerBoard.battleships.length; i++){
      playerBoard.battleships[i].unselect();      
      if(playerBoard.battleships[i].isMouseover()){
        selectedInd = i;
      }
    }
    if(selectedInd != -1){
      playerBoard.battleships[selectedInd].select();
    }
    
    illegalPlaceCheck();
  }
  
  boolean allPlaced(){
    for(int i = 0; i < playerBoard.battleships.length; i++){
      if(playerBoard.battleships[i].positions[0][0] == -1) return false;
    }
    return true;
  }
  
  boolean illegalPlaceCheck(){
    boolean illegal = false;
    for(int i = 0; i < playerBoard.battleships.length; i++){
      playerBoard.battleships[i].setIllegallyPlaced(false);
      Battleship bshp = playerBoard.battleships[i];
      print("X2: " + bshp.positions[bshp.size - 1][0] + "\t Y2: " + bshp.positions[bshp.size - 1][1]);
      if(bshp.positions[bshp.size - 1][0] >= boardSq || bshp.positions[bshp.size - 1][1] >= boardSq){
        playerBoard.battleships[i].setIllegallyPlaced(true);
        illegal = true;
        break;
      }      
      
      int x = bshp.positions[0][0];
      int y = bshp.positions[0][1];
      int xSize = bshp.size;
      int ySize = 1;
      if(bshp.vertical){
        ySize = bshp.size;
        xSize = 1;
      }
      for(int j = 0; j < playerBoard.battleships.length; j++){
        Battleship bshp2 = playerBoard.battleships[j];
        if(i == j || bshp2.positions[0][0] == -1) continue;
        
        for(int p = 0; p < bshp2.positions.length; p++){
          int xB = bshp2.positions[0][0];
          int yB = bshp2.positions[0][1];
          if(xB >= x && xB < x + xSize && yB >= y && yB < y + ySize){
            playerBoard.battleships[i].setIllegallyPlaced(true);
            playerBoard.battleships[j].setIllegallyPlaced(true);
            illegal = true;
          }
        }
      }
    }
    
    return illegal;
  }
}
