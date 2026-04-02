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
  void handleMouseclick(){
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
}
