import java.util.*;

public class InputSystem{
 private String input;
 
 public InputSystem(){
   input = "";
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
 
 public void display(){
   text("0 = " + input, 20, 20);
 }
 
 public float function(String s, float x, float y, float z){
   try{
     return(eval(infixToPostfix(s), x, y, z));
   }
   catch (Exception e){
    println(e);
    return 0;
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
        if (stack.size() < 2){
          println(expression);
          throw new IllegalArgumentException("Too few operands");
        }
        float b = stack.removeFirst();
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
    if (stack.size() > 1){
      throw new IllegalArgumentException("Too many operands");
    }
    return Math.abs(stack.removeFirst());
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
      if (stack.size() > 0){
        for (String s: stack){
          answer += " " + s;
        }
      }
      return answer;
    }

    public int order(String s){ // From StackCalculator Lab
      if (s.equals("+") || s.equals("-")){
        return 1;
      }
      if (s.equals("*") || s.equals("/") || s.equals("%")){
        return 2;
      }
      if (s.equals("^")){
        return 3;
      }
      if (s.equals(")") || s.equals("(")){
        return 0;
      }
      return -1;
    }
}
