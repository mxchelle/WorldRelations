 // Private class that holds details of entries that meet the requirement
 // Of having mentioned 2 countries.
 public class MyEntries{
    int[] countriesIndex;
    String id;
    String imageURL;
    Location location1;
    Location location2;
    
    public MyEntries(int[] countriesIndex){
      this.countriesIndex = countriesIndex;
      int latitude1 = Integer.parseInt(centerList[countriesIndex[0]].getFirst());
      int longitude1 = Integer.parseInt(centerList[countriesIndex[0]].getLast());
      int latitude2 = Integer.parseInt(centerList[countriesIndex[1]].getFirst());
      int longitude2 = Integer.parseInt(centerList[countriesIndex[1]].getLast());
      location1 = new Location(latitude1, longitude1);
      location2 = new Location(latitude2, longitude2);
    }
    
    public void setID(String id){
      this.id = id;
      setImageURL(id);
    }
    
    public void setImageURL(String id){
      String imageJSONURL = "http://api.dp.la/v2/items?id="+id+"&fields=isShownAt&api_key="+apikey;
      
      JSONObject jsonObject = loadJSONObject(imageJSONURL);
      JSONArray results = jsonObject.getJSONArray("docs"); 
      String imageURL = results.getJSONObject(0).getString("isShownAt");
      this.imageURL = imageURL;
    }
    
    //If user clicks on curve, this is eventually called to open page in browser
    public void openPageInBrowser(){
       try {
         //Set your page url in this string. For eg, I m using URL for Google Search engine
         java.awt.Desktop.getDesktop().browse(java.net.URI.create(imageURL));
       }
       catch (java.io.IOException e) {
           System.out.println(e.getMessage());
       }
       
    }
    /// End of file
     
     //Deals with storing in HashMap   
    public Index getKey(){
      return new Index(countriesIndex[0], countriesIndex[1]);
    }
  }
