class Polyomino extends Figure implements Cloneable {

  int row;
  int column;
  int [] rotations = new int [4];
  int rotation;
  int pRotation;
  int dimCuadro;
  Tablero table;
  int numMono;
  int numArray;

  Polyomino(color color1, color color2, int [] rotVector, int r, int numeroM, Tablero tableT) {
    super(color1, color2);
    row = r;
    rotations = rotVector;
    rotation = 0;
    pRotation = 3;
    dimCuadro = tableT.dimCuadro;
    table = tableT;
    numMono = numeroM;
    numArray = (numMono*numMono) -1;
    column = ((table.columns)/2)-(numMono/2);
  }  

  void display() {
    push();
    fill(fillColor);
    stroke(strokeColor);
    strokeWeight(3);
    for (int i = 0; i <= numArray; i++) {
      if ((rotations[rotation] & (1 << numArray - i)) != 0) {
        posX = (i%numMono)*dimCuadro + column*dimCuadro + table.posX;
        posY = ((i/numMono)|0) * dimCuadro + row*dimCuadro + table.posY;
        square(posX, posY, dimCuadro);
      }
    }
    pop();
  }

  void moveDown() {
    row = row+1;
  }

  void moveLeft() {
    column = column -1;
  }

  void moveRight() {
    column = column +1;
  }

  void rotatePolyomino() {
    pRotation = rotation;
    rotation = (rotation+1)%4;
    if (colisionDownRotate(1)) {
      rotation = pRotation;
    }
  }

  boolean colisionDownRotate(int numRevisar) {
    for (int i = 0; i <= numArray; i++) {
      if (((rotations[rotation] & (1 << numArray - i)) != 0) && numRevisar == 1) { //Rotate Colision
        posX = (i%numMono) + column;
        posY = ((i/numMono)|0) + row;
        if (posY>=0 &&(table.repMemoria.get(posY)[posX] != 0)) { 
          return true;
        }
      } else if (((rotations[rotation] & (1 << i)) != 0)&& numRevisar == 0) { //Down Colision
        posX = ((numArray-i)%numMono) + column;
        posY = (((numArray-i)/numMono)|0) + row;
        if (posY>=0 && (table.repMemoria.get(posY+1)[posX] != 0)) {
          return true;
        }
      }
    }
    return false;
  }

  boolean colisionLateral (int numRevisar) { //numRevisar =1, es para colision Derecha
    for (int j = 0; j < numMono; j++)
    {
      for (int i = j; i <= numArray; i += numMono) {
        if (((rotations[rotation] & (1 << i)) != 0) && numRevisar == 1) { //Right colision
          posX = ((numArray-i)%numMono) + column;
          posY = (((numArray-i)/numMono)|0) + row;
          if (posY>=0 && (table.repMemoria.get(posY)[posX+1] != 0))
            return true;
        } else if (((rotations[rotation] & (1 << numArray-i)) != 0) && numRevisar == 0) { //Left colision
          posX = (i%numMono) + column;
          posY = ((i/numMono)|0) + row;
          if (posY>=0 && (table.repMemoria.get(posY)[posX-1] != 0))
            return true;
        }
      }
    }
    return false;
  }

  void polPosFinal(Tablero table, Polyomino polMove) {
    column = polMove.column;
    rotation = polMove.rotation;
    for (int r=polMove.row; r <= table.rows-1; r++) {
      row = r;
      if (colisionDownRotate(0)) {
        break;
      }
    }
    display();
  }

  void savePolyomino() {
    for (int i = 0; i <= numArray; i++) {
      if ((rotations[rotation] & (1 << (numArray-i))) != 0) {
        posX = (i%numMono) + column;
        posY = ((i/numMono)|0) + row;
        if (posY>=0) {
          table.repMemoria.get(posY)[posX]=fillColor;
        }
      }
    }
  }

  public Polyomino clone() {
    Polyomino obj=null;
    try {
      obj=(Polyomino)super.clone();
    }
    catch(CloneNotSupportedException ex) {
      System.out.println(" no se puede duplicar");
    }
    return obj;
  }
}
