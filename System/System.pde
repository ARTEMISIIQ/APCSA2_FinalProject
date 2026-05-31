import java.util.*;
  
  private float pi = 3.14159263589;
  
  private Camera camera = new Camera(100,pi/4+0.01,0.01+5*pi/4);
  private InputSystem inputSys = new InputSystem();
  private Graph Graph;
  
  private PVector cameraCords = camera.getVector();
  
  private float x1 = cameraCords.x;
  private float y1 = cameraCords.y;
  private float z1 = cameraCords.z;
  private float cameraMagnitude = camera.getMag();
  private float cameraAngle_1 = camera.getAng1();
  private float cameraAngle_2 = camera.getAng2();
  
  private PVector vertLine = new PVector(x1*z1,y1*z1,-(x1*x1 + y1*y1));
  private PVector horiLine = new PVector(y1,-x1, 0);
  
  private String equation = "x * sin x + ( y - 5 ) ^ 2";
  
  private int Dimension = 3;
  private boolean Vector = false;
  private boolean Derivative = false;
  private boolean Integral = false;
  private boolean Polar = false;
  
  void setup(){
   size(500,500);
   inputSys.setInput(equation);
   Graph = new Graph(inputSys, 0.25, Dimension, Vector);
   display();
  }
  
  void draw(){
    changeVariables();
    inputSys.display();
  }
  
  void keyPressed(){
    if (Dimension == 3){
      if (keyCode == RIGHT){
        camera.setAng1(cameraAngle_1-pi/100);
        display();
      }
      if (keyCode == LEFT){
        camera.setAng1(cameraAngle_1+pi/100);
        display();
      }
      if (keyCode == UP){
        camera.setAng2(cameraAngle_2+pi/100);
        display();
      }
      if (keyCode == DOWN){
        camera.setAng2(cameraAngle_2-pi/100);
        display();
      }
    }
    if (key == 'e'){
      camera.setMag(cameraMagnitude+5);
      display();
    }
    if (key == 'q'){
      camera.setMag(cameraMagnitude-5);
      display();
    }
    if (((int) key >= (int) '0' && (int) key <= (int) '9') || key == 'x' || key == 'y' || key == 'z' || key == '.'){
      inputSys.addChar("" + key);
    }
    if (key == 's'){
      inputSys.addChar("sin ");
    }
    if (key == 'c'){
      inputSys.addChar("cos ");
    }
    if (key == 't'){
      inputSys.addChar("tan ");
    }
    if (key == '(' || key == '/' || key == '*' || key == '+' || key == '-' || key == ')' || key == '^'){
      inputSys.addChar(" " + key + " ");
    }
    if (keyCode == BACKSPACE){
      inputSys.remChar();
    }
    if (keyCode == ENTER){
      if (Dimension == 2){
        Graph = new Graph(inputSys, 0.15, Dimension, Vector);
      }
      else{
       Graph = new Graph(inputSys, 0.25, Dimension, Vector); 
      }
      display();
    }
    if (key == 'd' && !Vector){
      Dimension = 5 - Dimension;
      Vector = false;
      Derivative = false;
      Integral = false;
      Polar = false;
      if (Dimension == 2){
        camera.setAng1(0);
        camera.setAng2(0);
        Graph = new Graph(inputSys, 0.1, Dimension, Vector);
      }
      else{
        camera.setAng1(pi/4+0.01);
        camera.setAng2(5*pi/4+0.01);
        Graph = new Graph(inputSys, 0.25, Dimension, Vector);
      }
      Graph.displayAxis();
      display();
    }
    if (key == 'v' && Dimension == 2 && !Derivative && !Integral){
      Vector = !Vector;
      display();
    }
    if (key == 'i' && Dimension == 2 && !Derivative && !Vector){
      Integral = !Integral;
      display();
    }
    if (key == 'p' && Dimension == 3){
      Polar = !Polar;
      inputSys.flipPolar();
      changeVariables();
      inputSys.display();
      Graph = new Graph(inputSys, 0.25, Dimension, Vector);
      display();
    }
    
    cameraMagnitude = camera.getMag();
    cameraAngle_1 = camera.getAng1();
    cameraAngle_2 = camera.getAng2();
    cameraCords = camera.getVector();
      
    vertLine = camera.getVert();
    horiLine = camera.getHori();
    
    x1 = cameraCords.x;
    y1 = cameraCords.y;
    z1 = cameraCords.z;
  }
  
  void keyReleased(){
    if (key == ',' && Dimension == 2 && !Vector && !Integral){
      display();
      Derivative = !Derivative;
    }
  }
  
  void mouseDragged(){
    if (Dimension == 2 && Derivative){
      Derivative d = new Derivative((mouseX-width/2) * cameraMagnitude / width, inputSys, Graph);
      Graph.display();
      d.display();
    }
  }
  
  void display(){
    background(255);
    inputSys.display();
    if (Dimension == 2){
      if (Vector){
        Graph.displayVector();
      }
      else if (Integral){
        Graph.displayIntegral();
      }
      else{
        Graph.display();
      }
    }
    else{
      for (Point point: Graph.getPts()){
         PVector loc = point.getCoords3D();
         PVector new3dCoords = Graph.project3d(loc);
         PVector newCoords = Graph.project2d(new3dCoords);
         point.setCoords2D(newCoords);
         point.display(camera);
      }
    }
    Graph.displayAxis();
  }
  
  void changeVariables(){
    String s = inputSys.getInput();
    String newS = "";
    for (int i = 0; i < s.length(); i++){
      char c = s.charAt(i);
      if (Polar){
        if (c == 'x'){
          newS += "r";
        }
        else if (c == 'y'){
          newS += "\u03B8";
        }
        else if (c == 'z'){
          newS += "\u03C6";
        }
        else{
          newS += c;
        }
      }
      else{
        if (c == 'r'){
          newS += "x";
        }
        else if (c == '\u03B8'){
          newS += "y";
        }
        else if (c == '\u03C6'){
          newS += "z";
        }
        else{
          newS += c;
        }
      }
    }
    inputSys.setInput(newS);
  }
