class Tablero extends Figure {

  int rows;
  int columns;
  int dimCuadro;
  int[] filasLlenas = new int [5];
  int filasAEliminar;
  ArrayList<color[]> repMemoria;

  Tablero(color color1, color color2, int r, int c, Tablero table, int numCols, int numEv) {
    super(color1, color2);
    posY = numCols*table.dimCuadro;
    rows = r;
    columns = c;
    dimCuadro = table.dimCuadro;
    repMemoria = new ArrayList<color[]>();
    if (numEv == 0) {
      posX = ((width-table.columns*dimCuadro)/4)-((columns/2)*dimCuadro);
    } else if (numEv == 1) {
      posX = 3*width/4+table.columns*dimCuadro/4-dimCuadro*columns/2;
    } else {
      posX = ((width-table.columns*dimCuadro)/2)-((columns/2)*dimCuadro);
    }
  }

  Tablero(color color1, color color2, int r, int c) {
    super(color1, color2);
    rows = r;
    columns = c;
    dimCuadro = height/rows;
    posX = width/2-((columns/2)*dimCuadro);
    repMemoria = new ArrayList<color[]>();
  }

  void inicialize(int num) {
    for (int k = 0; k < rows; k++) {
      repMemoria.add(new color[columns]);
    }

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        if (j == 0 || j == columns - 1 || i == rows - 1) {
          repMemoria.get(i)[j] = fillColor;  //Color gris en los cuadros del borde
        } else {
          repMemoria.get(i)[j] = 0;   //Color negro en el tablero (Donde caen los tetrominos)
        }
      }
    }

    if (num == 1) {
      for (int j = 1; j<columns-1; j++) {
        repMemoria.get(0)[j]=fillColor;
      }
    }

    gameOver(1);
  }

  void display() {
    for (int i=0; i < rows; i++) {
      push();
      stroke(strokeColor);
      line(posX, i*dimCuadro+posY, posX+columns*dimCuadro, i*dimCuadro+posY);
      pop();
      for (int j=0; j < columns; j++) {
        push();
        stroke(strokeColor);
        line((j*dimCuadro)+posX, posY, (j*dimCuadro)+posX, posY+rows*dimCuadro);
        pop();
        if (repMemoria.get(i)[j] != 0) {  //Solo dibujamos los cuadros que no son ceros (posiciones vacias)
          push();
          stroke(0);
          strokeWeight(2);
          fill(repMemoria.get(i)[j]);
          square((j*dimCuadro)+posX, i*dimCuadro+posY, dimCuadro);
          pop();
        }
      }
    }
  }

  void completedRows() {
    for (int i = rows - 2; i >= 0; i--) {  //Primero recorremos para ver cuales estan completas
      int j = 0;
      for (j = 1; j < columns-1 && repMemoria.get(i)[j] != 0; j++) {
      }
      if (j == columns-1) {
        filasLlenas[filasAEliminar] = i;  //Si esta completa la añadimos al arrelo
        filasAEliminar += 1;
      }
    }
  }

  void deleteRows() {
    for (int k=0; k<4 && (filasLlenas[k]!=rows-1); k++) {  //Eliminamos todas las filas completas
      repMemoria.remove(filasLlenas[k]);
    }
  }

  void addRows() {
    for (int k=0; k<4 && (filasLlenas[k]!=rows-1); k++) {  //Finalmente añadimos las filas que se eliminaron en el paso anterior
      repMemoria.add(0, new color[columns]);
      repMemoria.get(0)[0] = fillColor;
      repMemoria.get(0)[columns-1] = fillColor;
    }
  }

  void setupRowsToDelete() {
    filasAEliminar = 0;
    for (int r=0; r<5; r++) {
      filasLlenas[r] = rows-1;
    }
  }

  void delete() {
    completedRows();
    deleteRows();
    addRows();
  }

  boolean gameOver(int num) {
    if (num ==0) {
      for (int i=1; i<=columns-2; i++) {
        if (repMemoria.get(0)[i] != 0) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
  }
}
