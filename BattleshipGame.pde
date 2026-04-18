import gifAnimation.*;
import processing.sound.*;
SoundFile bgMusic;


color bgColor = color(75, 175, 255); 
color btnColor = color(1, 30, 105);
color btnHoverColor = color(41, 74, 158);

float boardSize = 400;
int boardSq = 10;
int sqSize = int(boardSize/boardSq);

String gameMode;
// Possible game states: "MENU," "SETUP," "GUESS," "WON," or "LOST"
String gameState = "MENU"; 
HashMap<String, Screen> screens = new HashMap<String, Screen>();

PFont DejaVu20;
PFont DejaVu30;
PFont DejaVu40;
PFont Oswald40;
PFont Oswald70;

Screen currentScreen;

Board playerBoard;
Board comBoard;

int clock = 0;


void setup() {
  size(900, 600);
  background(bgColor);
  rectMode(CENTER);
  
  DejaVu20 = loadFont("DejaVu-20.vlw");
  DejaVu30 = loadFont("DejaVu-30.vlw");
  DejaVu40 = loadFont("DejaVu-40.vlw");
  Oswald40 = loadFont("Oswald-40.vlw");
  Oswald70 = loadFont("Oswald-70.vlw");
  
  // audio files
  bgMusic = new SoundFile(this, "Audio/Music/Preparing-for-Battle.ogg");

  
  // play the background music all the time
  // bgMusic.loop();
  
  // Establishing button positions
  screens.put("MENU", new MenuScreen(this));
  screens.put("SETUP", new SetupScreen(this));
  screens.put("GUESS", new GuessScreen());
  screens.put("WIN", new WinScreen());
  screens.put("LOST", new LostScreen()); 
  
  currentScreen = screens.get(gameState);
}

void draw() {
  // Runs different screens based on game state
  currentScreen = screens.get(gameState);
  currentScreen.display();
  clock++;
}

void mousePressed(){
  // Checks which mouse pressing function to run based on game state
  currentScreen.handleMouseclick();
}

void mouseWheel() {
  currentScreen.handleMousescroll();
}
