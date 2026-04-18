import gifAnimation.*;
import processing.sound.*;


class Board{
  Battleship[] battleships;
  Coordinate[][] board;
  int[][] gifBoard = new int[10][10];
  PImage img = loadImage("Water.png");
  SoundFile missS;
  SoundFile hitS;
  SoundFile sunkS;
  Gif explosion;
  Gif splash;
  
  // TODO: Implement everything
  Board(PApplet parent){
    
    // load audio
    missS = new SoundFile(parent, "Audio/SFX/53763__digifishmusic__ploppymix.wav");
    hitS = new SoundFile(parent, "Audio/SFX/636717__deevdarabbit__explosions.wav");
    sunkS = new SoundFile(parent, "Audio/SFX/ship-danger-whistle-siren.wav");
    
    // load gif
    frameRate(100);
    explosion = new Gif(parent, "Fire animation.gif");
    splash = new Gif(parent, "Water animation.gif");
    
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
    sunkS.amp(40);
    board[x][y].guess();
    for(int i = 0; i < battleships.length; i++){
      if(battleships[i].checkIfHit(x, y)){
        if (battleships[i].checkSunk(board)) {
          sunkS.play();
        }
        else {
          hitS.play();
        }
        gifBoard[x][y] = 1;
        return true;
      }
      else {
        missS.play();
      }
    }
    gifBoard[x][y] = 2;
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
    int anim = 0;
    if(gameState == "GUESS"){
      for(int x = 0; x < 10; x++){
        for(int y = 0; y < 10; y++){
          if(board[x][y].guessed){
            noStroke();
            if(board[x][y].ship) {
              fill(255, 0, 0);
            }
            else {
              fill(255);
            }
            circle(x * sqSize + boardX - (boardSize/2) + (sqSize/2), y * sqSize + boardY - (boardSize/2) + (sqSize/2), sqSize - 7);
            tint(255);
            if (gifBoard[x][y] == 1) {
              anim++;
              image(explosion, (x * sqSize + boardX - (boardSize/2) + (sqSize/2)) - 155, (y * sqSize + boardY - (boardSize/2) + (sqSize/2)) - 85, 450, 300);
              explosion.loop();
              if(explosion.isPlaying() && explosion.currentFrame() == 6){
                explosion.stop();
                anim = 0;
              }
            }
            else if (gifBoard[x][y] == 2) {
              anim++;
              image(splash, (x * sqSize + boardX - (boardSize/2) + (sqSize/2)) - 155, (y * sqSize + boardY - (boardSize/2) + (sqSize/2)) - 85, 450, 300);
              splash.loop();
              if(splash.isPlaying() && splash.currentFrame() == 6){
                splash.stop();
                anim = 0;
              }
            }
          }
        }
      }
      for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
          if(anim ==0)  gifBoard[i][j] = 0;
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
    int i = comBoard.battleships.length - 1;
    while(i >= 0){
      a = int(random(10));
      b = int(random(10));
      v = int(random(2));
      
      if(v == 1){
        comBoard.battleships[i].setVertical(true);
      }
      
      comBoard.battleships[i].setPosition(a, b);
      
      // Checking if all ships are placed legally
      if(illegalPlaceCheck()){
        continue;
      }
      
      i--;
    }
  }
  
  boolean illegalPlaceCheck() {
    boolean[] notOverEdge = new boolean[battleships.length];
    boolean[] noOverlap = new boolean[battleships.length];

    // Initializing all ships to be in valid positions
    for (int i = 0; i < battleships.length; i++) {
      notOverEdge[i] = true;
      noOverlap[i] = true;
    }

    // Checking individual ships
    for (int i = 0; i < battleships.length; i++) {
      Battleship bshp = battleships[i];
      if (bshp.positions[0][0] == -1) continue; // Checks if this ship hasn't yet been initialized

      // Checking if a ship is over the edge of the board
      if (!withinBounds(bshp.positions[bshp.size - 1]) || !withinBounds(bshp.positions[0])) {
        notOverEdge[i] = false;
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
      for (int j = 0; j < battleships.length; j++) {
        Battleship bshp2 = battleships[j];
        if (i == j || bshp2.positions[0][0] == -1) continue; // Ensures ship is initialized and a ship isn't checking itself

        for (int p = 0; p < bshp2.positions.length; p++) {
          int xB = bshp2.positions[p][0];
          int yB = bshp2.positions[p][1];
          if (xB >= x && xB < x + xSize && yB >= y && yB < y + ySize) {
            noOverlap[i] = false;
            noOverlap[j] = false;
          }
        }
      }
    }

    // Uses the previous flags to flag certain ships as illegally placed
    boolean flag = false;
    for (int i = 0; i < battleships.length; i++) {
      if (!notOverEdge[i] || !noOverlap[i]) {
        battleships[i].setIllegallyPlaced(true);
        flag = true;
      } else {
        battleships[i].setIllegallyPlaced(false);
      }
    }
    return flag;
  }
}

boolean withinBounds(int[] pos){
  boolean xWithin = pos[0] >= 0 && pos[0] < 10;
  boolean yWithin = pos[1] >= 0 && pos[1] < 10;
  return xWithin && yWithin;
}
