final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int idle = 3;
final int down = 4;
final int left = 5;
final int right = 6;
int groundhogMove = idle;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, life;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage [] soil = new PImage [6];
PImage [] stone = new PImage [2];

float groundhogX = 320.0;
float groundhogY = 80;
float box = 80;
float speed = box/16;
float timer = 0;

float soilX = 0;
float soilY = 160;

int lifeX = 10;
int lifeY = 10;

boolean downPressed, leftPressed, rightPressed;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  life = loadImage("img/life.png");
  soil[0] = loadImage("img/soil0.png");
  soil[1] = loadImage("img/soil1.png");
  soil[2] = loadImage("img/soil2.png");
  soil[3] = loadImage("img/soil3.png");
  soil[4] = loadImage("img/soil4.png");
  soil[5] = loadImage("img/soil5.png");
  stone[0] = loadImage("img/stone1.png");
  stone[1] = loadImage("img/stone2.png");
  
  playerHealth = 2;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	  stroke(255,255,0);
	  strokeWeight(5);
	  fill(253,184,19);
	  ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, soilY - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
      // soil0
      for(int i=0; i<8; i++){
        for(int j=0; j<4; j++){
          image(soil[0],soilX+i*box,soilY+j*box);
        }
      }
      // soil1
      for(int i=0; i<8; i++){
        for(int j=4; j<8; j++){
          image(soil[1],soilX+i*box,soilY+j*box);
        }
      }
      // soil2
      for(int i=0; i<8; i++){
        for(int j=8; j<12; j++){
          image(soil[2],soilX+i*box,soilY+j*box);
        }
      }
      // soil3
      for(int i=0; i<8; i++){
        for(int j=12; j<16; j++){
          image(soil[3],soilX+i*box,soilY+j*box);
        }
      }
      // soil4
      for(int i=0; i<8; i++){
        for(int j=16; j<20; j++){
          image(soil[4],soilX+i*box,soilY+j*box);
        }
      }
      // soil5
      for(int i=0; i<8; i++){
        for(int j=20; j<24; j++){
          image(soil[5],soilX+i*box,soilY+j*box);
        }
      }
      
    // Stone
      // stone1-8
      for(int i=0; i<8; i++){
        image(stone[0], soilX+i*box, soilY+i*box);
      }
      
      // stone9-16
      for(int i=0; i<8; i++){
        if(i==1 || i==2 || i==5 || i==6){
          for(int j=8; j<16; j++){
            if(j==8 || j==11 || j==12 || j==15){
              image(stone[0],soilX+i*box, soilY+j*box);
            }
          }
        }
      }
      for(int i=0; i<8; i++){
        if(i==0 || i==3 || i==4 || i==7){
          for(int j=8; j<16; j++){
            if(j==9 || j==10 || j==13 || j==14){
              image(stone[0],soilX+i*box, soilY+j*box);
            }
          }
        }
      }
      
      // stone17-24
        // [0]
        for(int i=0; i<8 ; i++){
          if(i == 1 || i==2 || i==4 || i==5 || i==7){
            for(int j=16; j<24; j+=3){
              image(stone[0],soilX+i*box,soilY+j*box);
            }
          }
        }
        for(int i=0; i<8; i++){
          if(i==0 || i==1 || i==3 || i==4 || i==6 || i==7){
            for(int j=17; j<24; j+=3){
              image(stone[0],soilX+i*box,soilY+j*box);
            }
          }
        }
        for(int i=0; i<8; i++){
          if(i==0 || i==2 || i==3 || i==5 || i==6){
            for(int j=18; j<24; j+=3){
              image(stone[0],soilX+i*box,soilY+j*box);
            }
          }
        }
        // [1]
        for(int i=2; i<8; i+=3){
          for(int j=16; j<24; j+=3){
            image(stone[1],soilX+i*box,soilY+j*box);
          }
        }
        for(int i=1; i<8; i+=3){
          for(int j=17; j<24; j+=3){
            image(stone[1],soilX+i*box,soilY+j*box);
          }
        }
        for(int i=0; i<8; i+=3){
          for(int j=18; j<24; j+=3){
            image(stone[1],soilX+i*box,soilY+j*box);
          }
        }

		// Player
      switch(groundhogMove){
        
        case idle:
          image(groundhogIdle,groundhogX,groundhogY);
          timer = 0;
          if(downPressed){
            groundhogMove = down;
          }else if(leftPressed){
            groundhogMove = left;
          }else if(rightPressed){
            groundhogMove = right;
          }
          break;
        case down:
          image(groundhogDown,groundhogX,groundhogY);
          if(soilY <= 160-20*box){
            groundhogY += speed;
            timer ++;
            if(timer == 16){
              downPressed = false;
              groundhogMove = idle;
            }
            if(groundhogY > height-box){
              groundhogY = height-box;
              downPressed = false;
              groundhogMove = idle;
            }
          }else {
            soilY -= speed;
            timer ++;
            if(timer == 16){
              downPressed = false;
              groundhogMove = idle;
            }
          }
          break;
        case left:
          image(groundhogLeft,groundhogX,groundhogY);
          groundhogX -= speed;
          timer ++;
          if(timer == 16){
            leftPressed = false;
            groundhogMove = idle;
          }
          if(groundhogX < 0){
            groundhogX = 0;
            leftPressed = false;
            groundhogMove = idle;
          }
          break;
        case right:
          image(groundhogRight,groundhogX,groundhogY);
          groundhogX += speed;
          timer ++;
          if(timer == 16){
            rightPressed = false;
            groundhogMove = idle;
          }
          if(groundhogX > width-box){
            groundhogX = width-box;
            rightPressed = false;
            groundhogMove = idle;
          }
          break;
          
      }

		// Health UI
    if(playerHealth == 5){
      for(int i = 0; i<5; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 4){
      for(int i = 0; i<4; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 3){
      for(int i = 0; i<3; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 2){
      for(int i = 0; i<2; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 1){
      for(int i = 0; i<1; i++){
        image(life, lifeX+i*70, lifeY);
      }
    }else if(playerHealth == 0){
      gameState = GAME_OVER;
      }else{
      playerHealth = 5;
    }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
        playerHealth = 2;
        groundhogX = 320;
        groundhogY = 80;
        soilY = 160;
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here
  switch(keyCode){
    case DOWN:
      downPressed = true;
      break;
    case LEFT:
      leftPressed = true;
      break;
    case RIGHT:
      rightPressed = true;
      break;
  }

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
  switch(keyCode){
    case DOWN:
      downPressed = false;
      break;
    case LEFT:
      leftPressed = false;
      break;
    case RIGHT:
      rightPressed = false;
      break;
  }
}
