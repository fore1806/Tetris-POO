void inicialScreen() {
  image(tetrisImagen, 20, 40, width-40, 330);

  playButton = new Button(width/2, height/2+20, 800, 100, 125, 0, "JUGAR", fuente);
  playButton.seleccionador();
  playButton.display();
  configurarButton = new Button(width/2, height/2+170, 800, 100, 125, 0, "CONFIGURAR", fuente);
  configurarButton.seleccionador();
  configurarButton.display();
  howButton = new Button(width/2, height/2+320, 800, 100, 125, 0, "¿CÓMO JUGAR?", fuente);
  howButton.seleccionador();
  howButton.display();
}

void howScreen() {
  push();
  textFont(fuente);
  textAlign(CENTER, CENTER);
  fill(240);
  //Titulo
  textSize(80);
  text("¿CÓMO JUGAR?", width/2, 80);
  //Cuerpo
  textSize(35);
  text("Para comenzar el juego, debes seguir las pantallas", width/2, 200);
  text("de configuración. Para mover el polyomino puedes utilizar", width/2, 260);
  text("las letras A, S, D o las flechas de tu teclado. Si deseas", width/2, 320);
  text("rotar tu polyomino utiliza la tecla Q o la tecla O. Si ", width/2, 380);
  text("deseas pausar el juego oprime la tecla P. Que tambien", width/2, 440);
  text("puedes utilizar para jugar desde diferentes pantallas.", width/2, 500);
  text("Otros atajos de teclado son la tecla B para volver ", width/2, 560);
  text("a la pantalla anterior o R para ir a la pantalla de restart.", width/2, 620);
  pop();

  playButton = new Button(width/2+350, height/2+330, 350, 100, 125, 0, "JUGAR", fuente);
  playButton.seleccionador();
  playButton.display();
  backButton = new Button(width/2-350, height/2+330, 350, 100, 125, 0, "VOLVER", fuente);
  backButton.seleccionador();
  backButton.display();
}

void confTScreen() {
  push();
  textFont(fuente);
  textAlign(CENTER, CENTER);
  fill(240);
  //Titulo
  textSize(80);
  text("Escoge el tamaño del tablero", width/2, 80);
  pop();
  tab1Button = new Button(width/2, height/2-120, 350, 100, 125, 0, "19 X 10", fuente);
  tab1Button.seleccionador();
  tab1Button.display();
  tab2Button = new Button(width/2, height/2+25, 350, 100, 125, 0, "20 X 12", fuente);
  tab2Button.seleccionador();
  tab2Button.display();
  tab3Button = new Button(width/2, height/2+175, 350, 100, 125, 0, "23 X 14", fuente);
  tab3Button.seleccionador();
  tab3Button.display();
  configurarButton = new Button(width/2+350, height/2+330, 410, 100, 125, 0, "CONFIGURAR", fuente);
  configurarButton.seleccionador();
  configurarButton.display();
  backButton = new Button(width/2-350, height/2+330, 410, 100, 125, 0, "VOLVER", fuente);
  backButton.seleccionador();
  backButton.display();
}

void confPScreen() {
  push();
  textFont(fuente);
  textAlign(CENTER, CENTER);
  fill(240);
  //Titulo
  textSize(80);
  text("Escoge el n-minó", width/2, 50);
  pop();
  seleMino.display();
  monomino.display();
  domino.display();
  tromino.display();
  tetromino.display();
  pentamino.display();

  monoB = new Button(width/2+350, 190, 350, 70, 125, 0, "Monominó", fuente);
  monoB.seleccionador();
  monoB.display();
  doB = new Button(width/2+350, 270, 350, 70, 125, 0, "Dominó", fuente);
  doB.seleccionador();
  doB.display();
  troB = new Button(width/2+350, 350, 350, 70, 125, 0, "Trominó", fuente);
  troB.seleccionador();
  troB.display();
  tetroB = new Button(width/2+350, 430, 350, 70, 125, 0, "Tetrominó", fuente);
  tetroB.seleccionador();
  tetroB.display();
  pentaB = new Button(width/2+350, 510, 350, 70, 125, 0, "Pentaminó", fuente);
  pentaB.seleccionador();
  pentaB.display();
  nminoB = new Button(width/2+350, 590, 350, 70, 125, 0, "N-minó", fuente);
  nminoB.seleccionador();
  nminoB.display();
  playButton = new Button(width/2+350, height/2+330, 350, 100, 125, 0, "JUGAR", fuente);
  playButton.seleccionador();
  playButton.display();
  backButton = new Button(width/2-350, height/2+330, 350, 100, 125, 0, "VOLVER", fuente);
  backButton.seleccionador();
  backButton.display();
}

void gameScreen() {
  tablero.display();
  scoreTab.display();
  polyominoMove.display();
  nextPolyomino.display();
  nextTablero.display();
  finalPolyomino.polPosFinal(tablero, polyominoMove);
  puntajeLevel(scoreTab);
  nivel();
  if (!newScore) {
    newScore = !newScore;
  }
  //println(tablero.filasLlenas);
  tiempo();
}

void puntajeLevel(Tablero table) {
  push();
  textFont(fuente);
  textSize(35);
  textAlign(CENTER, CENTER);
  fill(table.fillColor);
  text("LEVEL", table.posX + (((table.columns/2)+0.5)*table.dimCuadro), table.posY + (2*table.dimCuadro));
  text(nivel, table.posX + (((table.columns/2)+0.5)*table.dimCuadro), table.posY + (3*table.dimCuadro));
  text("SCORE", table.posX + (((table.columns/2)+0.5)*table.dimCuadro), table.posY + (5*table.dimCuadro));
  text(puntaje, table.posX + (((table.columns/2)+0.5)*table.dimCuadro), table.posY + (6*table.dimCuadro));
  pop();
}

void scoreScreen() {
  
  continueButton = new Button(width/2, height/2+500, 350, 100, 125, 0, "CONTINUAR", fuente);
  continueButton.seleccionador();
  continueButton.display();
    
  push();
  textFont(fuente);
  textAlign(CENTER, CENTER);
  fill(240);
  //Titulo
  textSize(80);
  text("Tu puntaje fue:", width/2, 50);
  textSize(50);
  text(puntaje, width/2, 150);
  text("Jugador", width/2-300, 270);
  text("Puntaje", width/2+300, 270);

  JSONArray topScore = loadData();
  for (int i = 0; i < topScore.size(); i++) {
    JSONObject persona = topScore.getJSONObject(i);
    int puntaje = persona.getInt("puntaje");
    String nombre = persona.getString("nombre");
    text(nombre, width/2-300, 330 + 60*i);
    text(puntaje, width/2+300, 330 + 60*i);
  }
  pop();
}

void gameOverScreen(){
  image(gameOverImagen, 20, 40, width-40, 330);

  restartButton = new Button(width/2, height/2+20, 800, 100, 125, 0, "VOLVER A JUGAR", fuente);
  restartButton.seleccionador();
  restartButton.display();
  configurarButton = new Button(width/2, height/2+170, 800, 100, 125, 0, "CONFIGURAR", fuente);
  configurarButton.seleccionador();
  configurarButton.display();
  inicioButton = new Button(width/2, height/2+320, 800, 100, 125, 0, "INICIO", fuente);
  inicioButton.seleccionador();
  inicioButton.display();
}
