class SetupScreen extends Screen {
  Button setupDoneBtn;
  
  SetupScreen(){
    setupDoneBtn = new Button(width/2, 550, 200, 50, "Done");
  }
  
  // Responsible for visuals of the setup screen
  void display(){
    float boardSize = 370;
    float boardX = 300;
    float boardY = height/2;
    float boardL = boardX - (boardSize/2);
    float boardB = boardY + (boardSize/2);
    float boardT = boardY - (boardSize/2);
    float sqSize = boardSize/10;
    
    background(bgColor);
    textSize(30);
    fill(255);
    text("Place your ships!", width/2, 50);
    stroke(255);
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
    
    // Squares for ships
    fill(100,100,100);
    noStroke();
    for(int i = 0; i < 5; i++){
      rect(700, 150 + i * 75, 150, 50);
    }
    
    
    // Drawing the done button
    setupDoneBtn.drawButton();
  }
  
  // Responsible for handling all mouse clicks on setup screen
  void handleMouseclick(){
    if(setupDoneBtn.isMouseover()){
      gameState = "GUESS";
    }
  }
}
