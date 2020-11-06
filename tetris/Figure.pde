abstract public class Figure {
  int posX;
  int posY;
  color fillColor;
  color strokeColor;
  
  Figure(int x_, int y_, color color1, color color2){
    posX = x_;
    posY = y_;
    fillColor = color1;
    strokeColor = color2;
  }
  
  Figure(color color1, color color2){
    this(0,0,color1,color2);
  }
  
  abstract void display();
}
