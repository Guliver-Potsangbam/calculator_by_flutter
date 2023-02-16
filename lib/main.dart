import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'widgets/calculator_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = '';
  String output = '';
  String operand = '';
  String operator = '';
  bool clear = true;

  ButtonOnClick(btnVal) {
    //clear screen
    if (btnVal == 'C') {
      input = '';
      output = '';
      clear = true;
      operand = operator = '';
    } else if (btnVal == 'AC') {
      input = '';
      output = '';
      clear = true;
      operand = operator = '';
    }
    // delete a single character from right
    else if (btnVal == '<') {
      input = input.substring(0, input.length - 1);
      if (operand.isNotEmpty) {
        operand = operand.substring(0, operand.length - 1);
      }

      final regexp = RegExp(r'(\+|-|\*|\/)*(\w+)$');

// find the first match though you could also do `allMatches`
      final match = regexp.firstMatch(input);

// group(0) is the full matched text
// if your regex had groups (using parentheses) then you could get the
// text from them by using group(1), group(2), etc.
      final matchedText = match?.group(2);
      operand = matchedText.toString(); //
      // log(operand);
    }
    // change negative-positive operand
    else if (btnVal == '+/-') {
      if (input[input.length - 1] != '+' ||
          input[input.length - 1] != '-' ||
          input[input.length - 1] != '*' ||
          input[input.length - 1] != '/' ||
          input[input.length - 1] != '%') {
        log(operand);
        if (operand[0] == '-') {
          operand = operand.substring(1);
          input =
              input.substring(0, input.length - operand.length - 1) + operand;
        } else {
          operand = '-' + operand;
          input =
              input.substring(0, input.length - operand.length + 1) + operand;
        }
        log(operand);
      }
    }
    // when we need output
    else if (btnVal == '=') {
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel ctx = ContextModel();
      double eval = exp.evaluate((EvaluationType.REAL), ctx);
      output = eval.toString();
      clear = false;
      operator = '';
    }
    //when click on operators
    else if (btnVal == '%' ||
        btnVal == '/' ||
        btnVal == 'x' ||
        btnVal == '-' ||
        btnVal == '+') {
      if (operator.isEmpty) {
        if (btnVal == 'x') {
          operator = '*';
        } else {
          operator = btnVal;
        }
        input = input + operator;
        operand = '';
      } else {
        if (btnVal == 'x') {
          operator = '*';
        } else {
          operator = btnVal;
        }
        input = input.substring(0, input.length - 1) + operator;
        operand = '';
      }
      log(operand);
    }

    //when click on numbers
    else {
      operand = operand + btnVal;
      input = input + btnVal;
      operator = '';
    }

    setState(() {
      input = input;
      // log(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 35),
        ),
        actions: [
          PopupMenuButton(itemBuilder: ((context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.black,
                    ),
                    Text("History"),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.black,
                    ),
                    Text("About"),
                  ],
                ),
              ),
            ];
          }))
        ],
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 13,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      input,
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 45),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      output,
                      style: TextStyle(color: Color(0x66FFFFFF), fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.black),
          Expanded(
            flex: 17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CalculatorButton(
                      text: clear ? 'C' : 'AC',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '7',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '4',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '1',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '+/-',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CalculatorButton(
                      text: '<',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '8',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '5',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '2',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '0',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CalculatorButton(
                      text: '%',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '9',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '6',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '3',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '.',
                      fillColor: 0xFFFFFFFF,
                      textColor: 0xFF000000,
                      textSize: 45,
                      callback: ButtonOnClick,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CalculatorButton(
                      text: '/',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: 'x',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '-',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 25,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '+',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                    CalculatorButton(
                      text: '=',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: ButtonOnClick,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card _card(BuildContext context, String face) {
    return Card(
      child: Container(
        width: (MediaQuery.of(context).size.width / 4) - 10,
        height: 70,
        child: TextButton(
            onPressed: () {
              setState(() {});
            },
            child: Text(
              face,
              style: TextStyle(color: Colors.black, fontSize: 20),
            )),
      ),
    );
  }
}
