class Coordinate{
  boolean guessed; // true if it's been guessed
  boolean ship; // true if ship present;
  
  Coordinate(){
    guessed = false;
    ship = false;
  }
  
  void guess() {
    guessed = true;
  }
  
}
