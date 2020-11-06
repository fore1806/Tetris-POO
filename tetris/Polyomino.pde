class Polyomino extends Figure {
  int row;
  int column;
  int [] rotations = new int [4];
  int rotation;
  int pRotation;
  int dimCuadro;
  int xTable;
  int yTable;
  int numMono;
  int numArray;

  Polyomino(color color1, color color2, int [] rotVector, int r, int numeroM, Tablero table) {
    super(color1, color2);
    row = r;
    rotations = rotVector;
    rotation = 0;
    pRotation = 3;
    dimCuadro = table.dimCuadro;
    xTable = table.posX;
    yTable = table.posY;
    numMono = numeroM;
    numArray = (numMono*numMono) -1;
    column = ((table.columns)/2)-(numMono/2);
  }
  
  Polyomino(color color1, color color2, Polyomino polMove){
    super(color1, color2);
    row = polMove.row;
    column = polMove.column;
    rotations = polMove.rotations;
    rotation = polMove.rotation;
    pRotation = polMove.pRotation;
    dimCuadro = polMove.dimCuadro;
    xTable = polMove.xTable;
    yTable = polMove.yTable;
    numMono = polMove.numMono;
    numArray = polMove.numArray;
  }
  

  void display() {
    push();
    fill(fillColor);
    stroke(strokeColor);
    strokeWeight(3);
    for (int i = 0; i <= numArray; i++) {
      if ((rotations[rotation] & (1 << numArray - i)) != 0) {
        posX = (i%numMono)*dimCuadro + column*dimCuadro + xTable;
        posY = ((i/numMono)|0) * dimCuadro + row*dimCuadro + yTable;
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
  
  void moveRight(){
    column = column +1;
  }
  
  void rotatePolyomino(Tablero table){
    pRotation = rotation;
    rotation = (rotation+1)%4;
    if(colisionDownRotate(table, 1)){
      rotation = pRotation;
    }
  }

  boolean colisionDownRotate(Tablero table, int numRevisar) {
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
  
  /*boolean rightKnock(Tablero table) {

  for (int j = 0; j < numMono; j++)
  {
    for (int i = j; i <= numArray; i += numMono) {
      if ((rotations[rotation] & (1 << i)) != 0) {
        posX = ((numArray-i)%numMono) + column;
        posY = (((numArray-i)/numMono)|0) + row;
        if (posY>=0 && (table.repMemoria.get(posY)[posX+1] != 0))
          return true;
      }
    }
  }
  return false;
}*/



  boolean colisionLateral (Tablero table, int numRevisar) { //numRevisar =1, es para colision Derecha
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
  
  /*boolean leftKnock(Tablero table) {

  for (int j = 0; j < numMono; j++)
  {
    for (int i = j; i <= numArray; i += numMono) {
      if ((rotations[rotation] & (1 << numArray - i)) != 0) {
        posX = (i%numMono) + column;
        posY = ((i/numMono)|0) + row;
        if (posY>=0 && (table.repMemoria.get(posY)[posX-1] != 0))
          return true;
      }
    }
  }
  return false;
}*/
  
  void polPosFinal(Tablero table, Polyomino polMove){
    column = polMove.column;
    rotation = polMove.rotation;
    for (int r=polMove.row; r <= table.rows-1; r++){
      row = r;
      if(colisionDownRotate(table, 0)){
        break;
      }
    }
    display();
  }
  
  void savePolyomino(Tablero table){
    for (int i = 0; i <= numArray; i++) {
      if ((rotations[rotation] & (1 << (numArray-i))) != 0) {
        posX = (i%numMono) + column;
        posY = ((i/numMono)|0) + row;
        if(posY>=0){
        table.repMemoria.get(posY)[posX]=fillColor;
        }
      }
    }
  }
}
