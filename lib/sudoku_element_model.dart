import 'package:flutter/material.dart';

class SudokuElementModel {
  SudokuElementModel({
    this.value = 0,
    this.readonly = false,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.readonlyTextColor = Colors.black45,
    this.hints = const <int>[0, 0, 0, 0, 0, 0],
  });

  int value;
  bool readonly;
  List<int> hints;
  Color color;
  Color textColor;
  Color readonlyTextColor;
}
