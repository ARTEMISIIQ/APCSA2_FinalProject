public class Derivative{
  
  private float x1;
  private ArrayList<Point> closest = new ArrayList<Point>();
  private InputSystem inputSys;
  private Graph g;
  
  public Derivative (float x, InputSystem inputSys, Graph g){
    this.x1 = x;
    this.inputSys = inputSys;
    this.g = g;
    float min = 0.125;
    for (Point p: g.getPts()){
      if (abs(p.getCoords2D().x-x1)<min){ // Finds the closest point to the desired x value;
        min = abs(p.getCoords2D().x-x1);
        closest = new ArrayList<Point>();
        closest.add(p);
      }
      if (abs(p.getCoords2D().x-x1)==min){ //  Adds to ArrayList if multiple points satisfy this requirement;
        closest.add(p);
      }
    }
  }
  
  public void display(){ // We 'differentiate' the function by finding the slopes of two points which are very close to each other
    for (Point p: closest){ // Creates multiple tangent lines if there are multiple points close to the given x-value
      float y1 = p.getCoords2D().y;
      float slopeX = (inputSys.function(x1+0.0001,y1,0)-inputSys.function(x1-0.0001,y1,0)) / 0.0002; // Partial Derivative with respect to X
      float slopeY = (inputSys.function(x1,y1+0.0001,0)-inputSys.function(x1,y1-0.0001,0)) / 0.0002; // Partial Derivative with respect to Y
      float slope = - slopeX/slopeY;
      line(width/2+(x1-20)*width/cameraMagnitude,height/2-(y1-slope*20)*height/cameraMagnitude,width/2+(x1+20)*width/cameraMagnitude,height/2-(y1+slope*20)*height/cameraMagnitude); // Line with slope that passes through desired point
      fill(0,100,100);
      ellipse(x1*width/cameraMagnitude+width/2,-y1*height/cameraMagnitude+height/2,100/cameraMagnitude,100/cameraMagnitude);
    }
  }
}
