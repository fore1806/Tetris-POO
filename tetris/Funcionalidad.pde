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
    intervalo -= 30;
  }
}

void llenarRandomColors() {
  for (int i = 0; i < 5; i ++) {
    for (int j = 0; j< 29; j ++) {
      int r = (int)random(50, 256);
      int g = (int)random(50, 256);
      int b = (int)random(50, 256);
      matrizColores[i][j] = color(r, g, b);
    }
  }
}

void coloresIniciales() {
  for (int i=0; i< 29; i++) {
    polyominoColor[i] = matrizColores[0][i];
  }
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
    } else if (continueButton.check()) {
      if (numMin==0 && numMax==29) {
        screenGame = !screenGame;
        setUpGame();
        tiempoJuego = millis();
      } else {
        screenColores = !screenColores;
      }
      screenConfP = !screenConfP;
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
