public class GraphRectangular{
  ArrayList<Point> Points = new ArrayList<>();
  
  public GraphRectangular(InputSystem inputSys, float threshold){
    background(255);
    float m = 0.25;
    inputSys.evaluate();
    for (float i = -10; i < 10; i+=m){
      for (float j = -10; j < 10; j+=m){
        for (float k = -10; k < 10; k+=m){
           if (inputSys.function(i,j,k) < threshold){
             Points.add(new Point(i,j,k));
           }
         }
       }
       println(i);
    }
  }
  
  public ArrayList<Point> getPts(){
    return Points;
  }
}
