void inicialScreen() {
  image(tetrisImagen, 20, 40, width-40, 330);
  playButton = new Button(width/2, height/2+20, 800, 100, 125, 0, "JUGAR", fuente);
  playButton.display();
  configurarButton = new Button(width/2, height/2+170, 800, 100, 125, 0, "CONFIGURAR", fuente);
  configurarButton.display();
  howButton = new Button(width/2, height/2+320, 800, 100, 125, 0, "¿CÓMO JUGAR?", fuente);
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
  playButton.display();
  backButton = new Button(width/2-350, height/2+330, 350, 100, 125, 0, "VOLVER", fuente);
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
  tab1Button.display();
  tab2Button = new Button(width/2, height/2+25, 350, 100, 125, 0, "20 X 12", fuente);
  tab2Button.display();
  tab3Button = new Button(width/2, height/2+175, 350, 100, 125, 0, "23 X 14", fuente);
  tab3Button.display();
  configurarButton = new Button(width/2+350, height/2+330, 410, 100, 125, 0, "CONFIGURAR", fuente);
  configurarButton.display();
  backButton = new Button(width/2-350, height/2+330, 410, 100, 125, 0, "VOLVER", fuente);
  backButton.display();
}

void confPScreen(){
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
  monoB.display();
  doB = new Button(width/2+350, 270, 350, 70, 125, 0, "Dominó", fuente);
  doB.display();
  troB = new Button(width/2+350, 350, 350, 70, 125, 0, "Trominó", fuente);
  troB.display();
  tetroB = new Button(width/2+350, 430, 350, 70, 125, 0, "Tetrominó", fuente);
  tetroB.display();
  pentaB = new Button(width/2+350, 510, 350, 70, 125, 0, "Pentaminó", fuente);
  pentaB.display();
  nminoB = new Button(width/2+350, 590, 350, 70, 125, 0, "N-minó", fuente);
  nminoB.display();
  
  
  playButton = new Button(width/2+350, height/2+330, 350, 100, 125, 0, "JUGAR", fuente);
  playButton.display();
  backButton = new Button(width/2-350, height/2+330, 350, 100, 125, 0, "VOLVER", fuente);
  backButton.display();
}

void gameScreen() {
  tablero.display();
  scoreTab.display();
  polyominoMove.display();
  nextPolyomino.display();
  nextTablero.display();
  finalPolyomino.polPosFinal(tablero, polyominoMove);
  println(tablero.filasLlenas);
  tiempo();
}