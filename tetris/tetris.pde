boolean screenInicial = true;
boolean screenHow = false;
boolean screenConfT = false;
boolean screenConfP = false;
boolean screenGame = false;
boolean changeTable = false;

PImage tetrisImagen;// Imagen de inicio
PImage gameOverImagen;//Imagen del game Over
PFont fuente;

int r = 21;
int c = 14;

int nMinos = 4;
int numMin = 4;
int numMax = 11;//Numero siguiente al maximo que deseamos sacar
int numT = int(random (numMin, numMax));
int numNextT = int(random (numMin, numMax));


Tablero tablero;
Tablero nextTablero;
Tablero seleMino;
Tablero scoreTab;

Polyomino polyominoMove;
Polyomino nextPolyomino;
Polyomino finalPolyomino;
Polyomino monomino;
Polyomino domino;
Polyomino tromino;
Polyomino tetromino;
Polyomino pentamino;

Button playButton;
Button configurarButton;
Button howButton;
Button backButton;
Button tab1Button;
Button tab2Button;
Button tab3Button;
Button monoB;
Button doB;
Button troB;
Button tetroB;
Button pentaB;
Button nminoB;


final int [][] arrayNumeros = {{1, 0, 1}, 
  {2, 1, 2}, 
  {3, 2, 4}, 
  {4, 4, 11}, 
  {5, 11, 29}
};

final int [][] arrayPolyominos = {  {1, 1, 1, 1}, // 0 Monomino
  {12, 10, 12, 10}, // 1 Domino I
  {56, 146, 56, 146}, //2 Tromino I
  {416, 400, 176, 304}, //3 Tromino L
  {61440, 17476, 61440, 17476}, //4 Tetromino I
  {59392, 50240, 11776, 35008}, //5 Tetromino L
  {27648, 35904, 27648, 35904}, //6 Tetromino S
  {50688, 19584, 50688, 19584}, //7 Tetromino z
  {57856, 17600, 36352, 51328}, //8 Tetromino J
  {26112, 26112, 26112, 26112}, //9 Tetromino O
  {58368, 19520, 19968, 35968}, //10 Tetromino T
  {31744, 4329604, 31744, 4329604}, //11 Pentomino I
  {209024, 145472, 137600, 276608 }, //12 
  {399488, 80000, 143552, 145664 }, //13
  {4329856, 555008, 6426752, 15392}, //14
  {4329664, 31232, 12718208, 48128  }, //15
  {405632, 210944, 137408, 14720  }, //16
  {202880, 14528, 143744, 407552 }, //17
  {4337920, 800768, 4595968, 923648 }, //18
  {4331584, 241664, 4393024, 112640 }, //19
  {462976, 79936, 135616, 276736}, //20 Pentomino T
  {342016, 200896, 468992, 397696}, //21 Pentomino U
  {68032, 270784, 467200, 460864}, // 22 Pentomino V
  {72064, 274624, 209152, 399424}, //23 Pentomino W
  {145536, 145536, 145536, 145536}, //24 Pentomino X
  {4591744, 5177344, 4331648, 991232}, //25 Pentomino Y invertido
  {4395136, 987136, 4337792, 9371648}, //26 Pentomino Y
  {201088, 276544, 201088, 276544}, //27 Pentomino Z invertido
  {397504, 80128, 397504, 80128} //28 Pentomino Z
};

color [] polyominoColor = new color [29];


int timer;  //Tiempo 
int intervalo = 300; 


void setup() {
  size(1300, 840);
  tetrisImagen = loadImage("tetris.png");
  gameOverImagen = loadImage("game_over.png");
  coloresIniciales();

  tablero = new Tablero(225, 125, r, c);
  nextTablero = new Tablero(225, 0, 4, 8, tablero, 4, 0);
  scoreTab = new Tablero(225, 0, 4, 8, tablero, 4, 1);
  seleMino = new Tablero(225, 0, 13, 9, tablero, 4, 2);
  polyominoMove = new Polyomino(polyominoColor[numT], 0, arrayPolyominos[numT], -1, nMinos, tablero);
  nextPolyomino = new Polyomino(polyominoColor[numNextT], 0, arrayPolyominos[numNextT], 1, nMinos, nextTablero);
  finalPolyomino = new Polyomino(color(0, 0, 0, 1), color(#3BE0F2), polyominoMove);

  tablero.inicialize(0);
  nextTablero.inicialize(1);
  scoreTab.inicialize(1);
  seleMino.inicialize(1);
  printArray(PFont.list());
  fuente = createFont("Comic Sans MS", 60);

  monomino = new Polyomino(polyominoColor[0], 0, arrayPolyominos[0], 2, 1, seleMino);
  domino = new Polyomino(polyominoColor[1], 0, arrayPolyominos[1], 4, 2, seleMino);
  tromino = new Polyomino(polyominoColor[2], 0, arrayPolyominos[2], 5, 3, seleMino);
  tetromino = new Polyomino(polyominoColor[4], 0, arrayPolyominos[4], 8, 4, seleMino);
  pentamino = new Polyomino(polyominoColor[11], 0, arrayPolyominos[11], 8, 5, seleMino);
}


void draw() {
  background(0);

  if (changeTable) {
    tablero = new Tablero(225, 125, r, c);
    tablero.inicialize(0);
    polyominoMove = new Polyomino(polyominoColor[numT], 0, arrayPolyominos[numT], -1, nMinos, tablero);
    nextPolyomino = new Polyomino(polyominoColor[numNextT], 0, arrayPolyominos[numNextT], 1, nMinos, nextTablero);
    finalPolyomino = new Polyomino(color(0, 0, 0, 1), color(#3BE0F2), polyominoMove);
    changeTable = !changeTable;
  }

  if (screenInicial) {
    inicialScreen();
  } else if (screenConfT) {
    confTScreen();
  } else if (screenConfP) {
    confPScreen();
  }  else if (screenHow) {
    howScreen();
  } else if (screenGame) {
    gameScreen();
  }
}



void keyPressed() {

  if ((key == 's' || key == 'S') && (!polyominoMove.colisionDownRotate(tablero, 0))) {
    polyominoMove.moveDown();
  } else if ((key == 'd' || key == 'D') && (!polyominoMove.colisionLateral(tablero, 1))/* (!polyominoMove.rightKnock(tablero))*/) {
    polyominoMove.moveRight();
  } else if ((key == 'a' || key == 'A') && (!polyominoMove.colisionLateral(tablero, 0))/*(!polyominoMove.leftKnock(tablero))*/) {
    polyominoMove.moveLeft();
  } else if ((key == 'q' || key == 'Q') && (!polyominoMove.colisionDownRotate(tablero, 1))) {
    polyominoMove.rotatePolyomino(tablero);
  }
}

void mousePressed() {
  if (screenInicial) {
    if (playButton.check()) {
      //changeScreen(screenInicial,screenGame);
      screenInicial = !screenInicial;
      screenGame = !screenGame;
    } else if (configurarButton.check()) {
      screenInicial = !screenInicial;
      screenConfT = !screenConfT;
    } else if (howButton.check()) {
      screenInicial = !screenInicial;
      screenHow = !screenHow;
    }
  } else if (screenHow) {
    if (playButton.check()) {
      screenHow = !screenHow;
      screenGame = !screenGame;
    } else if (backButton.check()) {
      screenInicial = !screenInicial;
      screenHow = !screenHow;
    }
  } else if (screenConfT) {
    if (tab1Button.check()) {
      r = 20;
      c = 12;
      changeTable = !changeTable;
    } else if (tab2Button.check()) {
      r = 21;
      c = 14;
      changeTable = !changeTable;
    } else if (tab3Button.check()) {
      r = 24;
      c = 16;
      changeTable = !changeTable;
    } else if (configurarButton.check()) {
      screenConfT = !screenConfT;
      screenConfP = !screenConfP;
    } else if (backButton.check()) {
      screenInicial = !screenInicial;
      screenConfT = !screenConfT;
    }
  } else if (screenConfP) {
    if (tab1Button.check()) {
      r = 20;
      c = 12;
      changeTable = !changeTable;
    } else if (tab2Button.check()) {
      r = 21;
      c = 14;
      changeTable = !changeTable;
    } else if (tab3Button.check()) {
      r = 24;
      c = 16;
      changeTable = !changeTable;
    } else if (playButton.check()) {
      screenGame = !screenGame;
      screenConfP = !screenConfP;
    } else if (backButton.check()) {
      screenConfP = !screenConfP;
      screenConfT = !screenConfT;
    }
  }
}


void tiempo() {
  if (millis() - timer >= intervalo) {
    if (!polyominoMove.colisionDownRotate(tablero, 0)) {
      polyominoMove.moveDown();
    } else {
      //println(tablero.filasLlenas);
      polyominoMove.savePolyomino(tablero);
      if ((!tablero.gameOver())) {
        tablero.delete();
        numT = numNextT;
        numNextT = int(random (numMin, numMax));
        polyominoMove = new Polyomino(polyominoColor[numT], 0, arrayPolyominos[numT], -1, nMinos, tablero);
        nextPolyomino = new Polyomino(polyominoColor[numNextT], 0, arrayPolyominos[numNextT], 1, nMinos, nextTablero);
        finalPolyomino = new Polyomino(color(0, 0, 0, 1), color(#3BE0F2), polyominoMove);
      }
    }
    timer = millis();  //Asignamos el valor de millis a la variable para asi empezar un nuevo "intervalo"
  }
}


void changeScreen(boolean screen1, boolean screen2) {
  screen1 = !screen1;
  screen2 = !screen2;
}


void coloresIniciales() {
  for (int i=0; i< 29; i++) {
    int r = (int)random(256);
    int g = (int)random(256);
    int b = (int)random(256);
    polyominoColor[i] = color(r, g, b);
  }
}
