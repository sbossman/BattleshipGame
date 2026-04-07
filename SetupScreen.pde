class SetupScreen extends Screen {
  Button setupDoneBtn;
  int selectedInd = -1;
  
  int boardX = 300;
  int boardY = height/2;
  
  
  SetupScreen(){
    setupDoneBtn = new Button(width/2, 550, 200, 50, "Done");
    playerBoard = new Board();
  }
  
  // Responsible for visuals of the setup screen
  void display(){
    
    background(bgColor);
    textSize(30);
    fill(255);
    text("Place your ships!", width/2, 50);
    stroke(255);
    
    playerBoard.drawBoard(boardX, boardY);
    // Drawing the done button
    setupDoneBtn.drawButton();
  }
  
  // Responsible for handling all mouse clicks on setup screen
  void handleMouseclick(){
    // Checking if button selected
    if(setupDoneBtn.isMouseover()){
      gameState = "GUESS";
      return;
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
    playerBoard.battleships[selectedInd].select();
  }
}
