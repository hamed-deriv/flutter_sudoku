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
  Color selectedItemColor,
  Color sameValueColor,
  Color selectedRowColBoxColor,
) {
  for (int i = 0; i < board.length; i++) {
    if (i == index) {
      board[i].color = selectedItemColor;
    } else if (isInSameRowColumnBox(index, i)) {
      board[i].color = selectedRowColBoxColor;
    } else if (board[i].value == board[index].value && board[i].value != 0) {
      board[i].color = sameValueColor;
    } else {
      board[i].color = color;
    }
  }
}

void highlightInvalidEntry(
  List<SudokuElementModel> board,
  List<List<int>> solvedBoard,
  int index,
  Color textColor,
  Color invalidTextColor,
) {
  final List<int> coordinates = get2dCoordinates(index);
  final int solvedBoardValue = solvedBoard[coordinates[0]][coordinates[1]];

  board[index].textColor =
      solvedBoardValue == board[index].value ? textColor : invalidTextColor;
}
