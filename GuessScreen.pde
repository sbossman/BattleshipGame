class GuessScreen extends Screen{
  Button loseBtn;
  Button winBtn;
  
  GuessScreen(){
    
    loseBtn = new Button(width/4, 550, 200, 60, "Lose Game");
    winBtn = new Button(3 * width/4, 550, 200, 60, "Win Game");
    initializeComputerBoard();
    
    // TODO: Initialize computer board
  }
  
  void display(){
    background(bgColor);
    
    textSize(30);
    fill(255);
    text("Guess ship locations!", width/2, 50);
    
    playerBoard.drawBoard(225, height/2, true);
    comBoard.drawBoard(675, height/2, true);
    
    textSize(24);
    fill(255);
    text("Your board", 245, height/2 - boardSize/2 - 20);
    text("Computer board", 665, height/2 - boardSize/2 - 20);
    
    winBtn.drawButton();
    loseBtn.drawButton();
  }
  
  // Responsible for handling all mouse clicks on guessing screen
  void handleMouseclick(){
    if(loseBtn.isMouseover()){
      gameState = "LOST";
    }
    if(winBtn.isMouseover()){
      gameState = "WIN";
    }
  }
  
}

void initializeComputerBoard(){
    comBoard = new Board();
    
    // TODO: make this random
    for(int i = 0; i < comBoard.battleships.length ; i++){
      comBoard.battleships[i].setPosition(7 - i, i * 2);
    }
}
