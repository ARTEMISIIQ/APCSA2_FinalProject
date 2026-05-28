public class Graph{
  
  ArrayList<Point> Points = new ArrayList<>();
  int mode;
  
  public Graph(InputSystem inputSys, float threshold, int Dimension, boolean Vector){
    background(255);
    float m = 0.5;
    mode = 1;
    if (Dimension == 2){
      mode = 2;
      m = 0.1;
    }
    if (Vector){
      m = 0.25;
    }
    if (Derivative){
      mode = 3;
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
    }
  }
  
  public ArrayList<Point> getPts(){
    return Points;
  }
}
