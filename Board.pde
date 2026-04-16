class Board{
  Battleship[] battleships;
  Coordinate[][] board;
  PImage img = loadImage("Water.png");
  
  // TODO: Implement everything
  Board(){
    battleships = new Battleship[5];
    for(int i = 0; i < 5; i++){
      battleships[i] = new Battleship(i + 1);
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
    int a;
    int b;
    int v;
    int i = 0;
      while(i < comBoard.battleships.length){
        a = int(random(10));
        b = int(random(10));
        v = int(random(2));
        
        if(v == 1){
          comBoard.battleships[i].setVertical(true);
        }
        
        comBoard.battleships[i].setPosition(a, b);
        
        Battleship bshp = comBoard.battleships[i];
        
        // Checking if a ship is over the edge of the board
        if (!withinBounds(bshp.positions[bshp.size - 1]) || !withinBounds(bshp.positions[0])) {
        continue;
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
            continue;
          }
        }
      }
      i++;
    }
  }
}

boolean withinBounds(int[] pos){
  boolean xWithin = pos[0] >= 0 && pos[0] < 10;
  boolean yWithin = pos[1] >= 0 && pos[1] < 10;
  return xWithin && yWithin;
}
