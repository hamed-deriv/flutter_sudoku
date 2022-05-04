import 'package:flutter/material.dart';

import 'package:flutter_sudoku/sudoku_element_model.dart';

List<int> get2dCoordinates(int index) {
  final int row = index ~/ 9;
  final int col = index % 9;

  return <int>[row, col];
}

bool isInSameRowColumnBox(int index, int compareIndex) {
  final int row = get2dCoordinates(index)[0];
  final int col = get2dCoordinates(index)[1];

  final int compareRow = get2dCoordinates(compareIndex)[0];
  final int compareCol = get2dCoordinates(compareIndex)[1];

  final int boxRowStart = row - (row % 3);
  final int boxColumnStart = col - (col % 3);

  return compareRow == row ||
      compareCol == col ||
      compareRow >= boxRowStart &&
          compareRow < boxRowStart + 3 &&
          compareCol >= boxColumnStart &&
          compareCol < boxColumnStart + 3;
}

void highlightRowColBox(
  List<SudokuElementModel> board,
  int index,
  Color color,
  Color selectedColor,
  Color readonlyColor,
) {
  for (int i = 0; i < board.length; i++) {
    if (i == index) {
      board[i].color = selectedColor;
    } else if (isInSameRowColumnBox(index, i)) {
      board[i].color =
          (board[i].readonly ? readonlyColor : color).withOpacity(0.6);
    } else {
      board[i].color =
          (board[i].readonly ? readonlyColor : color).withOpacity(1);
    }
  }
}
