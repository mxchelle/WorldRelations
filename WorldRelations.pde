
// I'm using a map library, so I'm importing everything
// You need to install the library to see it.
// Go to Sketch > Import Library > Add Library... and find Unfolding Maps.


/*
 * Maps out relations between DP.LA entries given a user query
 * Press enter to execute another query.
 * @author Michelle Partogi
 * @version 1.0
 */
 
/*
* If you want to dissect this code, this is an order that makes the most sense:
* setup() > UserInput > SearchQuery > MyEntries > MarkerMaker > Curve
*/

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.utils.*;
import java.util.List;

UnfoldingMap map;
List<Marker> countryMarkers;
MarkerMaker marks;
String searchTerm;

// searchTermTemp is going to be edited alot, that's why
// I use StringBuffer
// Normal strings are immutable, so changing them means recreating them each time
// StringBuffer solves that issue
StringBuffer searchTermTemp;

UserInput input;

void setup() {
    size(1000, 800);
    smooth(1);
    cursor(CROSS);
    
    searchTerm = "treaty";
    searchTermTemp = new StringBuffer(searchTerm);
    input = new UserInput(10, 10, 500, 30);
    
    println("Press enter to execute new query");
    
    loadData();
}
// Canvas only draws if mouse has moved (aka something's suppose to change)
boolean mouseMoved = false;
void draw() {
  if(mouseMoved){
    map.draw();
    marks.draw();
    marks.mouseMoved();
    mouseMoved = false; 
  }
  input.draw();
}

void mouseMoved(){
  mouseMoved = true;
  
}

void mouseClicked(){
  marks.mouseClicked();
}

void keyPressed(){
  input.keyPressed();
}

void loadData(){
  
  //-----Making Map from map library -----//
  map = new UnfoldingMap(this);
  //MapUtils.createDefaultEventDispatcher(this, map);
    
  //-----Populate countries in map-----//
  List<Feature> countries = GeoJSONReader.loadData(this, "countries.geo.json"); //this is a json file in data folder
  countryMarkers = MapUtils.createSimpleMarkers(countries);
  map.addMarkers(countryMarkers);

  //-----Create results with my search term-----//
  SearchQuery mySearch = new SearchQuery(searchTerm);
  marks = new MarkerMaker(mySearch.getResults());
  
  // I draw all of the pixels, then save it into an array
  // This is because the program detects if user's mouse is on a curve
  // Based on the color the mouse is over
  map.draw();
  marks.draw();
  loadPixels();
}

