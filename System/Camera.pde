public class Camera{
  private float cameraMagnitude;
  private float cameraAngle_1;
  private float cameraAngle_2;
  
  private float x;
  private float z;
  private float y;
  
  private PVector cameraCords;
  
  public Camera(float mag, float ang1, float ang2){
    cameraMagnitude = mag;
    cameraAngle_1 = ang1;
    cameraAngle_2 = ang2;
    resetXYZ();
  }
  
  public void setMag(float newMag){
   this.cameraMagnitude = newMag;
   resetXYZ();
  }
  
  public void setAng1(float newAngle){
   this.cameraAngle_1 = newAngle;
   resetXYZ();
  }
  
  public void setAng2(float newAngle){
   this.cameraAngle_2 = newAngle; 
   resetXYZ();
  }
  
  public float getMag(){
   return cameraMagnitude; 
  }
  
  public float getAng1(){
   return cameraAngle_1; 
  }
  
  public float getAng2(){
   return cameraAngle_2; 
  }
  
  public PVector getVector(){
   return cameraCords; 
  }
  
  public void resetXYZ(){
   cameraAngle_1 = (cameraAngle_1 + 2 * pi) % (2 * pi);
   cameraAngle_2 = (cameraAngle_2 + 2 * pi) % (2 * pi);
   x = cameraMagnitude * cos(cameraAngle_1) *  sin(cameraAngle_2);
   z = cameraMagnitude * cos(cameraAngle_2);
   y = cameraMagnitude * sin(cameraAngle_1) * sin(cameraAngle_2);
   cameraCords = new PVector(x,y,z);
  }
}
