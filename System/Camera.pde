public class Camera{
  private float cameraMagnitude = 100;
  private float cameraAngle_1 = 0.0001;
  private float cameraAngle_2 = 0.0001;
  
  private float x1 = cameraMagnitude * cos(cameraAngle_1) *  sin(cameraAngle_2);
  private float z1 = cameraMagnitude * cos(cameraAngle_2);
  private float y1 = cameraMagnitude * sin(cameraAngle_1) * sin(cameraAngle_2);
  
  private PVector cameraCords = new PVector(x1,y1,z1);
  
  public void setCameraMagnitude(float newMag){
   this.cameraMagnitude = newMag; 
  }
  
  public void setCameraAngle1(float newAngle){
   this.cameraAngle_1 = newAngle; 
  }
  
  public void setCameraAngle2(float newAngle){
   this.cameraAngle_2 = newAngle; 
  }
}
