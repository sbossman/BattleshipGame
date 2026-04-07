class Board{
  Battleship[] battleships;
  Coordinate[][] board;
  
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
  
  void finishSetup(){
    
  }
  
  void drawBoard(int boardX, int boardY){
    float boardL = boardX - (boardSize/2);
    float boardB = boardY + (boardSize/2);
    float boardT = boardY - (boardSize/2);
    
    rectMode(CENTER);
    fill(btnColor);
    rect(boardX, boardY, boardSize, boardSize);
    
    // Draws the board with the appropriate lines and labels
    for (int i = 0; i < 10; i++) {
      fill(255);
      textSize(20);
      // Numbers on left of board
      text(str(10-i), boardL - 15, boardT + (i * sqSize) + (sqSize/2) + 5);
      // Alphabet on bottom of board
      text(char(i+97), boardL  + (i * sqSize) + (sqSize/2), boardB + 20);
      // Horizontal lines
      line(boardL, boardT + (i * sqSize), boardL + boardSize, boardT + (i * sqSize));
      // Vertical lines
      line(boardL + (i * sqSize), boardT, boardL + (i * sqSize), boardB);
    }
    
    for(int i = 0; i < battleships.length; i++){
      battleships[i].drawBattleship();
    }
  }
  
  boolean checkLoss(){
    return false;
  }
  
}
