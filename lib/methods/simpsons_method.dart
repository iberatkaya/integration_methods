import 'package:math_expressions/math_expressions.dart';

double simpsons_method(String expression, {String variable, double a, double b}){
  Parser p = Parser();
  Expression exp = p.parse(expression);
  ContextModel cm = ContextModel();
  Variable myvar = Variable(variable);


  cm.bindVariable(myvar, Number(a));  
  double term1 = exp.evaluate(EvaluationType.REAL, cm);
  cm.bindVariable(myvar, Number((2.0 * a + b) / 3));  
  double term2 = 3.0 * exp.evaluate(EvaluationType.REAL, cm);
  cm.bindVariable(myvar, Number((a + 2.0 * b) / 3));  
  double term3 = 3.0 * exp.evaluate(EvaluationType.REAL, cm);
  cm.bindVariable(myvar, Number(b));  
  double term4 = exp.evaluate(EvaluationType.REAL, cm);
  double val = (b-a) / 8 * (term1 + term2 + term3 + term4);
  return val;
}
