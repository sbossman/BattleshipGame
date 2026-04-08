class GuessScreen extends Screen{
  Button loseBtn;
  Button winBtn;
  
  int comBoardX = 675;
  int playerBoardX = 225;
  int boardY = height/2;
  
    
  GuessScreen(){
    loseBtn = new Button(width/4, 550, 200, 60, "Lose Game");
    winBtn = new Button(3 * width/4, 550, 200, 60, "Win Game");
  }
  
  void display(){
    background(bgColor);
    
    textSize(30);
    fill(255);
    text("Guess ship locations!", width/2, 50);
    
    playerBoard.drawBoard(playerBoardX, boardY, true);
    comBoard.drawBoard(comBoardX,  boardY, false);
    
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
    
    if((mouseX > (comBoardX - boardSize/2) && mouseX < (comBoardX + boardSize/2)) &&
        (mouseY > (boardY - boardSize/2) && mouseY < (boardY + boardSize/2))){
      int x = int((mouseX - (comBoardX - boardSize/2))/sqSize);
      int y = int((mouseY - (boardY - boardSize/2))/sqSize);
      
      // Allows user to guess until they miss (guess position returns true on hit)
      if(!comBoard.guessPosition(x,y)){
        while(comGuess());
      }
    }
    
    /*
    if((mouseX > (playerBoardX - boardSize/2) && mouseX < (playerBoardX + boardSize/2)) &&
        (mouseY > (boardY - boardSize/2) && mouseY < (boardY + boardSize/2))){
      int x = int((mouseX - (playerBoardX - boardSize/2))/sqSize);
      int y = int((mouseY - (boardY - boardSize/2))/sqSize);
      playerBoard.guessPosition(x,y);
    }
    */
    
    if(playerBoard.checkLoss()){
      gameState = "LOST";
    }
    if(comBoard.checkLoss()){
      gameState = "WIN";
    }
    
  }
  
  boolean comGuess(){
    int[] guess = new int[2];
    if(gameMode == "EASY") guess = guessEasy();
    else guess = guessHard();
    return playerBoard.guessPosition(guess[0], guess[1]);
  }
  
  int[] guessEasy(){
    int[] guess = {(int) random(10), (int) random(10)};
    while(playerBoard.board[guess[0]][guess[1]].guessed){
      guess[0] = (int) random(10);
      guess[1] = (int) random(10);
    }
    return guess;
  }
  
  int[] guessHard(){
    boolean ideaForNextGuess;
    int[] guess = {(int) random(10), (int) random(10)};
    while(playerBoard.board[guess[0]][guess[1]].guessed){
      guess[0] = (int) random(10);
      guess[1] = (int) random(10);
    }
    return guess;
  }
  
}
