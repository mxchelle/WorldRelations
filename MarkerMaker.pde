public class MarkerMaker{
  
  ArrayList<MarkerPair> markerCollection;
  
  // HashMaps store a unique key, and value pair
  // I use it to know if there are more than one of
  // a pair (eg. more than one Sweden USA)
  HashMap<Index, Integer> hash;
  
  public MarkerMaker(ArrayList<MyEntries> relations){
    
    markerCollection = new ArrayList<MarkerPair>();
    hash = new HashMap<Index, Integer>();
    
    int specificIndex = 0;
    
    
    // Puts every relations in HashMap.
    // If there is a duplicate pair, it gives that pair an index++
    for(MyEntries entry: relations){
      Index indicies = entry.getKey();
      if(!hash.containsKey(indicies)){
        hash.put(indicies,0);
      }
      else{
        specificIndex = hash.get(indicies)+1;
        hash.put(indicies,specificIndex);
      }
      SimplePointMarker marker1 = new SimplePointMarker(entry.location1);
      SimplePointMarker marker2 = new SimplePointMarker(entry.location2);
      markerCollection.add(new MarkerPair(marker1, marker2, entry, specificIndex));
    }
  }
  
  public void draw(){
    for(MarkerPair pair:markerCollection){
      pair.draw();
    }
  }
  
  public void mouseMoved(){
    for(MarkerPair pair:markerCollection){
      pair.mouseMoved();
    }
  }
  
  public void mouseClicked(){
    for(MarkerPair pair:markerCollection){
      pair.mouseClicked();
    }
  }
  
  // Counter increments every time a pair is made. This is so program
  // ensures a unique color for each curve
  int counter = 0;
  
  // Each MarkerPair has the indicies for 2 countries and a curve to 
  // connect the two
  private class MarkerPair{
    SimplePointMarker marker1;
    SimplePointMarker marker2;
    ScreenPosition position1;
    ScreenPosition position2;
    int index;
    Curve myCurve;
    MyEntries entry;
    
    public MarkerPair(SimplePointMarker marker1, SimplePointMarker marker2, MyEntries entry, int index){
      this.marker1 = marker1;
      this.marker2 = marker2;
      this.entry = entry;
      this.index = index;
      
      position1 = marker1.getScreenPosition(map);
      position2 = marker2.getScreenPosition(map);
      
      //Defines styling for 2 markers
      marker1.setColor(color(255, 0, 0, 100));
      marker1.setStrokeColor(color(255, 0, 0));
      marker1.setStrokeWeight(4);
      
      marker2.setColor(color(255, 0, 0, 100));
      marker2.setStrokeColor(color(255, 0, 0));
      marker2.setStrokeWeight(4);

      map.addMarkers(marker1, marker2);
      makeCurve();
    }
    
    //Makes the curve so they don't overlap each other
    public void makeCurve(){
      int flip = (int)pow(-1,index);
      double pythagorean = Math.sqrt(square(position1.x-position2.x)+square(position1.y-position2.y));
      float alter = (float) ((index/2)*40*(pythagorean/100)+pythagorean);
      myCurve = new Curve(position1.x, position1.y,position1.x-30, position1.y-flip*alter/10,position2.x-30, position2.y-flip*alter/10,position2.x, position2.y, 2*counter);
      counter++;
    }
    
    public void mouseMoved(){
      myCurve.mouseMoved();
    }
    
    public void mouseClicked(){
      if(myCurve.mouseMoved()){
        entry.openPageInBrowser();
        mouseX=0;
        mouseY=0;
      }
    }
    
    public void draw(){
      myCurve.draw();
    }
    
    public float square(float num){
      return abs(num*num);
    }
  }
}
