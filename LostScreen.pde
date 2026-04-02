class LostScreen extends Screen {
  Button toMenuBtn;
  
  LostScreen(){
    toMenuBtn = new Button(width/2, height/2, 400, 100, "To Menu");
    
  }
  
  void display(){
    background(200, 50, 50);
    textSize(40);
    textAlign(CENTER);
    text("YOU LOST", width/2, 100);
    
    toMenuBtn.drawButton();
  }
  
  void handleMouseclick(){
    if(toMenuBtn.isMouseover()){
      gameState = "MENU";
    }
  }
}
