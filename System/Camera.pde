public class Camera{
  private float cameraMagnitude;
  private float cameraAngle_1;
  private float cameraAngle_2;
  
  private float pi = 3.14159263589;
  
  private float x;
  private float z;
  private float y;
  
  private PVector cameraCords;
  
  private PVector vertLine;
  private PVector horiLine;
  
  public Camera(float mag, float ang1, float ang2){
    this.cameraMagnitude = mag;
    this.cameraAngle_1 = ang1;
    this.cameraAngle_2 = ang2;
    this.resetXYZ();
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
  
  public PVector getVert(){
   return vertLine; 
  }
  
  public PVector getHori(){
   return horiLine; 
  }
  
  public void resetXYZ(){
   cameraAngle_1 = (cameraAngle_1 + 2 * pi) % (2 * pi);
   cameraAngle_2 = (cameraAngle_2 + 2 * pi) % (2 * pi);
   x = cameraMagnitude * cos(cameraAngle_1) *  sin(cameraAngle_2);
   z = cameraMagnitude * cos(cameraAngle_2);
   y = cameraMagnitude * sin(cameraAngle_1) * sin(cameraAngle_2);
   cameraCords = new PVector(x,y,z);
   if (cameraAngle_1 == 0 && cameraAngle_2 == 0){
     vertLine = new PVector(0,1,0);
     horiLine = new PVector(1,0,0);
   }
   else{
     vertLine = new PVector(-x*z,-y*z,x*x + y*y);
     horiLine = new PVector(y, -x, 0);
   }
  }
}
