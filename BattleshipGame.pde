color bgColor = color(75, 175, 255); 
color btnColor = color(1, 30, 105);
color btnHoverColor = color(41, 74, 158);

String gameMode;
String gameState = "MENU";


int btnWidth = 400;
int btnHeight = 100;
Button easyBtn;
Button hardBtn;
Button quitBtn;

void setup() {
  size(900, 600);
  background(bgColor);
  rectMode(CENTER);
  
  easyBtn = new Button(width/2, 200, btnWidth, btnHeight, "Easy");
  hardBtn = new Button(width/2, 350, btnWidth, btnHeight, "Hard");
  quitBtn = new Button(width/2, 500, btnWidth, btnHeight, "Quit");
}

void draw() {
  if(gameState == "MENU"){
    drawMenu();
    runMenu();
  }
  else{
    background(255, 0, 0);
    text(gameMode, width/2, height/2);
  }
}


void drawMenu(){
  textSize(70);
  textAlign(CENTER);
  text("BATTLESHIP", width/2, 90);
  
  
  
  easyBtn.drawButton();
  hardBtn.drawButton();
  quitBtn.drawButton();
}

void runMenu(){
  if(easyBtn.isMouseover(mouseX, mouseY)){
    easyBtn.setColor(btnHoverColor);
  }
  else{
    easyBtn.setColor(btnColor);
  }
  if(hardBtn.isMouseover(mouseX, mouseY)){
    hardBtn.setColor(btnHoverColor);
  }
  else{
    hardBtn.setColor(btnColor);
  }
  if(quitBtn.isMouseover(mouseX, mouseY)){
    quitBtn.setColor(btnHoverColor);
  }
  else{
    quitBtn.setColor(btnColor);
  }
}

void mouseMenu(){
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

void mousePressed(){
  if(gameState == "MENU"){
    mouseMenu();
  }
}
