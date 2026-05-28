public class Derivative{
  
  private float x1;
  private InputSystem inputSys;
  private Graph g;
  
  public Derivative (float x, InputSystem inputSys, Graph g){
    this.x1 = x;
    this.inputSys = inputSys;
    this.g = g;
  }
  
  public void display(){
    float slope = (inputSys.function(x1+0.0001,0,0)-inputSys.function(x1-0.0001,0,0)) / 0.0002;
    float y1 = inputSys.function(x1,0,0);
    line(width/2+(x1-20)*width/cameraMagnitude,height/2-(y1-slope*20)*height/cameraMagnitude,width/2+(x1+20)*width/cameraMagnitude,height/2-(y1+slope*20)*height/cameraMagnitude);
  }
}
