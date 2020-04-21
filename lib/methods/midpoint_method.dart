import 'package:math_expressions/math_expressions.dart';


double midpointMethod(String expression, {String variable, double a, double b, int interval}){
  try {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    Variable myvar = Variable(variable);

    List<double> terms = [];
    double delta = (b-a) / interval;
    for(int i=1; i<interval; i++) {
        cm.bindVariable(myvar, Number((a + i * delta + a + (i-1) * delta) / 2));  
        double term = exp.evaluate(EvaluationType.REAL, cm);
        terms.add(term);
    }
    double total = 0;
    terms.forEach((element) => (total += element));
    return total * delta;
  } catch(e) {
    throw(e);
  }
}
