public class Graph{
  
  ArrayList<Point> Points = new ArrayList<>();
  ArrayList<Point> allPoints = new ArrayList<>();
  
  public Graph(InputSystem inputSys, float threshold, int Dimension, boolean Vector){
    background(255);
    float m = 0.25;
    if (Dimension == 2){
      m = 0.05;
    }
    if (Vector){
      m = 0.05;
    }
    inputSys.evaluate();
    for (float i = -10; i <= 10; i+=m){
      println(i);
      for (float j = -10; j <= 10; j+=m){
        if (Dimension == 3){
          for (float k = -10; k <= 10; k+=m){
             if (abs(inputSys.function(i,j,k)) < threshold){
               Points.add(new Point(i,j,-k,inputSys)); // Adds given point to graph if it is within a certain error bound
             }
           }
        }
        if (Dimension == 2){
          Point p = new Point(i,j,0, inputSys);
          if (abs(inputSys.function(i,j,0)) < threshold){
            Points.add(p); // Saves points to optimize switching to normal 2D
          }
          if ((abs(i) % 0.25 < 0.01 || abs(i) % 0.25 > 0.24) && (abs(j) % 0.25 < 0.01 || abs(j) % 0.25 > 0.24)){
            allPoints.add(p); // Saves points to optimize switching to vectors
          }
          p.setCoords2D(p.getCoords3D()); // Optimizes plotting in 2D
        }
       }
    }
  }
  
  public void displayVector(){ // Display vectors for all points
    background(255);
    displayAxis();
    inputSys.display();
    for (Point p: allPoints){
      p.displayVector(camera);
    }
  }
  
  public void displayIntegral(){
    background(255);
    displayAxis();
    float totalArea = 0;
    inputSys.display();
    for (Point p: Points){
      totalArea += p.displayIntegral(camera, 0.05); // Adds the area of a bunch of small rectangles to estimate area under curve.
    }
    fill(0,0,0);
    text("Estimate of Total Area under Curve ~ " + totalArea, width - 250, 10); // Not very accurate, but I trie dmy best
  }
  
  public ArrayList<Point> getPts(){
    return Points;
  }
  
  public void display(){ // Display points 2D and 3D
    background(255);
    displayAxis();
    inputSys.display();
    for (Point p: Points){
     p.display(camera);
   }
  }
  
  public void displayAxis(){ // Display the Axes of the graph in 2D and 3D space
    ArrayList<Point> ranges = new ArrayList<>();
    ranges.add(new Point (0,0,10, inputSys));
    ranges.add(new Point (0,0,-10, inputSys));
    ranges.add(new Point (0,10,0, inputSys));
    ranges.add(new Point (0,-10,0, inputSys));
    ranges.add(new Point (10,0,0, inputSys));
    ranges.add(new Point (-10,0,0, inputSys));
    for (Point point: ranges){
         PVector loc = point.getCoords3D();
         PVector new3dCoords = project3d(loc);
         PVector newCoords = project2d(new3dCoords);
         point.setCoords2D(newCoords);
     }
     ArrayList<String> s = new ArrayList<>();
     s.add("Z");
     s.add("Y");
     s.add("X");
     strokeWeight(1);
     fill(0,0,0);
     for (int i = 0; i < 6; i += 2){
       line(ranges.get(i).getCoords2D().x*width/cameraMagnitude+width/2,ranges.get(i).getCoords2D().y*-height/cameraMagnitude+height/2,ranges.get(i+1).getCoords2D().x*width/cameraMagnitude+width/2,height/2+-ranges.get(i+1).getCoords2D().y*height/cameraMagnitude);
     }
     if (Dimension == 3){
       for (int i = 0; i < 2; i++){
         text(10*((i%2)*2-1) + s.get(i / 2),ranges.get(i).getCoords2D().x*width/cameraMagnitude+width/2,ranges.get(i).getCoords2D().y*-height/cameraMagnitude+height/2);
       }
       for (int i = 2; i < 6; i++){
         text(10*((1-i%2)*2-1) + s.get(i / 2),ranges.get(i).getCoords2D().x*width/cameraMagnitude+width/2,ranges.get(i).getCoords2D().y*-height/cameraMagnitude+height/2);
       }
     }
     else{
       for (int i = 2; i < 6; i++){
         text(-10*(2*(ceil(abs(i-3.5))-1)-1) + s.get(i / 2),ranges.get(i).getCoords2D().x*width/cameraMagnitude+width/2,ranges.get(i).getCoords2D().y*-height/cameraMagnitude+height/2);
       }
     }
  }
  
    
  PVector project3d(PVector point){ // Finds the 3D point at which the line between the camera point and given point intersects the projection plane
    PVector lineVector = point.copy().sub(cameraCords);
    float xP = lineVector.x;
    float yP = lineVector.y;
    float zP = lineVector.z;
    
    float x2 = (y1*yP*x1 - y1*xP*y1 + z1*zP*x1 - z1*xP*z1) / (x1*xP + y1*yP + z1*zP);
    float y2 = (x1*xP*y1 - x1*yP*x1 + z1*zP*y1 - z1*yP*z1) / (x1*xP + y1*yP + z1*zP);
    float z2 = (y1*yP*z1 - y1*zP*y1 + x1*xP*z1 - x1*zP*x1) / (x1*xP + y1*yP + z1*zP);
    
    return new PVector(x2,y2,z2);
  }
  
  PVector project2d(PVector transformedPoint){ // Takes in the 3D point of intersection and converts it into a combination of unit vectors
    //if (transformedPoint.mag() != 0){
    //  double theta = acos(max(-1,min((transformedPoint.dot(vertLine) / transformedPoint.mag() / vertLine.mag()),1)));
    //  if (cameraCords.dot(transformedPoint.cross(vertLine)) < 0){
    //    theta *= -1;
    //  }
    //  theta += pi/2;
    //  float r = transformedPoint.mag();
    //  return new PVector(r * cos((float) theta), r * sin((float) theta));
    //}
    //return new PVector(0,0);
    PVector jVector = vertLine.copy().setMag(1); // "Up" (y-coordinate) in new plane
    PVector iVector = horiLine.copy().setMag(1); // "Right" (x-coordinate) in new plane
    
    float y = 0;
    if (jVector.z != 0){
      y = transformedPoint.z / jVector.z; // y unit vectors will always include a z component which we can use to determine the amount of unit vectors used
    }
    else{
      y = -transformedPoint.y;
    }
    float x = 0;
    if (iVector.x != 0){
      x = (transformedPoint.x - y * jVector.x) / iVector.x; // Use the # of y vectors to find the x vecotr
    }
    else{
      x = (transformedPoint.y - y * jVector.y) / iVector.y;
    }
    return new PVector(x,y); // Projected point 2D coords
  }
}
