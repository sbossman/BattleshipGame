class Button {
  float x;
  float y;
  float w;
  float h;
  
  String txt;
  
  color c = color(1, 30, 105);
  
  Button(float _x, float _y, float _w, float _h, String _text){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    txt = _text;
  }
  
  void setColor(color newColor){
    c = newColor;
  }
  
  boolean isMouseover(float mousePosX, float mousePosY){
    boolean btwnX = (mousePosX < (x + (w/2.0))) && (mousePosX > (x - (w/2.0)));
    boolean btwnY = (mousePosY < (y + (h/2.0))) && (mousePosY > (y - (h/2.0)));
    return btwnX && btwnY;
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
