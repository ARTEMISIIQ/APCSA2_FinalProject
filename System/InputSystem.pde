public class InputSystem{
 private String input;
 
 public InputSystem(){
   resetInput();
 }
 
 public void resetInput(){
   this.input = "";
 }
 
 public void addInput(char c){
  input += c; 
 }
 
 public void display(){
   text(input, 0, 0);
 }
 
 public float function(String s){
   println(s);
  char c = s.charAt(0);
  int i = 0;
  if (c == '('){
    int endParent = 0;
    while (s.charAt(endParent) != ')'){
     endParent++; 
    }
    if (s.length() > endParent - 1){
      return function(function(s.substring(1,endParent))+s.substring(endParent+1));
    }
    else{
     return function(s.substring(0,s.length()-1)); 
    }
  }
  while (((int) c <= (int) ('9') && (int) c >= (int) ('0')) || c == '.' || c == '-'){
    i++;
    if (s.length() <= i){
      return Float.parseFloat(s);
    }
    c=s.charAt(i);
  }
  if (c=='^'){
   return (float) Math.pow(Float.parseFloat(s.substring(0,i)), function(s.substring(i+1))); 
  }
  if (c=='/'){
   return Float.parseFloat(s.substring(0,i)) / function(s.substring(i+1)); 
  }
  if (c=='*'){
   return Float.parseFloat(s.substring(0,i)) * function(s.substring(i+1)); 
  }
  if (c=='-'){
   return Float.parseFloat(s.substring(0,i)) - function(s.substring(i+1)); 
  }
  if (c=='+'){
   return Float.parseFloat(s.substring(0,i)) + function(s.substring(i+1)); 
  }
  println(c);
  return Float.parseFloat(s);
 }
}
