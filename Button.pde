class Button {
  float x;
  float y;
  float w;
  float h;
  
  String txt;
  
  color mainColor = color(1, 30, 105);
  color hoverColor = color(41, 74, 158);
  color c = mainColor;
  
  
  Button(float _x, float _y, float _w, float _h, String _text){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    txt = _text;
  }
  
  // Sets colors of button
  void setColor(color newColor, color newHoverColor){
    mainColor = newColor;
    hoverColor = newHoverColor;
  }
  
  // Checks if mouse within button bounds
  boolean isMouseover(){
    boolean btwnX = (mouseX < (x + (w/2.0))) && (mouseX > (x - (w/2.0)));
    boolean btwnY = (mouseY < (y + (h/2.0))) && (mouseY > (y - (h/2.0)));
    
    return btwnX && btwnY;
  }
  
  void drawButton(){
    if(isMouseover()){
      c = hoverColor;
    }
    else{
      c = mainColor;
    }
    
    rectMode(CENTER);
    textAlign(CENTER);
    noStroke();
    fill(c);
    rect(x, y, w, h);
    fill(255);
    textFont(DejaVu40);
    text(txt, x+1, y + 15);
  }
}
