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
  boolean isMouseover(float mousePosX, float mousePosY){
    boolean btwnX = (mousePosX < (x + (w/2.0))) && (mousePosX > (x - (w/2.0)));
    boolean btwnY = (mousePosY < (y + (h/2.0))) && (mousePosY > (y - (h/2.0)));
    
    return btwnX && btwnY;
  }
  
  // Updates button depending on whether mouse is hovering or not
  void updateButton(float mousePosX, float mousePosY){
    if(isMouseover(mousePosX, mousePosY)){
      c = hoverColor;
    }
    else{
      c = mainColor;
    }
  }
  
  void drawButton(){
    rectMode(CENTER);
    textAlign(CENTER);
    noStroke();
    fill(c);
    rect(x, y, w, h);
    fill(255);
    textSize(40);
    text(txt, x, y + h/8);
  }
}
