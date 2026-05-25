public class Point{
  
 private PVector coordinates3D;
 private PVector coordinates2D;
 
 public Point(float x, float y, float z, InputSystem inputSys){
   colorMode(HSB, 360, 100, 100);
   coordinates3D = new PVector(x,y,z);
 }
 
 public PVector getCoords3D(){
  return this.coordinates3D; 
 }
 
 public void setCoords2D(PVector v){
  this.coordinates2D = v; 
 }
 
 public void display(Camera c){
   float cameraMagnitude = c.getMag();
   float d = c.getVector().dist(coordinates3D);
   fill(100, 100, 3000/d);
   ellipse(coordinates2D.x * width / cameraMagnitude + width/2, coordinates2D.y * height / cameraMagnitude + height/2, 100 / d, 100 / d);
 }
 
 public void displayVector(Camera c){
   float cameraMagnitude = c.getMag();
   float d = c.getVector().dist(coordinates3D);
   PVector dir = vectorFunction(this.coordinates3D.x,this.coordinates3D.y);
   strokeWeight(1);
   fill(100, 100, 3000/d);
   ellipse(coordinates2D.x * width / cameraMagnitude + width/2,coordinates2D.y * height / cameraMagnitude + height/2,1,1);
   line(coordinates2D.x * width / cameraMagnitude + width/2, coordinates2D.y * height / cameraMagnitude + height/2, coordinates2D.x * width / cameraMagnitude + width/2 + dir.x, coordinates2D.y * height / cameraMagnitude + height/2 - dir.y);
 }
 
 public PVector vectorFunction(float x, float y){
   float a = inputSys.function(x,y,0);
   if (a == Integer.MAX_VALUE){
     return new PVector(0,0);
   }
   return new PVector(1,a).setMag(100 / cameraMagnitude);
 }
}
