public class GraphRectangular{
  ArrayList<Point> Points = new ArrayList<>();
  
  public GraphRectangular(InputSystem inputSys, float threshold, int Dimension, boolean Vector){
    background(255);
    float m = 0.5;
    if (Dimension == 2){
      m = 0.25;
    }
    if (Vector){
      m = 0.5;
    }
    inputSys.evaluate();
    for (float i = -10; i < 10; i+=m){
      for (float j = -10; j < 10; j+=m){
        if (Dimension == 3){
          for (float k = -10; k < 10; k+=m){
             if (abs(inputSys.function(i,j,k)) < threshold){
               Points.add(new Point(i,j,k,inputSys));
             }
           }
        }
        if (Dimension == 2){
          if (Vector){
            Points.add(new Point(i,j,0,inputSys));
          }
          else{
            if (abs(inputSys.function(i,j,0)) < threshold){
              Points.add(new Point(i,j,0, inputSys));
            }
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
