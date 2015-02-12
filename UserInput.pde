/*
* This is the search bar at the top.
* It takes in user input, and doesn't run until you
* press enter.
*/

public class UserInput{
  int x, y, w, h;
  int fontSize = 20;
  int toggle = 0;
  
  public UserInput(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    textAlign(LEFT, TOP);
  }

  public void draw(){
    strokeWeight(1);
    stroke(0);
    fill(240);
    rect(x,y,w,h);
    fill(0);
    textSize(fontSize);
    text(searchTermTemp.toString(), x+fontSize, y+4);
    float cw = textWidth(searchTermTemp.toString())+fontSize;
    
    if(toggle%50<20){
      stroke(255);
    }
    line(x+cw+2, y+5, x+cw+2, y+h-5);
    toggle++;
    //goButton();
  }
  
  public void keyPressed(){
      if(key==BACKSPACE){
        int index = searchTermTemp.length()-1;
        if(index>=0){
          searchTermTemp.deleteCharAt(index);
        }
      }
      else if(key==ENTER){
        searchTerm = searchTermTemp.toString();
        loadData();
      }
      else if(key==' '){
        if(searchTermTemp.length() < 40){
          searchTermTemp.append("+");
        }
      }
      else{
        if(searchTermTemp.length() < 40){
          searchTermTemp.append(key);
        }
      }
  }
}
