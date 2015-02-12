/*
* Deals with how entry is stored in a HashMap
*/
public class Index{
  int i, j;
  
  public Index(int i, int j){
    this.i = i;
    this.j = j;
  }
  
  /*
  * Deals with how entry is determined as equal
  */
  @Override
  public boolean equals(Object object) {
   if (! (object instanceof Index)) {
        return false;
    }

    Index other = (Index) object;
      return this.i == other.i;// && this.j == other.j;
  }
  
  /*
  * Deals with how entry is stored in a HashMap
  */
  @Override
  public int hashCode() {
      int result = 17; // any prime number
      result = 31 * result + Integer.valueOf(this.i).hashCode();
      result = 31 * result + Integer.valueOf(this.j).hashCode();
      return result;
  }
}
