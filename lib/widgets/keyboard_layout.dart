import 'package:flutter/material.dart';
import 'package:flutter_calculator/constants/constant_color.dart';
import 'package:flutter_calculator/widgets/keyboard_button.dart';

class KeyboardLayout extends StatelessWidget {
  const KeyboardLayout({Key? key, this.numberCallback, this.acctionCallback})
      : super(key: key);

  final Function(String)? numberCallback;
  final Function(String)? acctionCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ConstantColor.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardButton(
                  value: 'AC',
                  color: ConstantColor.textColdColor,
                  callback: _tapOnAction,
                ),
                KeyboardButton(
                  value: 'CE',
                  color: ConstantColor.textColdColor,
                  callback: _tapOnAction,
                ),
                KeyboardButton(
                  value: '%',
                  color: ConstantColor.textColdColor,
                  callback: _tapOnAction,
                ),
                KeyboardButton(
                  value: '/',
                  color: ConstantColor.textHotColor,
                  callback: _tapOnNumber,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardButton(
                  value: '7',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '8',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '9',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: 'x',
                  color: ConstantColor.textHotColor,
                  callback: _tapOnNumber,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardButton(
                  value: '4',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '5',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '6',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '-',
                  color: ConstantColor.textHotColor,
                  callback: _tapOnNumber,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardButton(
                  value: '1',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '2',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '3',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '+',
                  color: ConstantColor.textHotColor,
                  callback: _tapOnNumber,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                KeyboardButton(
                  value: '00',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '0',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '.',
                  callback: _tapOnNumber,
                ),
                KeyboardButton(
                  value: '=',
                  color: ConstantColor.textHotColor,
                  callback: _tapOnAction,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // tap on number and operator (+,-,x,/)
  void _tapOnNumber(String number) {
    if (numberCallback != null) numberCallback!(number.toLowerCase());
  }

  // tap on actions
  void _tapOnAction(String action) {
    if (acctionCallback != null) acctionCallback!(action.toLowerCase());
  }
}
