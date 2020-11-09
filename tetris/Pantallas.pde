void nameScreen() {
  image(tetrisImagen, 20, 20, width-40, 330);
  push();
  textFont(fuente);
  textAlign(CENTER, CENTER);
  fill(240);
  //Titulo
  textSize(80);
  text("Escoge tu Nombre", width/2, 370);
  pop();
  pazhitnovB = new Button(width/2 - 400, height/2+50, 400, 60, 125, 0, "Pázhitnov", fuente);
  obamaB = new Button(width/2 - 400, height/2+120, 400, 60, 125, 0, "Obama", fuente);
  gandhiB  = new Button(width/2 - 400, height/2+190, 400, 60, 125, 0, "Gandhi", fuente);
  uribeB = new Button(width/2 + 400, height/2+50, 400, 60, 125, 0, "Uribe", fuente);
  newtonB = new Button(width/2 + 400, height/2+120, 400, 60, 125, 0, "Newton", fuente);
  gaboB  = new Button(width/2 + 400, height/2+190, 400, 60, 125, 0, "Gabo", fuente);
  continueButton = new Button(width/2, height/2+300, 550, 100, 125, 0, "CONTINUAR", fuente);
  buttonArray();
  mostrador(0, 6);
}

void inicialScreen() {
  numVolver = 0;
  image(tetrisImagen, 20, 40, width-40, 330);
  playButton = new Button(width/2, height/2+20, 800, 100, 125, 0, "JUGAR", fuente);
  configurarButton = new Button(width/2, height/2+170, 800, 100, 125, 0, "CONFIGURAR", fuente);
  howButton = new Button(width/2, height/2+320, 800, 100, 125, 0, "¿CÓMO JUGAR?", fuente);
  buttonArray();
  mostrador(7, 9);
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
  backButton = new Button(width/2-350, height/2+330, 350, 100, 125, 0, "VOLVER", fuente);
  buttonArray();
  mostrador(9, 10);
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
  tab2Button = new Button(width/2, height/2+25, 350, 100, 125, 0, "20 X 12", fuente);
  tab3Button = new Button(width/2, height/2+175, 350, 100, 125, 0, "23 X 14", fuente);
  backButton = new Button(width/2-350, height/2+330, 410, 100, 125, 0, "VOLVER", fuente);
  configurarButton = new Button(width/2+350, height/2+330, 410, 100, 125, 0, "CONFIGURAR", fuente);
  buttonArray();
  mostrador(8, 8);
  mostrador(10, 13);
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
  doB = new Button(width/2+350, 270, 350, 70, 125, 0, "Dominó", fuente);
  troB = new Button(width/2+350, 350, 350, 70, 125, 0, "Trominó", fuente);
  tetroB = new Button(width/2+350, 430, 350, 70, 125, 0, "Tetrominó", fuente);
  pentaB = new Button(width/2+350, 510, 350, 70, 125, 0, "Pentaminó", fuente);
  nminoB = new Button(width/2+350, 590, 350, 70, 125, 0, "N-minó", fuente);
  continueButton = new Button(width/2+350, height/2+330, 450, 100, 125, 0, "CONTINUAR", fuente);
  backButton = new Button(width/2-350, height/2+330, 450, 100, 125, 0, "VOLVER", fuente);
  buttonArray();
  mostrador(6, 6);
  mostrador(10, 10);
  mostrador(14, 19);
}

void coloresScreen() {
  showColor();
  showPolyominos();
  colorSeleccionado(1);
  push();
  textFont(fuente);
  textAlign(CENTER, CENTER);
  fill(240);
  textSize(50);
  text("Usa N para", posTX, posTY);
  text("continuar", posTX, posTY+60);
  pop();
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
  pauseBotton();
  if (!newScore) {
    newScore = !newScore;
  }
  tiempo();
}

void pauseScreen() {
  numVolver = 1;
  continueButton = new Button(width/2, height/2-300, 800, 100, 125, 0, "CONTINUAR", fuente);
  restartButton = new Button(width/2, height/2-100, 800, 100, 125, 0, "VOLVER A EMPEZAR", fuente);
  howButton = new Button(width/2, height/2+100, 800, 100, 125, 0, "¿CÓMO JUGAR?", fuente);
  inicioButton = new Button(width/2, height/2+300, 800, 100, 125, 0, "INICIO", fuente);
  buttonArray();
  mostrador(6, 7);
  mostrador(20, 21);
}

void scoreScreen() {
  push();
  textFont(fuente);
  textAlign(CENTER, CENTER);
  fill(240);
  //Titulo
  textSize(80);
  text("Tu puntaje fue:", width/2, 50);
  textSize(50);
  text(puntaje, width/2, 150);
  text("Jugador", width/2-300, 240);
  text("Puntaje", width/2+300, 240);
  textSize(50);
  text("Usa N para continuar", width/2, height-50);
  //Mostrar los mejores puntajes
  JSONArray topScore = loadData();
  for (int i = 0; i < topScore.size(); i++) {
    JSONObject persona = topScore.getJSONObject(i);
    int puntaje = persona.getInt("puntaje");
    String nombre = persona.getString("nombre");
    text(nombre, width/2-300, 300 + 60*i);
    text(puntaje, width/2+300, 300 + 60*i);
  }
  pop();
}

void gameOverScreen() {
  image(gameOverImagen, 20, 40, width-40, 330);
  restartButton = new Button(width/2, height/2+20, 800, 100, 125, 0, "VOLVER A JUGAR", fuente);
  configurarButton = new Button(width/2, height/2+170, 800, 100, 125, 0, "CONFIGURAR", fuente);
  inicioButton = new Button(width/2, height/2+320, 800, 100, 125, 0, "INICIO", fuente);
  buttonArray();
  mostrador(8, 8);
  mostrador(20, 21);
}

//Funcion para postrar los datos de nivel y puntaje
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

//Funcion para mostrar los cuadritos de colores en la pantalla de seleccion de colores
void showColor() {
  for (int i=0; i<5; i++) {
    for (int j = numMin; j < numMax; j++) {
      push();
      strokeWeight(2);
      fill(matrizColores[i][j]);
      float mov;
      float posXColor;
      float posYColor;
      x2Cuadro = width/2 - 50;
      switch(nMinos) {
      case 5: 
        mov = 370;
        x2Cuadro = width/2 + 300;
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
      x1Cuadro = width/2 - 400;
      if (j-numMin <=8) {
        posXColor = x2Cuadro + i*50;
        posYColor = yCuadro + 4.5*(j-numMin)*dimCColor;
      } else {
        posXColor = x1Cuadro + i*50;
        posYColor = yCuadro + 4.5*(j-numMin-9)*dimCColor;
      }
      square(posXColor, posYColor, dimCColor);
      pop();
    }
  }
}

//Funcion para mostrar los polyominos en la pantalla de seleccion de color
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
          movY = k-numMin -9;
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
        yEvaluador = yCuadro + 4.5*(j-numMin-9)*dimCColor;
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

//Definir el tamaño del cuadro para dibujar los polyominos y los cuadros
void sizeColor() {
  switch(nMinos) {
  case 5: 
    dimCColor = 20;
    posTX = width/2 -15;
    posTY = height/2;
    break;
  case 4: 
    dimCColor = 25;
    posTX = width/2 +400;
    posTY = height/2;
    break;
  default:
    dimCColor = 40;
    posTX = width/2;
    posTY = height/2 + 250;
  }
}

//Guardamos los botones en un array
void buttonArray() {
  arrayButton[0] = pazhitnovB; //0
  arrayButton[1] = obamaB; //1
  arrayButton[2] =  gandhiB; //2
  arrayButton[3] =uribeB; //3
  arrayButton[4]= gaboB; //4
  arrayButton[5]= newtonB; //5
  arrayButton[6]= continueButton; //6
  arrayButton[7]= howButton; //7
  arrayButton[8]= configurarButton; //8
  arrayButton[9]= playButton; //9
  arrayButton[10] =backButton; //10
  arrayButton[11]= tab1Button; //11
  arrayButton[12]= tab2Button; //12
  arrayButton[13] =tab3Button; //13
  arrayButton[14]= monoB; //14
  arrayButton[15]= doB; //15
  arrayButton[16]= troB; //16
  arrayButton[17]= tetroB; //17
  arrayButton[18] =pentaB; //18
  arrayButton[19]= nminoB;  //19
  arrayButton[20]= restartButton;  //20
  arrayButton[21] =inicioButton;  //21
}

//Metodo para mostrar botones, convierte mas de 2 lineas de codigo en 2
void mostrador(int num1, int num2) {
  for (int i = num1; i<=num2; i++) {
    arrayButton[i].seleccionador();
    arrayButton[i].display();
  }
}

//Funcion para dibujar el boton de pausa
void pauseBotton() {
  push();
  float d = dist(mouseX, mouseY, pauseBottonX, pauseBottonY);
  if (d<radioPauseButton) {
    strokeWeight(7);
    stroke(#3BE0F2);
  } else stroke(0);
  ellipseMode(RADIUS);
  fill(tablero.fillColor);
  circle(pauseBottonX, pauseBottonY, radioPauseButton);
  fill(polyominoMove.strokeColor);
  noStroke();
  rect(pauseBottonX-30, pauseBottonY-30, 20, 60);
  rect(pauseBottonX+10, pauseBottonY-30, 20, 60);
  pop();
}
