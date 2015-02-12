import java.util.LinkedList;

public  LinkedList<String>[] centerList;
public  LinkedList<String>[] countriesList;

// Please put in your own api_key here.
// Go here to get a key: http://dp.la/info/developers/codex/policies/#get-a-key
public String apikey = "822e4148abc7bf080eb4db7449101e77";

public class SearchQuery {
  private ArrayList<MyEntries> relations;
  
  // Constructor
  public SearchQuery(String searchTerm) {
    
    //-----These are csv files I made. One has list of countries and what people are called-----//
    String[] countriesListRaw = loadStrings("data/countriesList.csv");
    String[] centerListRaw = loadStrings("data/countries.center.csv");
    countriesList = makeCSV(countriesListRaw);
    centerList = makeCSV(centerListRaw);
    search(searchTerm,1);
    //search(searchTerm,2);
    //search(searchTerm,3);
  }
  
  // I created my own csv's (comma separated value)
  // This function will convert cvs to an array that holds linkedLists called csv
  // csv acts like a 2D array, but because the entries aren't uniform (eg. some rows have 2, others 5)
  // I have to use LinkedLists instead of inner arrays
  public LinkedList<String>[] makeCSV(String[] lines){
    LinkedList<String>[] csv = new LinkedList[lines.length];
    relations = new ArrayList<MyEntries>(30);
   
    for (int i=0; i < lines.length; i++) {
      String[] csvSplit=split(lines[i],',');
      csv[i] = new LinkedList<String>();
      
      for(int j =0; j< csvSplit.length; j++){
        csv[i].add(csvSplit[j]);
      }
      
    }//end for loop
    
    return csv;
  }

  // Search function
  public JSONArray search(String title,int pageNum) {
    String queryURL = "http://api.dp.la/v2/items?sourceResource.title="+title+"&fields=sourceResource.subject,id&page_size=500&api_key=";
    queryURL+=apikey;
    
    println("Search: " + queryURL);

    JSONObject jsonObject = loadJSONObject(queryURL);

    JSONArray results = jsonObject.getJSONArray("docs");  
    
    //let's parse the data
    parseData(results);
    return results;
  }
  
  public ArrayList getResults(){
    return relations;
  }
  
  //-----Parses the "docs" JSON array-----//
  public void parseData(JSONArray value){
    
    //-----Goes through all entries-----//
    for (int i = 0; i < value.size(); i++) {
      JSONObject entry = value.getJSONObject(i); 
      String id = entry.getString("id");
      
      //not all entries have subject, so this needs to be in a try, catch
      try{ 
        JSONArray subject = entry.getJSONArray("sourceResource.subject");
        
        //-----Go through all the subjects one entry has-----//
        for (int j = 0; j < subject.size(); j++){
          JSONObject subjectEntry = subject.getJSONObject(j);
          
          //-----findCountries will return a MyEntries object only if the 
          // subject meets the requirement of mentioning 2 countries-----//
          MyEntries result = findCountries(subjectEntry.getString("name"));
            if(result!=null){
              result.setID(id);
              relations.add(result);
              break;
            }       
        }
      }
      catch (Exception e){
        //there is no entry of sort
        //just pass it.
      }//end catch
      
    }//end outer for loop
  }//end function
  
  
  // This function takes in a subject (from a JSON object) and
  // Checks against csv file to see if 2 different countries names are in the subject.
  // Will return a MyEntries object if 2 countries are mentioned.
  // eg. Swedish, United States
 public MyEntries findCountries(String subject){
    int count =0;
    int[] countrySet = new int[2];
    
    for(int i=0; i< countriesList.length; i++){ //down the column
      
      LinkedList<String> linkedList = countriesList[i];
       
      for(String country: linkedList){
        if(subject.contains(country)){
          countrySet[count] = i;
          count++;
          break;
        }
       
      }//end inner for loop
      
      if(count==2){
          return new MyEntries(countrySet);
      } 
    }//end outer for loop
    return null;
  }//end function
 
}
