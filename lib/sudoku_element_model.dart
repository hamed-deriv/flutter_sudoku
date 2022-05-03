import 'package:flutter/material.dart';

class SudokuElementModel {
  SudokuElementModel({
    this.value = 0,
    this.readonly = false,
    this.color = Colors.grey,
    this.hints = const <int>[0, 0, 0, 0, 0, 0],
  });

  int value;
  bool readonly;
  List<int> hints;
  Color color;
}
