class Button extends Figure {
  int dimX;
  int dimY;
  String texto;
  PFont fuente;
  
  Button(int x_, int y_, int ancho, int alto, color color1, color color2, String textB, PFont fuenteT){
    super(x_,y_,color1,color2);
    dimX = ancho;
    dimY = alto;
    texto = textB;
    fuente = fuenteT;
  }
  
  void display(){
    push();
    fill(fillColor);
    stroke(strokeColor);
    rectMode(CENTER);
    rect(posX,posY,dimX,dimY,6);
    textFont(fuente);
    //textSize(70);
    textAlign(CENTER, CENTER);
    fill(strokeColor);
    text(texto, posX, posY-12);
    pop();
  }
  
  boolean check(){
    if((mouseX > posX - dimX/2) && (mouseX < posX+dimX/2) && (mouseY > posY-dimY/2) && (mouseY < posY+dimY/2)){
      return true;
    }else{
      return false;
    }
  }
}
