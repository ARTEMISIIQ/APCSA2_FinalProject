import java.util.*;
  
  private float pi = 3.14159263589;
  private float e = 2.718281828;
  
  private Camera camera = new Camera(100,pi/2,pi/2);
  private InputSystem inputSys = new InputSystem();
  private GraphRectangular Graph;
  
  private PVector cameraCords = camera.getVector();
  
  private float x1 = cameraCords.x;
  private float y1 = cameraCords.y;
  private float z1 = cameraCords.z;
  private float cameraMagnitude = camera.getMag();
  private float cameraAngle_1 = camera.getAng1();
  private float cameraAngle_2 = camera.getAng2();
  
  private PVector vertLine = new PVector(x1*z1,y1*z1,-(x1*x1 + y1*y1));
  private PVector horiLine = new PVector(y1,-x1, 0);
  
  private String equation = "x + y + z - 1";
  
  void setup(){
   size(500,500);
   Graph = new GraphRectangular(inputSys, equation, 1.0);
  }
  
  void draw(){
    background(255);
  
    inputSys.display();
  
    vertLine = camera.getVert();
    horiLine = camera.getHori();
    
    x1 = cameraCords.x;
    y1 = cameraCords.y;
    z1 = cameraCords.z;
    
    for (Point point: Graph.getPts()){
      PVector loc = point.getCoords3D();
      PVector new3dCoords = project3d(loc);
      PVector newCoords = project2d(new3dCoords);
      point.setCoords2D(newCoords);
      point.display(camera);
    }
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
    if (((int) key >= (int) '0' && (int) key <= (int) '9') || key == 'x' || key == 'y' || key == 'z'){
      inputSys.addChar("" + key);
    }
    if (key == '(' || key == '/' || key == '*' || key == '+' || key == '-' || key == ')' || key == '^'){
      inputSys.addChar(" " + key + " ");
    }
    if (keyCode == ENTER){
      Graph = new GraphRectangular(inputSys, inputSys.getInput(), 0.5);
    }
    if (keyCode == BACKSPACE){
      inputSys.remChar();
    }
    cameraMagnitude = camera.getMag();
    cameraAngle_1 = camera.getAng1();
    cameraAngle_2 = camera.getAng2();
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
    //PVector jVector = vertLine.copy().setMag(1);
    //PVector iVector = horiLine.copy().setMag(1);
    
    //float y = 0;
    //if (jVector.z == 0){
    //  y = transformedPoint.z / jVector.z;
    //}
    //float x = 0;
    //if (iVector.x == 0){
    //  x = (transformedPoint.x - y * jVector.x) / iVector.x;
    //}
    //return new PVector(x,y);
  }
