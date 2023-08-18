import 'package:flutter/material.dart';

const c_op = ['+', '-', '×', '÷'];

class Calculator {
  static var _number = [];
  static var _op = [];
  static String _buffer = '';
  static String _Listbuffer = '';
  static void GetKey(String letter) {
    // 四則演算子
    if (c_op.contains(letter)) {
      // _op.add(letter);
      // _number.add(double.parse(_buffer));
      // _buffer = '';
      _buffer += letter;
    } // C
    else if (letter == 'C') {
      _number = [];
      _op = [];
      _buffer = '';
    } else if (letter == 'CE') {
      _op = [];
      //_buffer = '';
    } else if (letter == '→') {
      _buffer = _buffer.substring(0, _buffer.length - 1);
    } // =
    else if (letter == '=') {
      String _nobuffer = '';
      for (int i = 0; i < _buffer.length; i++) {
        if (c_op.contains(_buffer[i])) {
          _op.add(_buffer[i]);
          _number.add(double.parse(_nobuffer));
          _nobuffer = "";
        } else {
          _nobuffer += _buffer[i];
        }
      }
      _number.add(double.parse(_nobuffer));
      return null;
    } // 数字
    else {
      _buffer += letter;
    }
  }

  static double _result = 0;
  static String Execute() {
    //_number.add(double.parse(_buffer));
    if (_number.length == 0) return '0';
    _result = _number[0];
    for (int i = 0; i < _op.length; i++) {
      if (_op[i] == '+')
        _result += _number[i + 1];
      else if (_op[i] == '-')
        _result -= _number[i + 1];
      else if (_op[i] == '×')
        _result *= _number[i + 1];
      else if (_op[i] == '÷' && _number[i + 1] != 0)
        _result /= _number[i + 1];
      else
        return 'e';
    }
    var resultStr = _result.toString().split('.');
    String test = resultStr[1] == '0' ? resultStr[0] : _result.toString();
    _number.clear();
    _op.clear();
    _Listbuffer = _buffer + '=' + test;
    _buffer = '';
    //var resultStr = _result.toString().split('.');
    return resultStr[1] == '0' ? resultStr[0] : _result.toString();
  }
}
