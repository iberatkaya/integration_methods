import 'package:math_expressions/math_expressions.dart';


double trapezoidalMethod(String expression, {String variable, double a, double b, int interval}){
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
        cm.bindVariable(myvar, Number(a + i * delta));  
        double term = 2.0 * exp.evaluate(EvaluationType.REAL, cm);
        middleTerms.add(term);
    }
    cm.bindVariable(myvar, Number(b));  
    double lastterm = exp.evaluate(EvaluationType.REAL, cm);
    double midTotal = 0;
    middleTerms.forEach((element) => (midTotal += element));
    double val = (delta / 2) * (firstterm + lastterm + midTotal);
    return val;
  } catch(e) {
    throw(e);
  }
}
