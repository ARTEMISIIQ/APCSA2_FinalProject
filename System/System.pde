import java.util.*;

  ArrayList<PVector> grid = new ArrayList<>();
  
  Camera camera = new Camera(100,0.00001,0.00001);
  
  PVector cameraCords = camera.getVector();
  
  float x1 = cameraCords.x;
  float y1 = cameraCords.y;
  float z1 = cameraCords.z;
  float cameraMagnitude = camera.getMag();
  float cameraAngle_1 = camera.getAng1();
  float cameraAngle_2 = camera.getAng2();
  
  PVector vertLine = new PVector(x1*z1,y1*z1,-(x1*x1 + y1*y1));
  PVector horiLine = new PVector(y1,-x1, 0);
  
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
         if (f(i,j,k) < 0.5){
           grid.add(new PVector(i,j,k));
         }
       }
     }
   }
  }
  
  float f(float x, float y, float z){
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
      camera.setAng1(cameraAngle_1-pi/100);
    }
    if (keyCode == LEFT){
      camera.setAng1(cameraAngle_1+pi/100);
    }
    if (keyCode == UP){
      camera.setAng2(cameraAngle_2+pi/100);
    }
    if (keyCode == DOWN){
      camera.setAng2(cameraAngle_2-pi/100);
    }
    if (key == 'e'){
      camera.setMag(cameraMagnitude+5);
    }
    if (key == 'q'){
      camera.setMag(cameraMagnitude-5);
    }
    cameraCords = camera.getVector();
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
