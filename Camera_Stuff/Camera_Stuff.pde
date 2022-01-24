import java.awt.Robot;
color black = #000000; // stone Bricks
color white = #FFFFFF; //nothing
color lightblue = #7092BE; //mossyStone

float rotx, roty;

//textures
PImage mossyStone;
PImage dirtBlock;
PImage stoneBrick;

//map variables
int gridSize;
PImage map;

Robot rbt;

boolean skipFrame;

boolean wkey, akey, skey, dkey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ;
float leftRightHeadAngle, upDownHeadAngle;


void setup() {
  size(displayWidth, displayHeight, P3D);
  textureMode(NORMAL);
  wkey = akey = skey = dkey = false;
  eyeX = width/2;
  eyeY = 9*height/11;
  eyeZ = 0;
  focusX = width/2;
  focusY = height/2;
  focusZ = 10;
  upX = 0;
  upY = 1;
  upZ = 0;

  //initialize map
  map = loadImage("map.png");
  gridSize = 100;
  leftRightHeadAngle = radians(90);
   noCursor();

  dirtBlock = loadImage("Grass_Block_Bottom.png");
  mossyStone = loadImage("Mossy_Stone_Bricks.png");
  stoneBrick = loadImage("Stone_Bricks.png");

  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }

  skipFrame = false;
}

void draw() {
  background(0);

  pointLight(255, 255, 255, eyeX, eyeY, eyeZ);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, upX, upY, upZ);
  drawFloor(-2000, 2000, height, gridSize);
  drawFloor(-2000, 2000, height-gridSize*4, gridSize);
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5);
  popMatrix();
}


void drawFloor(int start, int end, int level, int gap) {
  stroke(255);
  int x = start;
  int z = start;
  while (z < end) {
    texturedCube(x, level, z, dirtBlock, gap);
    x = x + gap;
    if (x >= end) {
      x = start;
      z = z + gap;
    }
  }
}


void controlCamera() {
  if (wkey) {
    eyeZ = eyeZ + sin(leftRightHeadAngle)*10;
    eyeX = eyeX + cos(leftRightHeadAngle)*10;
  }
  if (skey) {
    eyeZ = eyeZ - sin(leftRightHeadAngle)*10;
    eyeX = eyeX - cos(leftRightHeadAngle)*10;
  }
  if (akey) {
    eyeZ = eyeZ - sin(leftRightHeadAngle + radians(90))*10;
    eyeX = eyeX - cos(leftRightHeadAngle + radians(90))*10;
  }
  if (dkey) {
    eyeZ = eyeZ - sin(leftRightHeadAngle - radians(90))*10;
    eyeX = eyeX - cos(leftRightHeadAngle - radians(90))*10;
  }

  if (skipFrame == false) {
    leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
    upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.01;
  }

  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle < -PI/2.5) upDownHeadAngle = -PI/2.5;

  focusX = eyeX + cos(leftRightHeadAngle)*300;
  focusZ = eyeZ + sin(leftRightHeadAngle)*300;

  focusY = eyeY + tan(upDownHeadAngle)*300;

  if (mouseX > width-2) {
    skipFrame = true;
    rbt.mouseMove(3, mouseY);
  } else if (mouseX < 2) {
    skipFrame = true;
    rbt.mouseMove(width-3, mouseY);
  } else {
    skipFrame = false;
  }
}


void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);
      if (c == lightblue) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, mossyStone, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, mossyStone, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, mossyStone, gridSize);
      }
      if (c == black) {
        texturedCube(x*gridSize-2000, height-gridSize, y*gridSize-2000, stoneBrick, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*2, y*gridSize-2000, stoneBrick, gridSize);
        texturedCube(x*gridSize-2000, height-gridSize*3, y*gridSize-2000, stoneBrick, gridSize);
      }
    }
  }
}


void keyPressed() {
  if (key == 'W' || key == 'w') wkey = true;
  if (key == 'A' || key == 'a') akey = true;
  if (key == 'D' || key == 'd') dkey = true;
  if (key == 'S' || key == 's') skey = true;
}


void keyReleased() {
  if (key == 'W' || key == 'w') wkey = false;
  if (key == 'A' || key == 'a') akey = false;
  if (key == 'D' || key == 'd') dkey = false;
  if (key == 'S' || key == 's') skey = false;
}
