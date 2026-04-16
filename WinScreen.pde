class WinScreen extends Screen {
  Button toMenuBtn;
  
  WinScreen(){
    toMenuBtn = new Button(width/2, height/2, 400, 102, "To Menu");
  }
  
  void display(){
    background(0, 200, 90);
    textFont(Oswald40);
    textAlign(CENTER);
    text("YOU WIN", width/2, 100);
    toMenuBtn.drawButton();
  }
  
  void handleMouseclick(){
    if(toMenuBtn.isMouseover()){
      gameState = "MENU";
    }
  }
  
    void handleMousescroll() {
  }
}
