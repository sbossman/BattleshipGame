class MenuScreen extends Screen{
  int btnWidth = 400;
  int btnHeight = 100;
  Button easyBtn;
  Button hardBtn;
  Button quitBtn;
  
  MenuScreen(){
    easyBtn = new Button(width/2, 200, btnWidth, btnHeight, "Easy");
    hardBtn = new Button(width/2, 350, btnWidth, btnHeight, "Hard");
    quitBtn = new Button(width/2, 500, btnWidth, btnHeight, "Quit");
  }
  
  // Responsible for visuals of the menu
  void display(){
    background(bgColor);
    textSize(70);
    textAlign(CENTER);
    text("BATTLESHIP", width/2, 90);
    
     
    // Draws buttons
    easyBtn.drawButton();
    hardBtn.drawButton();
    quitBtn.drawButton();
  }
  
  
  // Responsible for handling all mouse clicks on menu screen
  void handleMouseclick(){
    if(easyBtn.isMouseover()){
      gameMode = "EASY";
      switchToNextScene();
    }
    if(hardBtn.isMouseover()){
      gameMode = "HARD";
      switchToNextScene();
      
    }
    if(quitBtn.isMouseover()){
      exit();
    }
  }
  
  void switchToNextScene(){
    playerBoard = new Board();
    gameState = "SETUP";
  }
}
