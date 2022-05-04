import 'package:flutter/material.dart';

class SudokuElementModel {
  SudokuElementModel({
    required this.color,
    required this.textColor,
    required this.readonlyTextColor,
    this.value = 0,
    this.readonly = false,
    this.hints = const <int>[0, 0, 0, 0, 0, 0],
  });

  Color color;
  Color textColor;
  Color readonlyTextColor;
  int value;
  bool readonly;
  List<int> hints;
}
