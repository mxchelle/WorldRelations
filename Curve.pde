/*
* Connects two countries together
*/

public class Curve{
  float x1, y1, cpx1, cpy1, cpx2, cpy2, x2, y2;
  int counter;
  color curveColor;
  
  /*
  * Constructor
  * Gives the curve a color that's theoretically unique
  * That color is its identification
  */
  public Curve(float x1,float y1,float cpx1,float cpy1,float cpx2,float cpy2,float x2,float y2, int counter){
    this.x1 = x1;
    this.y1 = y1;
    this.cpx1 = cpx1;
    this.cpy1 = cpy1;
    this.cpx2 = cpx2;
    this.cpy2 = cpy2;
    this.x2 = x2;
    this.y2 = y2;
    
    this.counter = counter;
    curveColor = color(random(10),random(10),50+counter);
  }
  
  /*
  * Draw curve
  */
  public void draw(){
    noFill();
    stroke(curveColor);
    strokeWeight(3);
    bezier(x1,y1,cpx1,cpy1,cpx2,cpy2,x2,y2);
  }
  
  /*
  * If the mouse is over a pixel whose color matches this curve's color,
  * then the mouse is on this curve.
  */
  public boolean mouseMoved(){
    color col = pixels[mouseY*width+mouseX]; //get(mouseX,mouseY);
    if( curveColor == col  ){
      //print("match");
      stroke(color(255,255,0));
      strokeWeight(3);
      noFill();
      bezier(x1,y1,cpx1,cpy1,cpx2,cpy2,x2,y2);
      return true;
    }
    return false;
  }
}
