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

  boolean check() {
    if ((mouseX > posX - dimX/2) && (mouseX < posX+dimX/2) && (mouseY > posY-dimY/2) && (mouseY < posY+dimY/2)) {
      return true;
    } else {
      return false;
    }
  }

  void seleccionador() {
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
