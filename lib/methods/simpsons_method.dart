import 'package:math_expressions/math_expressions.dart';

double simpsonsMethod(String expression, {String variable, double a, double b}){
  try {
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
  } catch(e) {
    throw(e);
  }
}

double compositeSimpsonsMethod(String expression, {String variable, double a, double b, int interval}){
  try {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    Variable myvar = Variable(variable);

    cm.bindVariable(myvar, Number(a));  
    double firstterm = exp.evaluate(EvaluationType.REAL, cm);
    List<double> middleTerms = [];
    double delta = (b-a) / interval;
    for(int i=1; i<interval; i++) {
      if(i % 3 == 0){
        cm.bindVariable(myvar, Number(a + i * delta));  
        double term = 2.0 * exp.evaluate(EvaluationType.REAL, cm);
        middleTerms.add(term);
      }
      else {
        cm.bindVariable(myvar, Number(a + i * delta));  
        double term = 3.0 * exp.evaluate(EvaluationType.REAL, cm);
        middleTerms.add(term);
      }
    }
    cm.bindVariable(myvar, Number(b));  
    double lastterm = exp.evaluate(EvaluationType.REAL, cm);
    double midTotal = 0;
    middleTerms.forEach((element) => (midTotal += element));
    double val = (3 * delta / 8) * (firstterm + lastterm + midTotal);
    return val;
  } catch(e) {
    throw(e);
  }
}
