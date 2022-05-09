import 'package:flutter/material.dart';
import 'package:flutter_calculator/constants/constant_color.dart';

class KeyboardButton extends StatelessWidget {
  const KeyboardButton({
    Key? key,
    required this.value,
    this.callback,
    this.color,
  }) : super(key: key);

  final String value;
  final Function(String)? callback;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (callback != null) callback!(value);
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: ConstantColor.buttonBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: color ?? ConstantColor.textPrimaryColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
