import java.util.*;

ArrayList<PVector> grid = new ArrayList<>();

float cameraMagnitude = 5;
float cameraAngle_1 = 0;
float cameraAngle_2 = 0;

float x1 = cameraMagnitude * cos(cameraAngle_1) *  sin(cameraAngle_2);
float z1 = cameraMagnitude * cos(cameraAngle_2);
float y1 = cameraMagnitude * sin(cameraAngle_1) * sin(cameraAngle_2);

PVector vertLine = new PVector(-x1*z1,-y1*z1, x1*x1 + y1*y1);
PVector horiLine = new PVector(y1, -x1, 0);
PVector normalVector = new PVector(x1,y1,z1);

PVector cameraCords = new PVector(x1,y1,z1);

float multiplier = 1;

float pi = 3.14159263589;
float e = 2.718281828;
float scale = 50;

void setup(){
 size(500,500);
 //colorMode(HSB, 360, 100, 100);
 colorMode(RGB, 255, 255, 255);
 background(255);
 //grid.add(new PVector(-0.7,-3,1.8));
 //float s = 10;
 float m = 0.25;
 for (float i = -10; i < 10; i+=m){
   for (float j = -10; j < 10; j+=m){
     for (float k = -10; k < 10; k+=m){
       if (f(i,j,k,1) < 0.1){
         grid.add(new PVector(i,j,k));
       }
     }
   }
 }
}

float f(float x, float y, float z, float k){
   float c = max(abs(x),abs(y),abs(z))-k;
   return c;
}

void draw(){
  background(255);
  
  vertLine = new PVector(-1,-y1/x1,(x1 + y1*y1/x1) / z1);
  horiLine = new PVector(1, -x1 / y1, 0);
  
  for (PVector point: grid){
    PVector new3dCoords = project3d(point);
    PVector newCoords = project2d(new3dCoords);
    float d = point.dist(cameraCords);
    //fill(100, 100, 3000/d);
    fill(point.x*255,point.y*255,point.z*255);
    ellipse(newCoords.x * width / cameraMagnitude + width/2, newCoords.y * height / cameraMagnitude + height/2, 100 / d / d, 100 / d / d);
  }
}

void keyPressed(){
  if (keyCode == RIGHT){
    cameraAngle_1 -= pi / 100;
  }
  if (keyCode == LEFT){
    cameraAngle_1 += pi / 100;
  }
  if (keyCode == UP){
    cameraAngle_2 += pi / 100;
  }
  if (keyCode == DOWN){
    cameraAngle_2 -= pi / 100;
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
    PVector jVector = vertLine.copy().setMag(1);
    PVector iVector = horiLine.copy().setMag(1);
    
    float y = 0;
    if (jVector.z != 0){
      y = transformedPoint.z / jVector.z;
    }
    float x = 0;
    if (iVector.x != 0){
      x = (transformedPoint.x - y * jVector.x) / iVector.x;
    }
    println(new PVector(x,y));
    return new PVector(x,y);
}
