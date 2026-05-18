import java.util.*;

public class System{
  ArrayList<PVector> grid = new ArrayList<>();
  
  float y1=
  
  PVector vertLine = new PVector(1,y1/x1,-(x1 + y1*y1/x1) / z1);
  PVector horiLine = new PVector(abs(y1), Math.signum(y1) * -x1, 0);
  
  float pi = 3.14159263589;
  float e = 2.718281828;
  float scale = 50;
  
  void setup(){
   size(1000,1000);
   colorMode(HSB, 360, 100, 100);
   //colorMode(RGB, 255, 255, 255);
   background(255);
   //for (int i = 0; i < 8; i++){
   //  String s = Integer.toBinaryString(i);
   //  while (s.length() < 3){
   //    s = "0" + s;
   //  }
   //  float x = Integer.parseInt(s.substring(0,1));
   //  float y = Integer.parseInt(s.substring(1,2));
   //  float z = Integer.parseInt(s.substring(2,3));
   //  grid.add(new PVector(x,y,z));
   //}
   //for (int i = 0; i < 1000; i++){
   //  grid.add(PVector.random3D().setMag(3));
   //
   float m = 0.25;
   for (float i = -10; i < 10; i+=m){
     for (float j = -10; j < 10; j+=m){
       for (float k = -10; k < 10; k+=m){
         if (f(i,j,k,1) < 0.5){
           grid.add(new PVector(i,j,k));
         }
       }
     }
   }
  }
  
  float f(float x, float y, float z, float k){
    float c = x*x+y*y-z-sin(z)*x;
    return abs(c);
  }
  
  void draw(){
    background(255);
  
    vertLine = new PVector(1,y1/x1,-((x1 + y1*y1/x1) / z1));
    horiLine = new PVector(y1, x1, 0);
    
    for (PVector point: grid){
      PVector new3dCoords = project3d(point);
      PVector newCoords = project2d(new3dCoords);
      float d = point.dist(cameraCords);
      fill(100, 100, 3000/d);
      float m = d / 10;
      ellipse(newCoords.x * width / cameraMagnitude + width/2, newCoords.y * height / cameraMagnitude + height/2, 1000 / d / d * m, 1000 / d / d * m);
    }
    
    //println(vertLine);
    //println(horiLine);
  }
  
  void keyPressed(){
    if (keyCode == RIGHT){
      cameraAngle_1 -= 0.0314;
    }
    if (keyCode == LEFT){
      cameraAngle_1 += 0.0314;
    }
    if (keyCode == UP){
      cameraAngle_2 += 0.0314;
    }
    if (keyCode == DOWN){
      cameraAngle_2 -= 0.0314;
    }
    if (key == 'e'){
      cameraMagnitude += 5;
    }
    if (key == 'q'){
      cameraMagnitude -= 5;
    }
    cameraAngle_1 = (cameraAngle_1 + 2 * pi) % (2 * pi);
    cameraAngle_2 = (cameraAngle_2 + 2 * pi) % (2 * pi);
    x1 = cameraMagnitude * cos(cameraAngle_1) *  sin(cameraAngle_2);
    z1 = cameraMagnitude * cos(cameraAngle_2);
    y1 = cameraMagnitude * sin(cameraAngle_1) * sin(cameraAngle_2);
    cameraCords = new PVector(x1,y1,z1);
  }
  
  PVector project3d(PVector point){
    PVector lineVector = point.copy().sub(cameraCords);
    float xP = lineVector.x;
    float yP = lineVector.y;
    float zP = lineVector.z;
    
    float x2 = (y1*yP*x1 - y1*xP*y1 + z1*zP*x1 - z1*xP*z1) / (x1*xP + y1*yP + z1*zP);
    float y2 = (x1*xP*y1 - x1*yP*x1 + z1*zP*y1 - z1*yP*z1) / (x1*xP + y1*yP + z1*zP);
    float z2 = (y1*yP*z1 - y1*zP*y1 + x1*xP*z1 - x1*zP*x1) / (x1*xP + y1*yP + z1*zP);
    
    return new PVector(x2,y2,z2);
  }
  
  PVector project2d(PVector transformedPoint){
    if (transformedPoint.mag() != 0){
      double theta = acos(max(-1,min((transformedPoint.dot(vertLine) / transformedPoint.mag() / vertLine.mag()),1)));
      if (cameraCords.dot(transformedPoint.cross(vertLine)) < 0){
        theta *= -1;
      }
      theta += pi/2;
      float r = transformedPoint.mag();
      return new PVector(r * cos((float) theta), r * sin((float) theta));
    }
    return new PVector(0,0);
  }
}
