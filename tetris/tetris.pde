//Juego n-tris Programación Orientada a Objetos 

import processing.sound.*;
//Boleanos de las pantallas
boolean screenName = true;
boolean screenInicial = false;
boolean screenHow = false;
boolean screenConfT = false;
boolean screenConfP = false;
boolean screenColores = false;
boolean screenGame = false;
boolean screenPause = false;
boolean screenScores = false;
boolean screenGameOver = false;
//Boleanos para cambiar configuraciones o evaluar un nuevo puntaje
boolean changeFacts = false;
boolean newScore = true;
//Objetos de sonido y variables para controlar la velocidad de los mismos
SoundFile principalS;
SoundFile deleteS;
float L2 = 0.9;  //rate del sonido de eliminar
float soundTime;
float timeReSound = 0;
//Objetos de imagen y Fuente
PImage tetrisImagen;// Imagen de inicio
PImage gameOverImagen;//Imagen del game Over
PFont fuente;
//Configuración inicial del juego, tetris en un tablero 20X12
int r = 21;
int c = 14;
int nMinos = 4;
int nNextMinos = 4;
int numMin = 4;
int numMax = 11;//Numero siguiente al maximo que deseamos sacar
int numT;
int numNextT;
//Configuración inicial del puntaje y el nivel, y un nombre por defecto para los puntajes
int puntaje = 0;
int nivel = 1;
String nombre = "---";
//Objetos de la clase Tablero
Tablero tablero;
Tablero nextTablero;
Tablero seleMino;
Tablero scoreTab;
//Objetos de la clase Polyomino
Polyomino polyominoMove;
Polyomino nextPolyomino;
Polyomino finalPolyomino;
Polyomino monomino;
Polyomino domino;
Polyomino tromino;
Polyomino tetromino;
Polyomino pentamino;
//Objetos de la clase Button
Button pazhitnovB; //0
Button obamaB; //1
Button gandhiB; //2
Button uribeB; //3
Button gaboB; //4
Button newtonB; //5
Button continueButton; //6
Button playButton; //7
Button configurarButton; //8
Button howButton; //9
Button backButton; //10
Button tab1Button; //11
Button tab2Button; //12
Button tab3Button; //13
Button monoB; //14
Button doB; //15
Button troB; //16
Button tetroB; //17
Button pentaB; //18
Button nminoB;  //19
Button restartButton;  //20
Button inicioButton;  //21

//Boton de pausa
final int pauseBottonX = 1250;
final int pauseBottonY = 100;
final int radioPauseButton = 50;

//Arreglo de tipo Button para almacenar los objetos Button y asi mostrarlos mas facilmente
Button [] arrayButton = new Button[22];
//Arreglo que define los numeros minimos y maximos para obtener el numero random para elegir el polyomino
final int [][] arrayNumeros = {{0, 1}, //monomino
  {1, 2}, //domino
  {2, 4}, //tromino
  {4, 11}, //tetramino
  {11, 29}, //pentamino 
  {0, 29}//n-mino
};
//Arreglo con los numeros decimales que representan cada binario de los polyominos del juego
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
  {209024, 145472, 137600, 276608 }, //12 Pentomino F
  {399488, 80000, 143552, 145664 }, //13 Pentomino F invertido
  {4329856, 555008, 6426752, 15392}, //14 Pentomino L invertida
  {4329664, 31232, 12718208, 48128  }, //15 Pentomino L
  {405632, 210944, 137408, 14720  }, //16 Pentomino P invertida
  {202880, 14528, 143744, 407552 }, //17 Pentomino P
  {4337920, 800768, 4595968, 923648 }, //18 Pentomino N invertida
  {4331584, 241664, 4393024, 112640 }, //19 Pentomino N
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
//Variables globales referentes a colores en la pantalla de colores
color [] polyominoColor = new color [29];
color [][] matrizColores = new color [5][29];
float x1Cuadro;
float x2Cuadro;
float yCuadro;
float dimCColor;
//Funciones del tiempo
int timer;  //Tiempo 
int intervalo = 700; 
int tiempoJuego;

int numVolver; //Variable auxiliar para saber si se debe ir a la pantalla de inicio o a la de pause cuando estemos en la de como jugar
float posTX;
float posTY;



void setup() {
  size(1450, 840);
  principalS = new SoundFile(this, "tetris.mp3"); //Inicializamos el objeto que suena durante el juego
  deleteS = new SoundFile(this, "eliminacion.mp3"); //Inicializamos el objeto que suena cuando se elimina una fila
  principalS.play();
  principalS.amp(0.3); //Se hace sonar mas bajo
  deleteS.rate(L2);  //Se configura la velocidad de reproduccion del sonido
  soundTime = principalS.duration()*1000;
  tetrisImagen = loadImage("tetris.png");  //Inicializamos el objeto para la imagen de inicio
  gameOverImagen = loadImage("game_over.png");  //Inicializamos el objeto para la imagen de game over
  llenarRandomColors();  //Asignamos los colores al selector
  coloresIniciales();  //Asignamos colores iniciales a los polyominos
  setUpGame();  //Se setea el juego
  seleMino = new Tablero(225, 0, 13, 9, tablero, 4, 2);  //Objeto para la pantalla de seleccion de polyomino
  seleMino.inicialize(1);  //Tiene borde superior
  fuente = createFont("Comic Sans MS", 60);  //Se define el objeto fuente
  //Se inicializan los objetos a mostrar en el la pantalla para seleccionar el tamañano
  monomino = new Polyomino(polyominoColor[0], 0, arrayPolyominos[0], 2, 1, seleMino);
  domino = new Polyomino(polyominoColor[1], 0, arrayPolyominos[1], 4, 2, seleMino);
  tromino = new Polyomino(polyominoColor[2], 0, arrayPolyominos[2], 5, 3, seleMino);
  tetromino = new Polyomino(polyominoColor[4], 0, arrayPolyominos[4], 8, 4, seleMino);
  pentamino = new Polyomino(polyominoColor[11], 0, arrayPolyominos[11], 8, 5, seleMino);
  buttonArray();  //Se inicializa el arreglo de Botones
}


void draw() {
  background(0);
  
  reSound();  //Volver a poner la cancion

  if (changeFacts) {  //Se debe setear nuevamente el juego con las configuraciones especificadas
    setUpGame();
    changeFacts = !changeFacts;
  }

  //Condicionales para saber que pantalla se debe mostrar
  if (screenName) nameScreen();
  else if (screenInicial) inicialScreen();
  else if (screenConfT) confTScreen();
  else if (screenConfP) confPScreen();
  else if (screenColores) coloresScreen();
  else if (screenHow) howScreen();
  else if (screenGame) gameScreen();
  else if (screenPause) pauseScreen();
  else if (screenScores) scoreScreen();
  else if (screenGameOver) gameOverScreen();
    
}
