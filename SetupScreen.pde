class SetupScreen extends Screen {
  Button setupDoneBtn;
  
  
  SetupScreen(){
    setupDoneBtn = new Button(width/2, 550, 200, 50, "Done");
    playerBoard = new Board(10, 10);
  }
  
  // Responsible for visuals of the setup screen
  void display(){
    
    background(bgColor);
    textSize(30);
    fill(255);
    text("Place your ships!", width/2, 50);
    stroke(255);
    
    playerBoard.drawBoard(300, height/2);
    // Drawing the done button
    setupDoneBtn.drawButton();
  }
  
  // Responsible for handling all mouse clicks on setup screen
  void handleMouseclick(){
    if(setupDoneBtn.isMouseover()){
      gameState = "GUESS";
      return;
    }
    for(int i = 0; i < playerBoard.battleships.length; i++){
      if(playerBoard.battleships[i].isMouseover()){
        playerBoard.battleships[i].click();
      }
    }
  }
}
