color bgColor = color(75, 175, 255); 
color btnColor = color(1, 30, 105);
color btnHoverColor = color(41, 74, 158);

String gameMode;
// Possible game states: "MENU," "SETUP," "GUESS," "WON," or "LOST"
String gameState = "MENU"; 


// Setting up buttons
int btnWidth = 400;
int btnHeight = 100;
Button easyBtn;
Button hardBtn;
Button quitBtn;
Button setupDoneBtn;

void setup() {
  size(900, 600);
  background(bgColor);
  rectMode(CENTER);
  
  // Establishing button positions
  easyBtn = new Button(width/2, 200, btnWidth, btnHeight, "Easy");
  hardBtn = new Button(width/2, 350, btnWidth, btnHeight, "Hard");
  quitBtn = new Button(width/2, 500, btnWidth, btnHeight, "Quit");
  
  setupDoneBtn = new Button(width/2, 550, btnWidth * 0.5, btnHeight * 0.5, "Done");
}

void draw() {
  // Runs different screens based on game state
  if(gameState == "MENU"){
    drawMenu();
  }
  else if(gameState == "SETUP"){
    drawSetup();
  }
  else{
    background(255, 0, 0);
    text("Unknown game state", width/2, height/2);
  }
}

/*
****  MENU FUNCTIONS  ****
*/

// Responsible for visuals of the menu
void drawMenu(){
  textSize(70);
  textAlign(CENTER);
  text("BATTLESHIP", width/2, 90);
  
  // Updates buttons based on where mouse is
  easyBtn.updateButton(mouseX, mouseY);
  hardBtn.updateButton(mouseX, mouseY);
  quitBtn.updateButton(mouseX, mouseY);
   
  // Draws buttons
  easyBtn.drawButton();
  hardBtn.drawButton();
  quitBtn.drawButton();
}


// Responsible for handling all mouse clicks on menu screen
void mouseClickMenu(){
  if(easyBtn.isMouseover(mouseX, mouseY)){
    gameMode = "EASY";
    gameState = "SETUP";
    background(255, 255, 0);
  }
  if(hardBtn.isMouseover(mouseX, mouseY)){
    gameMode = "HARD";
    gameState = "SETUP";
    background(0, 0, 0);
  }
  if(quitBtn.isMouseover(mouseX, mouseY)){
    exit();
  }
}

/*
****  SETUP FUNCTIONS  ****
*/
// Responsible for visuals of the setup screen
void drawSetup(){
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
  
  // Updates button based on mouse position
  setupDoneBtn.updateButton(mouseX, mouseY);
  
  // Drawing the done button
  setupDoneBtn.drawButton();
}

// Responsible for handling all mouse clicks on setup screen
void mouseClickSetup(){
  if(setupDoneBtn.isMouseover(mouseX, mouseY)){
    gameState = "GUESS";
  }
}


void mousePressed(){
  // Checks which mouse pressing function to run based on game state
  if(gameState == "MENU"){
    mouseClickMenu();
  }
  else if(gameState == "SETUP"){
    mouseClickSetup();
  }
}
