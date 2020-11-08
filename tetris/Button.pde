/**
 *  Button
 * 
 *  Clase desarrollada para realizar botones, que hereda de figura 
 *  Consta de 11 atributos y 3 métodos
 */
class Button extends Figure {
  int dimX;
  int dimY;
  int sw1 = 1;
  int sw2;
  color stroke2;
  String texto;
  PFont fuente;

  Button(int x_, int y_, int ancho, int alto, color color1, color color2, String textB, PFont fuenteT) {
    super(x_, y_, color1, color2);
    dimX = ancho;
    dimY = alto;
    texto = textB;
    fuente = fuenteT;
  }
  
 /**
   *  Muestra en pantalla el botón.
   *  @param {}.
   *  @return{}. 
   **/
  void display() {
    push();
    fill(fillColor);
    strokeWeight(sw1);
    stroke(strokeColor);
    rectMode(CENTER);
    rect(posX, posY, dimX, dimY, 6);
    textFont(fuente);
    textAlign(CENTER, CENTER);
    fill(strokeColor);
    text(texto, posX, posY-12);
    pop();
  }

 /**
   *  Devuelve un booleano que indica si el mouse esta o no sobre el botón.
   *  @param {}.
   *  @return{Boolean} -El mouse esta sobre el botón. 
   **/
  boolean check() { //Método para saber si el mouse se encuentra sobre el botón
    if ((mouseX > posX - dimX/2) && (mouseX < posX+dimX/2) && (mouseY > posY-dimY/2) && (mouseY < posY+dimY/2)) {
      return true;
    } else {
      return false;
    }
  }

 /**
   *  Cambia el color y ancho del borde del botón.
   *  @param {}.
   *  @return{}. 
   **/
  void seleccionador() {  //Metodo para cambiar el color del stroke, que nos indica cuando el mouse esta sobre el botón
    if (check()) {
      stroke2 = strokeColor;
      strokeColor = #3BE0F2;
      sw2 = sw1;
      sw1 = 7;
    }else{
      strokeColor = stroke2;
      sw1 = sw2;
    }
  }
}
