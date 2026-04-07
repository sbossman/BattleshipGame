color bgColor = color(75, 175, 255); 
color btnColor = color(1, 30, 105);
color btnHoverColor = color(41, 74, 158);

float boardSize = 370;
int boardSq = 10;
int sqSize = int(boardSize/boardSq);

String gameMode;
// Possible game states: "MENU," "SETUP," "GUESS," "WON," or "LOST"
String gameState = "MENU"; 
HashMap<String, Screen> screens = new HashMap<String, Screen>();

Screen currentScreen;

Board playerBoard;
Board comBoard;

void setup() {
  size(900, 600);
  background(bgColor);
  rectMode(CENTER);
  
  // Establishing button positions
  screens.put("MENU", new MenuScreen());
  screens.put("SETUP", new SetupScreen());
  screens.put("GUESS", new GuessScreen());
  screens.put("WIN", new WinScreen());
  screens.put("LOST", new LostScreen()); 
  
  currentScreen = screens.get(gameState);
  
  
}

void draw() {
  // Runs different screens based on game state
  
  currentScreen = screens.get(gameState);
  currentScreen.display();
}



void mousePressed(){
  // Checks which mouse pressing function to run based on game state
  currentScreen.handleMouseclick();
}
