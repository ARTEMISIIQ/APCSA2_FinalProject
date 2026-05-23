public class Point{
  
 private PVector coordinates3D;
 private PVector coordinates2D;
 
 public Point(float x, float y, float z){
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
   ellipse(coordinates2D.x * width / cameraMagnitude + width/2, coordinates2D.y * height / cameraMagnitude + height/2, 100 / d / d, 100 / d / d);
 }
 
 public void displayVector(Camera c){
   float cameraMagnitude = c.getMag();
   float d = c.getVector().dist(coordinates3D);
   PVector dir = vectorFunction(this.coordinates3D.x,this.coordinates3D.y);
   strokeWeight(.1);
   fill(100, 100, 3000/d);
   line(coordinates2D.x * width / cameraMagnitude + width/2, coordinates2D.y * height / cameraMagnitude + height/2, coordinates2D.x * width / cameraMagnitude + width/2 + dir.x / cameraMagnitude, coordinates2D.x * width / cameraMagnitude + width/2+dir.y/cameraMagnitude);
 }
 
 public PVector vectorFunction(float x, float y){
   return new PVector(x,y).setMag(1);
 }
}
