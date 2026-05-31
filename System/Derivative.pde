public class Derivative{
  
  private float x1;
  private float y1;
  private Point closest;
  private InputSystem inputSys;
  private Graph g;
  
  public Derivative (float x, InputSystem inputSys, Graph g){
    this.x1 = x;
    this.inputSys = inputSys;
    this.g = g;
    float min = 100;
    for (Point p: g.getPts()){
      if (abs(p.getCoords2D().x-x1)<min){
        min = abs(p.getCoords2D().x-x1);
        closest = p;
      }
    }
    y1 = closest.getCoords2D().y;
  }
  
  public void display(){ // We 'differentiate' the function by finding the slopes of two points which are very close to each other
    float slopeX = (inputSys.function(x1+0.0001,y1,0)-inputSys.function(x1-0.0001,y1,0)) / 0.0002; // Partial Derivative with respect to X
    float slopeY = (inputSys.function(x1,y1+0.0001,0)-inputSys.function(x1,y1-0.0001,0)) / 0.0002; // Partial Derivative with respect to Y
    float slope = - slopeX/slopeY;
    line(width/2+(x1-20)*width/cameraMagnitude,height/2-(y1-slope*20)*height/cameraMagnitude,width/2+(x1+20)*width/cameraMagnitude,height/2-(y1+slope*20)*height/cameraMagnitude); // Line with slope that passes through desired point
  }
}
