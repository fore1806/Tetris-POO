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
float posXColor;
float posYColor;
float yCuadro;
float dimCColor;


int timer;  //Tiempo 
int intervalo = 1000; 
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

void keyPressed() {
  if (screenGame) {
    if ((keyCode == 83 || keyCode == 40) && (!polyominoMove.colisionDownRotate(0))) {
      polyominoMove.moveDown();
      puntaje += nivel;
    } else if ((keyCode == 68 || keyCode == 39) && (!polyominoMove.colisionLateral(1))/* (!polyominoMove.rightKnock(tablero))*/) {
      polyominoMove.moveRight();
    } else if ((keyCode == 65 || keyCode == 37) && (!polyominoMove.colisionLateral(0))/*(!polyominoMove.leftKnock(tablero))*/) {
      polyominoMove.moveLeft();
    } else if ((key == 'q' || key == 'Q'|| key == 'O' || key == 'o') && (!polyominoMove.colisionDownRotate(1))) {
      polyominoMove.rotatePolyomino();
    }
  } else if (screenScores) {
    if (key == 'u' || key == 'U') {
      screenScores = !screenScores;
      screenGameOver = !screenGameOver;
    }
  } else if (screenColores) {
    if (key == 'u' || key == 'U') {
      screenColores = !screenColores;
      screenGame = !screenGame;
    } else if (key == 'b' || key == 'B') {
      screenColores = !screenColores;
      screenConfP = !screenConfP;
    }
  }
}

void mousePressed() {
  if (screenInicial) {
    if (playButton.check()) {
      screenInicial = !screenInicial;
      screenGame = !screenGame;
      setUpGame();
      tiempoJuego = millis();
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
      changeFacts = !changeFacts;
    } else if (tab2Button.check()) {
      r = 21;
      c = 14;
      changeFacts = !changeFacts;
    } else if (tab3Button.check()) {
      r = 24;
      c = 16;
      changeFacts = !changeFacts;
    } else if (configurarButton.check()) {
      screenConfT = !screenConfT;
      screenConfP = !screenConfP;
    } else if (backButton.check()) {
      screenInicial = !screenInicial;
      screenConfT = !screenConfT;
    }
  } else if (screenConfP) {
    if (monoB.check()) {
      nSelector(0);
      changeFacts = !changeFacts;
    } else if (doB.check()) {
      nSelector(1);
      changeFacts = !changeFacts;
    } else if (troB.check()) {
      nSelector(2);
      changeFacts = !changeFacts;
    } else if (tetroB.check()) {
      nSelector(3);
      changeFacts = !changeFacts;
    } else if (pentaB.check()) {
      nSelector(4);
      changeFacts = !changeFacts;
    } else if (nminoB.check()) {
      nSelector(5);
      changeFacts = !changeFacts;
    } else if (playButton.check()) {
      screenColores = !screenColores;
      //screenGame = !screenGame;
      screenConfP = !screenConfP;
      //setUpGame();
      //tiempoJuego = millis();
    } else if (backButton.check()) {
      screenConfP = !screenConfP;
      screenConfT = !screenConfT;
    }
  } else if (screenColores) {
    changeFacts = !changeFacts;
    colorSeleccionado(0);
  } else if (screenScores) {
    if (continueButton.check()) {
      screenScores = !screenScores;
      screenGameOver = !screenGameOver;
    }
  } else if (screenGameOver) {
    if (restartButton.check()) {
      screenGameOver = !screenGameOver;
      screenGame = !screenGame;
      setUpGame();
      tiempoJuego = millis();
    } else if (configurarButton.check()) {
      screenGameOver = !screenGameOver;
      screenConfT = !screenConfT;
    } else if (inicioButton.check()) {
      screenGameOver = !screenGameOver;
      screenInicial = !screenInicial;
    }
  }
}


void tiempo() {
  if (millis() - timer >= intervalo) {
    if (!polyominoMove.colisionDownRotate(0)) {
      polyominoMove.moveDown();
    } else {
      polyominoMove.savePolyomino();
      if ((!tablero.gameOver(0))) {
        continueGame();
      } else {
        screenGame = !screenGame;//false;
        screenScores = !screenScores;//true;
        if (newScore) {
          saveData("Felipe", puntaje);
          newScore = !newScore;
        }
      }
    }
    timer = millis();  //Asignamos el valor de millis a la variable para asi empezar un nuevo "intervalo"
  }
}





void nSelector(int num) {
  numMin = arrayNumeros[num][0];
  numMax = arrayNumeros[num][1];
}

int numMino (int num) {
  int nMino;
  if (num >= 11) {
    nMino = 5;
  } else if (num >= 4) {
    nMino = 4;
  } else if (num >= 2) {
    nMino = 3;
  } else if (num == 1) {
    nMino = 2;
  } else {
    nMino = 1;
  }
  return nMino;
}

void continueGame() {
  tablero.delete();
  score(tablero);
  tablero.setupRowsToDelete();
  numNextT = int(random (numMin, numMax));
  nMinos = numMino(numT);
  nNextMinos = numMino(numNextT);
  varNewPol();
  nextPolyomino = new Polyomino(polyominoColor[numNextT], 0, arrayPolyominos[numNextT], 2, nNextMinos, nextTablero);
  posFinalPol();
}

void posFinalPol() {
  finalPolyomino = polyominoMove.clone();
  finalPolyomino.fillColor = color(0, 0, 0, 1);
  finalPolyomino.strokeColor = color(#3BE0F2);
}

void varNewPol() {
  polyominoMove = nextPolyomino.clone();
  polyominoMove.row = -1;
  polyominoMove.table = tablero;
  polyominoMove.column = ((polyominoMove.table.columns/2) -(polyominoMove.numMono/2));
}

void setUpGame() {
  numT = int(random (numMin, numMax));
  numNextT = int(random (numMin, numMax));
  nMinos = numMino(numT);
  nNextMinos = numMino(numNextT);
  tablero = new Tablero(225, 125, r, c);
  tablero.inicialize(0);
  scoreTab = new Tablero(225, 0, 9, 9, tablero, 4, 1);
  scoreTab.inicialize(1);
  nextTablero = new Tablero(225, 0, 9, 9, tablero, 4, 0);
  nextTablero.inicialize(1);
  polyominoMove = new Polyomino(polyominoColor[numT], 0, arrayPolyominos[numT], -1, nMinos, tablero);
  nextPolyomino = new Polyomino(polyominoColor[numNextT], 0, arrayPolyominos[numNextT], 2, nNextMinos, nextTablero);
  posFinalPol();
  puntaje = 0;
  nivel = 1;
  sizeColor();
}

void sizeColor() {
  switch(nMinos) {
  case 5: 
    dimCColor = tablero.dimCuadro/2;
    break;
  case 4: 
    dimCColor = 5*tablero.dimCuadro/8;
    break;
  default:
    dimCColor = tablero.dimCuadro;
  }
}

void score(Tablero table) {
  if (table.filasAEliminar>0) {
    puntaje += 100 * pow(2, table.filasAEliminar);
  } else {
    puntaje +=0;
  }
}

JSONArray loadData() {
  JSONObject score = loadJSONObject("data/Scores.json");
  JSONArray topScore = score.getJSONArray("Top");
  return topScore;
}

void saveData(String nombre, int puntaje) {
  JSONArray topScore = loadData();
  JSONObject score;
  for (int i = 0; i < topScore.size(); i++) {
    JSONObject persona = topScore.getJSONObject(i);
    int puntajeM = persona.getInt("puntaje");
    if (puntaje > puntajeM) {
      String nameTem = persona.getString("nombre");
      int puntajeTem = persona.getInt("puntaje");
      persona.setInt("puntaje", puntaje);
      persona.setString("nombre", nombre);
      nombre = nameTem;
      puntaje = puntajeTem;
    }
  }
  score = new JSONObject();
  score.setJSONArray("Top", topScore);
  saveJSONObject(score, "data/Scores.json");
}


void nivel() {
  if ((millis()>= (tiempoJuego +10000)) && (nivel <15)) {
    tiempoJuego = millis();
    nivel += 1;
    intervalo -= 50;
  }
}

void llenarRandomColors() {
  for (int i = 0; i < 5; i ++) {
    for (int j = 0; j< 29; j ++) {
      int r = (int)random(50,256);
      int g = (int)random(50,256);
      int b = (int)random(50,256);
      matrizColores[i][j] = color(r, g, b);
    }
  }
}

void coloresIniciales() {
  for (int i=0; i< 29; i++) {
    polyominoColor[i] = matrizColores[0][i];
  }
}

//void posColor(int num) {
//  if (nMinos ==5 && num == 0) {
//    xCuadro =
//  }
//}
void showColor() {
  for (int i=0; i<5; i++) {
    for (int j = numMin; j < numMax; j++) {
      push();
      strokeWeight(2);
      fill(matrizColores[i][j]);
      float mov;
      switch(nMinos) {
      case 5: 
        mov = 450;
        break;
      case 4: 
        mov = 340;
        break;
      case 3: 
        mov = 120;
        break;
      default:
        mov = 50;
      }

      yCuadro = (height/2)- mov;
      x1Cuadro = width/2 - 500;
      x2Cuadro = width/2 + 200;
      if (j-numMin <=8) {
        posXColor = x2Cuadro + i*50;
        posYColor = yCuadro + 4.5*(j-numMin)*dimCColor;
      } else {
        posXColor = x1Cuadro + i*50;
        posYColor = yCuadro + 4.5*(j-numMin-8)*dimCColor;
      }
      square(posXColor, posYColor, dimCColor);
      pop();
    }
  }
}

void showPolyominos() {
  for (int k = numMin; k<numMax; k++) {
    push();
    strokeWeight(2);
    fill(polyominoColor[k]);
    for (int i = 0; i <= ((nMinos*nMinos)-1); i++) {
      if ((arrayPolyominos[k][0] & (1 << ((nMinos*nMinos)-1) - i)) != 0) {
        float movX;
        float movY;
        if (k-numMin <=8) {
          movX = x2Cuadro -200;
          movY = k-numMin;
        } else {
          movX = x1Cuadro -200;
          movY = k-numMin -8;
        }  
        float mov;
        switch(nMinos) {
        case 5: 
          mov = 50;
          break;
        default:
          mov = 0;
        }
        float posX = (i%nMinos)*dimCColor + movX;
        float posY = ((i/nMinos)|0) * dimCColor + movY*dimCColor*4.5 +yCuadro-mov;
        square(posX, posY, dimCColor);
      }
    }
    pop();
  }
}

void colorSeleccionado(int num) {  //Funcion para la seleccion del color
  for (int i = 0; i<5; i++) {  //Funcion para evaluar la posicion del mouse respecto a los cuadro de colores
    for (int j=numMin; j<numMax; j++) {
      float xEvaluador;
      float yEvaluador;
      if (j-numMin <=8) {
        xEvaluador = x2Cuadro + i*50;
        yEvaluador = yCuadro + 4.5*(j-numMin)*dimCColor;
      } else {
        xEvaluador = x1Cuadro + i*50;
        yEvaluador = yCuadro + 4.5*(j-numMin-8)*dimCColor;
      }
      if ((mouseX>xEvaluador) && (mouseX<(xEvaluador + dimCColor)) && (mouseY>yEvaluador) && (mouseY<(yEvaluador + dimCColor))) {
        if (num==0) {
          polyominoColor[j] = matrizColores[i][j];  //Se asigna al arreglo de los colores de los tetrominos el color clickeado
        } else {
          push();
          noFill();
          strokeWeight(4);
          stroke(#3BE0F2);
          square(xEvaluador, yEvaluador, dimCColor);
          pop();
        }
      }
    }
  }
}

void coloresScreen() {
  showColor();
  showPolyominos();
  colorSeleccionado(1);
}
