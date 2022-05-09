import 'package:math_expressions/math_expressions.dart';

class ExpressionProcessing {
  double process(String expressionInput) {
    Parser parser = Parser();
    Expression expression = parser.parse(expressionInput.replaceAll('x', '*'));
    ContextModel contextModel = ContextModel();
    double result = expression.evaluate(EvaluationType.REAL, contextModel);

    return result;
  }
}
