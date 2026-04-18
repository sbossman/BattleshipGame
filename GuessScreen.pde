class GuessScreen extends Screen{
  Button loseBtn;
  Button winBtn;
  
  int comBoardX = 680;
  int playerBoardX = 240;
  int boardY = height/2;
  
  boolean playerTurn = true;
  
    
  GuessScreen(){
    loseBtn = new Button(width/4, 550, 200, 60, "Lose Game");
    winBtn = new Button(3 * width/4, 550, 200, 60, "Win Game");
  }
  
  void display(){
    background(bgColor);
    textFont(DejaVu30);
    fill(255);
    text("Guess ship locations!", width/2, 50);
    
    playerBoard.drawBoard(playerBoardX, boardY, true);
    comBoard.drawBoard(comBoardX,  boardY, false);
    
    textFont(DejaVu20);
    fill(255);
    text("Your board", 240, height/2 - boardSize/2 - 10);
    text("Computer board", 680, height/2 - boardSize/2 - 10);
    
    if(!playerTurn && (clock % 100 == 0)){
      comGuess();
    }
    
    // winBtn.drawButton();
    // loseBtn.drawButton();
  }
  
  // Responsible for handling all mouse clicks on guessing screen
  void handleMouseclick(){
    if(!playerTurn) return;
    
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
      
      if(comBoard.board[x][y].guessed) return;
      comBoard.guessPosition(x, y);
      playerTurn = false;
      
    }
    
    
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
    playerTurn = true;
    return playerBoard.guessPosition(guess[0], guess[1]);
  }
  
  int[] guessEasy(){
    int[] guess = {(int) random(10), (int) random(10)};
    while(playerBoard.hasBeenGuessed(guess)){
      guess[0] = (int) random(10);
      guess[1] = (int) random(10);
    }
    return guess;
  }
  
  int[] guessHard(){
    int[] guess = {-1, -1};
    
    for(int i = 0; i < playerBoard.battleships.length; i++){
      Battleship bshp = playerBoard.battleships[i];
      if(bshp.sunk) continue;
      
      int bshpHits = 0;
      int[] lowEdge = {10, 10}; // the position on ship with the lowest value
      
      
      for(int j = 0; j < bshp.positions.length; j++){
        int[] pos = bshp.positions[j];
        if(playerBoard.hasBeenGuessed(pos)){
          if(pos[0] < lowEdge[0] || pos[1] < lowEdge[1]){
            lowEdge[0] = pos[0];
            lowEdge[1] = pos[1];
          }
          bshpHits++;
        }
      }
      
      int[] up = {0, -1};
      int[] down = {0, 1};
      int[] left = {-1, 0};
      int[] right = {1, 0};
      int[][] directions = {up, right, down, left}; // Vertical is even, horizontal is odd
      // If the battleship has been hit once, we need to figure out if it's horizontal or not
      if(bshpHits == 1){
        for(int d = 0; d < directions.length; d++){
          int[] dir = directions[d];
          // If that direction hasn't been guessed, update the guess to that value
          int[] posToCheck = {lowEdge[0] + dir[0], lowEdge[1] + dir[1]};
          if(withinBounds(posToCheck) && !playerBoard.hasBeenGuessed(posToCheck)){
            guess = posToCheck;
          }          
        }
      }
      // If the battleship has been hit more than once, we keep guessing along that line
      else if(bshpHits > 0){
        for(int d = 0; d < directions.length; d++){
          if(bshp.vertical){
            int[] posToCheck = {lowEdge[0], lowEdge[1] - 1};
            if(withinBounds(posToCheck) && !playerBoard.hasBeenGuessed(posToCheck)){
              guess = posToCheck;
            }
            else{
              for(int c = lowEdge[1] + 1; c < 10; c++){
                posToCheck[1] = c;
                if(withinBounds(posToCheck) && !playerBoard.hasBeenGuessed(posToCheck)){
                  guess = posToCheck;
                  break;
                }
              }
            }
          }
          else{
            int[] posToCheck = {lowEdge[0] - 1, lowEdge[1]};
            if(withinBounds(posToCheck) && !playerBoard.hasBeenGuessed(posToCheck)){
              guess = posToCheck;
            }
            else{
              for(int c = lowEdge[0] + 1; c < 10; c++){
                posToCheck[0] = c;
                if(withinBounds(posToCheck) && !playerBoard.hasBeenGuessed(posToCheck)){
                  guess = posToCheck;
                  break;
                }
              }
            }
          }
        }
      }
    }
    
    if(guess[0] != -1){
      return guess;
    }
    
    
    guess[0] = (int) random(10);
    guess[1] = (int) random(10);
    while(guess[0] != -1 && playerBoard.hasBeenGuessed(guess)){
      guess[0] = (int) random(10);
      guess[1] = (int) random(10);
    }
    return guess;
  }
   
   void handleMousescroll() {
  }

}
