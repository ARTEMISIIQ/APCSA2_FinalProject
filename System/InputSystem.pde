import java.util.*;

public class InputSystem{
 private String input;
 private String inputPostfix;
 
 private boolean blink = false;
 
 public InputSystem(){
   input = "";
   inputPostfix = "";
 }
 
 public void addChar(String c){
  input += c;
 }
 
 public void remChar(){
  if (input.length() > 0){
   if (input.charAt(input.length()-1) == ' '){
     input = input.substring(0,input.length()-2); 
   }
   input = input.substring(0,input.length()-1); 
  }
 }
 
 public String getInput(){
  return input;
 }
 
 public void setInput(String s){
  input = s;
 }
 
 public void evaluate(){
   inputPostfix = infixToPostfix(input);
   println(inputPostfix);
 }
 
 public void display(){
   fill(255);
   rect(15,10,470,15);
   fill(0);
   text("0 = " + input + "|", 20, 20);
 }
 
 public float function(float x, float y, float z){
   try{
     return(eval(inputPostfix, x, y, z));
   }
   catch (Exception e){
    return Integer.MAX_VALUE;
   }
 }
 
 public float eval(String expression, float x, float y, float z){ // From StackCalculator Lab
    ArrayDeque<Float> stack = new ArrayDeque<>();
    String[] stringArr = expression.split(" ");
    for (String s: stringArr){
      try{
        if (s.equals("x")){
         stack.addFirst(x); 
        }
        else if (s.equals("y")){
         stack.addFirst(y); 
        }
        else if (s.equals("z")){
         stack.addFirst(z); 
        }
        else {
          stack.addFirst(Float.parseFloat(s));
        }
      }
      catch (Exception e){
        if (s != ""){
          if (stack.size() < 2 && !s.equals("sin") && !s.equals("cos") && !s.equals("tan")){
            println(expression + ":" + s);
            throw new IllegalArgumentException("Too few operands");
          }
          float b = stack.removeFirst();
          if (s.equals("sin")){
            stack.addFirst(sin(b));
          }
          else if (s.equals("cos")){
            stack.addFirst(cos(b));
          }
          else if (s.equals("tan")){
            stack.addFirst(tan(b));
          }
          else{
            float a = stack.removeFirst();
            if (s.equals("+")){
              stack.addFirst(a + b);
            }
            if (s.equals("-")){
              stack.addFirst(a - b);
            }
            if (s.equals("*")){
              stack.addFirst(a * b);
            }
            if (s.equals("/")){
              if (b == 0){
                throw new ArithmeticException("Cannot divide by 0");
              }
              stack.addFirst(a / b);
            }
            if (s.equals("^")){
              stack.addFirst((float) Math.pow(a,b));
            }
          }
        }
      }
    }
    if (stack.size() > 1){
      throw new IllegalArgumentException("Too many operands");
    }
    return stack.removeFirst();
  }

  public String infixToPostfix(String infix) { // From StackCalculator Lab
      String answer = "";
      ArrayDeque<String> stack = new ArrayDeque<>();
      String[] stringArr = infix.split(" ");
      for (String s: stringArr){
        if (s.equals("x") || s.equals("y") || s.equals("z")){
          if (stack.size() != 0){
            answer += " ";
          }
          answer += s;
        }
        else{
          try{
            double c = Double.parseDouble(s);
            if (!answer.equals("")){
              answer += " ";
            }
            answer += c;
          }
          catch (Exception e){
            if (s != ""){
              if (stack.size() == 0){
                stack.addFirst(s);
              }
              else{
                String o = stack.getFirst();
                boolean flag = true;
                if (s.equals("(")){
                  stack.addFirst(s);
                }
                else {
                  while (order(o) >= order(s) && stack.size() > 0) {
                    if (o.equals("(") && s.equals(")")) {
                      stack.removeFirst();
                      flag = false;
                      break;
                    }
                    else {
                      answer += " " + stack.removeFirst();
                      if (stack.size() > 0) {
                        o = stack.getFirst();
                      }
                    }
                  }
                  if (flag) {
                    stack.addFirst(s);
                  }
                }
              }
            }
          }
        }
      }
      if (stack.size() > 0){
        for (String s: stack){
          answer += " " + s;
        }
      }
      return answer;
    }

    public float order(String s){ // From StackCalculator Lab
      if (s.equals("+") || s.equals("-")){
        return 1;
      }
      if (s.equals("*") || s.equals("/") || s.equals("%")){
        return 2;
      }
      if (s.equals("^")){
        return 3;
      }
      if (s.equals("sin") || s.equals("cos") || s.equals("tan")){
        return 3.5;
      }
      if (s.equals(")") || s.equals("(")){
        return 0;
      }
      return -1;
    }
}
