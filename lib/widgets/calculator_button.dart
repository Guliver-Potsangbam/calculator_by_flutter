import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function callback;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.fillColor,
    required this.textColor,
    required this.textSize,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(fillColor),
      child: Container(
        width: (MediaQuery.of(context).size.width / 4) - 10,
        height: 70,
        child: TextButton(
            onPressed: () {
              callback(text);
            },
            child: Text(
              text,
              style: TextStyle(color: Color(textColor), fontSize: textSize),
            )),
      ),
    );
  }
}
