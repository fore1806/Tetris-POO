/**
  *  Polyomino
  * 
  *  Clase desarrollada para realizar polyominos, que hereda de figura 
  *  Consta de 14 atributos y 11 métodos
  */
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

 /**
   *  Muestra en pantalla el polyomino.
   *  @param {}.
   *  @return{}. 
   **/
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
  
 /**
   *  Mueve el polyomino una fila abajo en el tablero.
   *  @param {}.
   *  @return{}. 
   **/
  void moveDown() {
    row = row+1;
  }

 /**
   *  Mueve el polyomino una columna a la izquierda en el tablero.
   *  @param {}.
   *  @return{}. 
   **/
  void moveLeft() {
    column = column -1;
  }

 /**
   *  Mueve el polyomino una columna a la derecha en el tablero.
   *  @param {}.
   *  @return{}. 
   **/
  void moveRight() {
    column = column +1;
  }

 /**
   *  Rota el polyomino 90° en sentido horario.
   *  @param {}.
   *  @return{}. 
   **/
  void rotatePolyomino() {
    pRotation = rotation;
    rotation = (rotation+1)%4;
    if (colisionDownRotate(1)) {
      rotation = pRotation;
    }
  }
  
 /**
   *  Rota el polyomino 180° en sentido horario.
   *  @param {}.
   *  @return{}. 
   **/
  void reflectPolyomino() {
    pRotation = rotation;
    rotation = (rotation+2)%4;
    if (colisionDownRotate(1)) {
      rotation = pRotation;
    }
  }

 /**
   *  Devuelve un booleano que indica si el tetromino.
   *  @param {int} -Establece si debe evaluar una colisión abajo o de rotación.
   *  @return{Boolean} -El polyomino no puede rotar o bajar. 
   **/
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

 /**
   *  Devuelve un booleano que indica si el tetromino.
   *  @param {int} -Establece si debe evaluar una colisión a la izquierda o derecha.
   *  @return{Boolean} -El polyomino no puede moverse lateralmente. 
   **/
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

 /**
   *  Define la fila en la que se guardara el polyomino al final.
   *  @param {Tablero, Polyomino}.
   *  @return{}. 
   **/
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

 /**
   *  Guarda el polyomino una vez cayo en la representación en memoria del tablero.
   *  @param {}.
   *  @return{}. 
   **/
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
 /**
   *  Clona un Polyomino.
   *  @param {}.
   *  @return{}. 
   **/
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
