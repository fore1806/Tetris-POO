import processing.sound.*;

boolean screenInicial = true;
boolean screenHow = false;
boolean screenConfT = false;
boolean screenConfP = false;
boolean screenColores = false;
boolean screenGame = false;
boolean screenScores = false;
boolean screenGameOver = false;
boolean changeFacts = false;
boolean newScore = true;

SoundFile principalS;
float L;  //tiempo del sonido

PImage tetrisImagen;// Imagen de inicio
PImage gameOverImagen;//Imagen del game Over
PFont fuente;

int r = 21;
int c = 14;

int nMinos = 4;
int nNextMinos = 4;
int numMin = 4;
int numMax = 11;//Numero siguiente al maximo que deseamos sacar
int numT;
int numNextT;

int puntaje = 0;
int nivel = 1;


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
Button continueButton;
Button restartButton;
Button inicioButton;


final int [][] arrayNumeros = {{0, 1}, //monomino
  {1, 2}, //domino
  {2, 4}, //tromino
  {4, 11}, //tetramino
  {11, 29}, //pentamino 
  {0, 29}//n-mino
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
color [][] matrizColores = new color [5][29];
float x1Cuadro;
float x2Cuadro;
//float posXColor;
//float posYColor;
float yCuadro;
float dimCColor;


int timer;  //Tiempo 
int intervalo = 700; 
int tiempoJuego;

int x;


void setup() {
  size(1450, 840);
  principalS = new SoundFile(this, "tetris.mp3");
  principalS.play();
  tetrisImagen = loadImage("tetris.png");
  gameOverImagen = loadImage("game_over.png");
  llenarRandomColors();
  coloresIniciales();

  setUpGame();

  seleMino = new Tablero(225, 0, 13, 9, tablero, 4, 2);
  seleMino.inicialize(1);
  fuente = createFont("Comic Sans MS", 60);

  monomino = new Polyomino(polyominoColor[0], 0, arrayPolyominos[0], 2, 1, seleMino);
  domino = new Polyomino(polyominoColor[1], 0, arrayPolyominos[1], 4, 2, seleMino);
  tromino = new Polyomino(polyominoColor[2], 0, arrayPolyominos[2], 5, 3, seleMino);
  tetromino = new Polyomino(polyominoColor[4], 0, arrayPolyominos[4], 8, 4, seleMino);
  pentamino = new Polyomino(polyominoColor[11], 0, arrayPolyominos[11], 8, 5, seleMino);
}


void draw() {
  background(0);

  if (changeFacts) {
    setUpGame();
    changeFacts = !changeFacts;
  }

  if (screenInicial) {
    inicialScreen();
  } else if (screenConfT) {
    confTScreen();
  } else if (screenConfP) {
    confPScreen();
  } else if (screenColores) {
    coloresScreen();
  } else if (screenHow) {
    howScreen();
  } else if (screenGame) {
    gameScreen();
  } else if (screenScores) {
    scoreScreen();
  } else if (screenGameOver) {
    gameOverScreen();
  }

  println(puntaje);
}
