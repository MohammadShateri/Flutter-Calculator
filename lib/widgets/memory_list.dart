import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calculator/class/expression_processing.dart';
import 'package:flutter_calculator/constants/constant_color.dart';

class MemoryList extends StatelessWidget {
  const MemoryList({
    Key? key,
    required this.memory,
    required this.callback,
    required this.currentExpression,
  }) : super(key: key);

  final List<String> memory;
  final Function(String) callback;
  final String currentExpression;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ConstantColor.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: memory.length > 0 ? _getList() : _getEmptyMessage(),
      ),
    );
  }

  // get empty message
  Widget _getEmptyMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.hourglass_disabled_rounded,
          color: ConstantColor.textPrimaryColor,
          size: 46,
        ),
        SizedBox(height: 20),
        Text(
          'There are no mathematical expressions',
          style: TextStyle(
            color: ConstantColor.textPrimaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // get list
  Widget _getList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (String expression in memory) _getListItem(expression),
        ],
      ),
    );
  }

  // get list item
  Widget _getListItem(String expression) {
    ExpressionProcessing expressionProcessing = ExpressionProcessing();
    NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

    return GestureDetector(
      onTap: () {
        callback(expression);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: currentExpression == expression
              ? Colors.blueAccent.withOpacity(0.2)
              : Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: double.infinity),
            Text(
              expression,
              style: TextStyle(
                color: ConstantColor.textPrimaryColor,
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.1),
              height: 20,
            ),
            Text(
              numberFormat.format(expressionProcessing.process(expression)),
              style: TextStyle(
                color: ConstantColor.textPrimaryColor,
                fontWeight: FontWeight.w300,
                fontSize: 46,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
