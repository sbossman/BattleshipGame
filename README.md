# About Our Battleship Game
## Premise
What is the nature of the gameplay? That is, what challenges will the player face? What actions will the player take to overcome those challenges?
Our project will be a version of the game “Battleship.” This means that the user will be able to place ships, and then guess where the opponent’s ships are. Battleships will be placed on a 10-by-10 grid, and may be placed horizontally or vertically. The user must find where their opponent's ships are, and then sink them. In order to sink a ship, they must guess every position on the grid that the ship is located at.
## Victory
What is the victory condition for the game? What is the player trying to achieve?
The victory condition for the game is the user “sinking” all of their opponent’s ships. This means guessing every position an opponent’s ship is at. For the opponent to win, they must sink all of the user’s ships.
## Interaction
What is the player's interaction model (mouse/keyboard)?
The player will be able to interact with the game using the mouse. This will allow the user to select the gamepiece, rotate it, and place it on the board. They will also be able to guess battleship locations using the mouse as well. I am not sure if we need to incorporate both keyboard and mouse. If that is the case, we could use the mouse to select grid spaces and ship type during placement, and the keyboard to move, place, and rotate ships during placement.
## Structure
What is the general structure of the game? What is going on in each mode, and what function does each mode fulfill?
The structure of the game is that there are two modes of the game - easy and hard. In easy mode, the computer will randomly guess battleship positions, while hard mode will have an algorithm where it guesses the new possible positions of the battleship.
There will be quite a few different “stages” of the game, listed below:
- Introduction menu: Where a player will start, quit, and select difficulty level
- Board setup: Where a player will place their ships
- Ship Guessing: Where a player will guess locations of the computer’s ships
- Finish Screen: Where a player will be able to see if they win or lose the game
## Narrative
Does the game have a narrative or story as it goes along? If so, summarize the plot.
There is no narrative or story to the game, although there is a little bit of a premise that the user is a military officer attempting to deduce where the enemy ships are.
## Appeal
Why would anyone want to play this game? What sort of people would be attracted to this game?
People who like games of deduction and guessing would enjoy this game. People would want to play this game because it involves an interesting challenge to guess locations of ships. 
## Installation
In order to run this game, you will need to add the sound library into your instance of Processing. this allows this game to have SFXs and music; and can be done by: 
- clicking "Sketch" on the toolbar
- Selecting "Manage Libraries" from "Import Library >"
- Searching and clicking "Sound" in the contribution Manager
- Clicking install to install the library 

