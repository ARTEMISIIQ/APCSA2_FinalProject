public class GraphRectangular{
  ArrayList<Point> Points = new ArrayList<>();
  
  public GraphRectangular(InputSystem inputSys, float threshold, int Dimension){
    background(255);
    float m = 0.5;
    if (Dimension == 2){
      m = 0.05;
    }
    inputSys.evaluate();
    for (float i = -10; i < 10; i+=m){
      for (float j = -10; j < 10; j+=m){
        if (Dimension == 3){
          for (float k = -10; k < 10; k+=m){
             if (inputSys.function(i,j,k) < threshold){
               Points.add(new Point(i,j,k));
             }
           }
        }
        else{
          if (inputSys.function(i,j,0) < threshold){
               Points.add(new Point(i,j,0));
           }
        }
       }
    }
  }
  
  public ArrayList<Point> getPts(){
    return Points;
  }
}
