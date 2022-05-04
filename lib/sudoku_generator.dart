import 'package:flutter/material.dart';
import 'package:flutter_sudoku/sudoku_element_model.dart';

final List<List<int>> boardBlueprint = <List<int>>[
  <int>[7, 0, 2, 0, 5, 0, 6, 0, 0],
  <int>[0, 0, 0, 0, 0, 3, 0, 0, 0],
  <int>[1, 0, 0, 0, 0, 9, 5, 0, 0],
  <int>[8, 0, 0, 0, 0, 0, 0, 9, 0],
  <int>[0, 4, 3, 0, 0, 0, 7, 5, 0],
  <int>[0, 9, 0, 0, 0, 0, 0, 0, 8],
  <int>[0, 0, 9, 7, 0, 0, 0, 0, 5],
  <int>[0, 0, 0, 2, 0, 0, 0, 0, 0],
  <int>[0, 0, 7, 0, 4, 0, 2, 0, 3]
];

List<SudokuElementModel> generateRandomSudoku(
  List<List<int>> boardBlueprint,
  Color color,
  Color readonlyColor,
) {
  final List<SudokuElementModel> board = <SudokuElementModel>[];

  for (int i = 0; i < boardBlueprint.first.length; i++) {
    for (int j = 0; j < boardBlueprint.first.length; j++) {
      final bool isEmpty = boardBlueprint[i][j] == 0;

      board.add(
        SudokuElementModel(
          value: isEmpty ? 0 : boardBlueprint[i][j],
          readonly: !isEmpty,
          color: isEmpty ? color : readonlyColor,
        ),
      );
    }
  }

  return board;
}
