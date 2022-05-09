import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculator/class/expression_processing.dart';
import 'package:flutter_calculator/constants/constant_color.dart';
import 'package:flutter_calculator/widgets/keyboard_layout.dart';
import 'package:flutter_calculator/widgets/memory_list.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  // variables
  String largeResultText = '';
  String smallResultText = '';
  bool showMemoryPage = false;
  List<String> memory = [];

  @override
  Widget build(BuildContext context) {
    // chanche system colors
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ConstantColor.primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ConstantColor.secondaryColor,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ConstantColor.primaryColor,
        body: SafeArea(
          child: _getMainBody(),
        ),
      ),
    );
  }

  // get main body
  Widget _getMainBody() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showMemoryPage = !showMemoryPage;
                    });
                  },
                  child: Icon(
                    showMemoryPage ? Icons.close : Icons.menu,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 27,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: double.infinity),
                _getColoredResult(
                  inputs: _getResultParted(smallResultText),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                    child: _getColoredResult(
                      inputs: _getResultParted(largeResultText),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 54,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 70,
          child: showMemoryPage
              ? MemoryList(
                  memory: memory,
                  currentExpression: smallResultText,
                  callback: _memoryCallback,
                )
              : KeyboardLayout(
                  numberCallback: numberButtonsCallback,
                  acctionCallback: actionButtonsCallback,
                ),
        ),
      ],
    );
  }

  // tap on number buttons
  void numberButtonsCallback(String number) {
    setState(() {
      if (largeResultText.isEmpty &&
          (number == '/' || number == 'x' || number == '-' || number == '+')) {
        largeResultText = '';
      } else {
        largeResultText = '$largeResultText$number';
      }
    });
  }

  // tap on action buttons
  void actionButtonsCallback(String action) {
    setState(() {
      switch (action) {
        case 'ac':
          largeResultText = '';
          smallResultText = '';
          break;
        case 'ce':
          if (largeResultText.length > 0) {
            largeResultText =
                largeResultText.substring(0, largeResultText.length - 1);
          }
          break;
        case '=':
          String trimed = _trim(largeResultText);
          smallResultText = trimed;
          memory.add(trimed);
          ExpressionProcessing expressionProcessing = ExpressionProcessing();
          largeResultText = expressionProcessing.process(trimed).toString();
          break;
        case '%':
          largeResultText += '%';
          break;
      }
    });
  }

  // memory callback
  void _memoryCallback(String expression) {
    ExpressionProcessing expressionProcessing = ExpressionProcessing();
    setState(() {
      smallResultText = expression;
      largeResultText =
          expressionProcessing.process(expression).toStringAsFixed(0);
    });
  }

  // chenge color operator in text
  Widget _getColoredResult({required List<String> inputs, TextStyle? style}) {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        style: style,
        children: <TextSpan>[
          for (String part in inputs)
            TextSpan(
              text: _isOperator(part) ? ' $part ' : part,
              style: TextStyle(
                color: _isOperator(part)
                    ? ConstantColor.textHotColor
                    : Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  // Separate operators from mathematical expressions
  List<String> _getResultParted(String inputPhrase) {
    // isolated phrase
    List<String> returnPhrase = [];
    String temp = '';

    for (int c = 0; c < inputPhrase.length; c++) {
      if (_isOperator(inputPhrase[c])) {
        returnPhrase.add(temp);
        returnPhrase.add(inputPhrase[c]);
        temp = '';
      } else {
        temp += inputPhrase[c];
      }

      if (c == inputPhrase.length - 1 && !temp.isEmpty) {
        returnPhrase.add(temp);
      }
    }

    return returnPhrase;
  }

  // check is operator
  bool _isOperator(String text) {
    return (text == '/' ||
        text == 'x' ||
        text == '-' ||
        text == '+' ||
        text == '%');
  }

  // trim string
  String _trim(String text) {
    String temp = text;

    // check first
    while (_isOperator(text[0])) {
      temp = temp.substring(1, temp.length);
    }

    // check last
    while (_isOperator(text[temp.length - 1])) {
      temp = temp.substring(0, temp.length - 1);
    }

    return temp;
  }
}
