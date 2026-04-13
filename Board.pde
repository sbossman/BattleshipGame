class Board{
  Battleship[] battleships;
  Coordinate[][] board;
  PImage img = loadImage("Water.png");
  
  // TODO: Implement everything
  Board(){
    battleships = new Battleship[4];
    for(int i = 0; i < 4; i++){
      battleships[i] = new Battleship(i + 2);
    }
    
    board = new Coordinate[boardSq][boardSq];
    for(int i = 0; i < boardSq; i++){
      for(int j = 0; j < boardSq; j++){
        board[i][j] = new Coordinate();
      }
    }
  }
  
  boolean guessPosition(int x, int y){
    board[x][y].guess();
    for(int i = 0; i < battleships.length; i++){
      if(battleships[i].checkIfHit(x, y)){
        battleships[i].checkSunk(board);
        return true;
      }
    }
    return false;
  }
  
  boolean hasBeenGuessed(int[] p){
    return board[p[0]][p[1]].guessed;
  }
  
  void finishSetup(){
    println("Setting coordinates");
    for(int i = 0; i < battleships.length; i++){
      for(int j = 0; j < battleships[i].positions.length; j++){
        int x = battleships[i].positions[j][0];
        int y = battleships[i].positions[j][1];
        if(x != -1 && y != -1)  board[x][y].ship = true;
      }
    }
  }
  
  void drawBoard(int boardX, int boardY, boolean showUnsunkShips){
    float boardL = boardX - (boardSize/2);
    float boardB = boardY + (boardSize/2);
    float boardT = boardY - (boardSize/2);
    
    rectMode(CENTER);
    //fill(btnColor);
    //rect(boardX, boardY, boardSize, boardSize);
    tint(255);
    image(img, boardX - boardSize/2, boardY - boardSize/2, boardSize, boardSize);
    
    // Draws the board with the appropriate lines and labels
    for (int i = 0; i < 10; i++) {
      fill(255);
      textFont(DejaVu20);
      // Numbers on left of board
      text(str(10-i), boardL - 15, boardT + (i * sqSize) + (sqSize/2) + 5);
      // Alphabet on bottom of board
      text(char(i+97), boardL  + (i * sqSize) + (sqSize/2), boardB + 20);
      stroke(255);
      // Horizontal lines
      line(boardL, boardT + (i * sqSize), boardL + boardSize, boardT + (i * sqSize));
      // Vertical lines
      line(boardL + (i * sqSize), boardT, boardL + (i * sqSize), boardB);
    }
    
    noFill();
    rect(boardX, boardY, boardSize, boardSize);
    
    for(int i = 0; i < battleships.length; i++){
      if(battleships[i].sunk || showUnsunkShips) battleships[i].drawBattleship((int)boardL, (int)boardT);
    }
    
    // Draws guesses
    if(gameState == "GUESS"){
      for(int x = 0; x < 10; x++){
        for(int y = 0; y < 10; y++){
          if(board[x][y].guessed){
            noStroke();
            if(board[x][y].ship) fill(255, 0, 0);
            else fill(255);
            circle(x * sqSize + boardX - (boardSize/2) + (sqSize/2), y * sqSize + boardY - (boardSize/2) + (sqSize/2), sqSize - 7);
          }
        }
      }
    }
  }
  
  boolean checkLoss(){
    for(int i = 0; i < battleships.length; i++){
      if(!battleships[i].sunk) return false;
    }
    return true;
  }  
  
  
  void setRandomShips(){
    // TODO: Make this actually random
      for(int i = 0; i < comBoard.battleships.length ; i++){
      comBoard.battleships[i].setPosition(7 - i, i * 2);
    }
    
  }
}

boolean withinBounds(int[] pos){
  boolean xWithin = pos[0] >= 0 && pos[0] < 10;
  boolean yWithin = pos[1] >= 0 && pos[1] < 10;
  return xWithin && yWithin;
}
