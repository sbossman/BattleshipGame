class Battleship {
  int[][] positions;
  int size;
  boolean vertical;
  boolean sunk;
  PImage img;
  
  boolean selected = false;
  
  boolean illegallyPlaced = false;
  
  // TODO: Implement everything
  Battleship(int _size){
    size = _size;    
    vertical = false;
    sunk = false;
    
    positions = new int[size][2];
    for(int i = 0; i < positions.length; i++){
      positions[i][0] = -1;
      positions[i][1] = -1;
    }
    
    String imgName = "Ship " + size + ".png";
    img = loadImage(imgName);
  }
  
  void setPosition(int x, int y){
    for(int i = 0; i < size; i++){
      if(vertical){
        positions[i][0] = x;
        positions[i][1] = y + i;
      }
      else{
        positions[i][0] = x + i;
        positions[i][1] = y;
      }
    }
  }
  
  void setIllegallyPlaced(boolean ip){
    illegallyPlaced = ip;
  }
  
  void setVertical(boolean v){
    vertical = v;
  }
  
  void flipVertical(){
    vertical = !vertical;
    setPosition(positions[0][0], positions[0][1]);
  }
  
  boolean checkIfHit(int x, int y){
    for(int i = 0; i < size; i++){
      if(x == positions[i][0] && y == positions[i][1]){
        return true;
      }
    }
    return false;
  }
  
  boolean checkSunk(Coordinate[][] coordinates){
    // Iterates through positions and checks if any of them HAVEN'T
    // been guessed. If they've all been guessed, it's sunk.
    sunk = true;
    for(int i = 0; i < size; i++){
      int x = positions[i][0];
      int y = positions[i][1];
      if(!coordinates[x][y].guessed){
        sunk = false;
        return sunk;
      }
    }
    sunk = true;
    return sunk;
  }
  
  void drawBattleship(int boardX, int boardY){
    int x = 0;
    int y = 0;
    img.resize(sqSize * size, sqSize);
    
    if(positions[0][0] == -1){
      x = 700;
      y = size * 75;
    }
    else{
      x = positions[0][0] * sqSize + boardX;
      y = positions[0][1] * sqSize + boardY;
    }
    
    pushMatrix();
    translate(x, y);
    
    
    if(vertical){
      translate(sqSize, 0);
      rotate(PI/2);
    }
    
    if(gameState == "GUESS"){
      if(sunk)  tint(255, 0, 0);
      else   tint(255);
    }
    else{
      if(illegallyPlaced && selected)  tint(255, 100, 0);
      else if(illegallyPlaced)  tint(255, 0, 0);
      else if(selected)  tint(100, 255, 100);
      else  tint(255);
    }
    
    image(img, 0, 0);
    popMatrix();
  }
  
  boolean isMouseover(){
    int x = 0;
    int y = 0;
    
    if(positions[0][0] == -1){
      x = 700;
      y = size * 75;
    }
    else{
      x = (positions[0][0] * sqSize) + (int)(240 - (boardSize/2));
      y = (positions[0][1] * sqSize) + (int)(height/2 - (boardSize/2));
    }
    
    boolean btwnX = (mouseX > x) && (mouseX < x + sqSize);
    boolean btwnY = (mouseY > y) && (mouseY < y + sqSize);
    if(vertical){
      btwnY = (mouseY > y) && (mouseY < y + (size * sqSize));
      println("VERTICAL");
    }
    else{
      btwnX = (mouseX > x) && (mouseX < x + (size * sqSize));
    }
    return btwnX && btwnY;
  }
  
  void select(){
    selected = true;
  }
  
  void unselect(){
    selected = false;
  }
}
