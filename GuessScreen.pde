class GuessScreen extends Screen{
  Button loseBtn;
  Button winBtn;
  
  GuessScreen(){
    loseBtn = new Button(width/2, 300, 300, 100, "Lose Game");
    winBtn = new Button(width/2, 500, 300, 100, "Win Game");
  }
  
  void display(){
    background(bgColor);
    
    winBtn.drawButton();
    loseBtn.drawButton();
  }
  
  // Responsible for handling all mouse clicks on guessing screen
  void handleMouseclick(){
    if(loseBtn.isMouseover()){
      gameState = "LOST";
    }
    if(winBtn.isMouseover()){
      gameState = "WIN";
    }
  }
}
