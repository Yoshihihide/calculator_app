import 'dart:async';
import 'package:flutter/material.dart';
import 'calculation.dart';

const c_op = ['+', '-', '×', '÷'];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(),
        //Addedbutton(),
        Keyboard(),
      ],
    )));
  }
}

//==============================================================================
// 表示
class TextField extends StatefulWidget {
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<TextField> {
  String _expression = '';
  int add = 0, mul = 0;

  void _UpdateText(String letter) {
    setState(() {
      if (letter == 'C') {
        _expression = '';
      } else if (letter == 'CE') {
        add = _expression.lastIndexOf('+');
        _expression.split('-');
        mul = _expression.lastIndexOf('×');
        _expression.split('÷');
        int _endlen = 0;
        int _maxlen = 0;
        for (int i = 0; i < c_op.length; i++) {
          _endlen = _expression.lastIndexOf(c_op[i]);
          if (_maxlen < _endlen) {
            _maxlen = _endlen;
          }
          // print(_maxlen);
          _expression = _expression.substring(0, _expression.length - _maxlen);
        }
      } else if (letter == '=') {
        _expression = '';
        var ans = Calculator.Execute();
        controller.sink.add(ans);
      } else if (letter == '→') {
        _expression = _expression.substring(0, _expression.length - 1);
      } else if (letter == 'e') {
        _expression = 'Error';
      } else
        _expression += letter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              _expression,
              style: TextStyle(
                fontSize: 64.0,
              ),
            ),
          ),
        ));
  }

  static final controller = StreamController<String>.broadcast();
  @override
  void initState() {
    controller.stream.listen((event) => Calculator.GetKey(event));
    controller.stream.listen((event) => _UpdateText(event));
  }
}

//==============================================================================
// 付加メニュー
class Addedbutton extends StatefulWidget {
  const Addedbutton({super.key});

  void _Addedbutton(String test) {}
  @override
  State<Addedbutton> createState() => _AddedbuttonState();
}

class _AddedbuttonState extends State<Addedbutton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Text2",
                style: TextStyle(
                  fontSize: 32.0,
                ),
              ))),
    );
  }
}

//==============================================================================
// キーボード
class Keyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Center(
            child: Container(
          color: Colors.black,
          child: GridView.count(
            padding: const EdgeInsets.all(20), //詰める
            crossAxisCount: 4,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            children: [
              '→',
              'CE',
              'C',
              '÷',
              '7',
              '8',
              '9',
              '×',
              '4',
              '5',
              '6',
              '-',
              '1',
              '2',
              '3',
              '+',
              '00',
              '0',
              '.',
              '=',
            ].map((key) {
              return GridTile(
                child: Button(key),
              );
            }).toList(),
          ),
        )));
  }
}

// キーボタン
class Button extends StatelessWidget {
  final _key;
  Button(this._key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      child: Center(
        child: Text(
          _key,
          style: TextStyle(
            fontSize: 46.0,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: () {
        _TextFiledState.controller.sink.add(_key);
      },
    ));
  }
}
