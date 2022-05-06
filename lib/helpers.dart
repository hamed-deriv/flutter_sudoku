import 'package:flutter/material.dart';

import 'package:flutter_sudoku/sudoku_element_model.dart';

int getBoxStartColumn(int col) => col - (col % 3);

int getBoxStartRow(int row) => row - (row % 3);

List<int> get2dCoordinates(int index) {
  final int row = index ~/ 9;
  final int col = index % 9;

  return <int>[row, col];
}

int getRow(int index) => get2dCoordinates(index)[0];

int getColumn(int index) => get2dCoordinates(index)[1];

bool isInSameRowColumnBox({
  required int index,
  required int compareIndex,
}) {
  final int row = getRow(index);
  final int col = getColumn(index);

  final int compareRow = getRow(compareIndex);
  final int compareCol = getColumn(compareIndex);

  final int boxRowStart = getBoxStartRow(row);
  final int boxColumnStart = getBoxStartColumn(col);

  return compareRow == row ||
      compareCol == col ||
      compareRow >= boxRowStart &&
          compareRow < boxRowStart + 3 &&
          compareCol >= boxColumnStart &&
          compareCol < boxColumnStart + 3;
}

void highlightRowColBox({
  required List<SudokuElementModel> board,
  required int index,
  required Color color,
  required Color selectedColor,
  required Color sameValueColor,
  required Color selectedRowColBoxColor,
}) {
  for (int i = 0; i < board.length; i++) {
    if (i == index) {
      board[i].color = selectedColor;
    } else if (isInSameRowColumnBox(index: index, compareIndex: i)) {
      board[i].color = selectedRowColBoxColor;
    } else if (board[i].value == board[index].value && board[i].value != 0) {
      board[i].color = sameValueColor;
    } else {
      board[i].color = color;
    }
  }
}

void highlightInvalidEntry({
  required List<SudokuElementModel> board,
  required List<List<int>> solvedBoard,
  required int index,
  required Color textColor,
  required Color invalidTextColor,
  bool showInvalidEntries = false,
}) {
  final int row = getRow(index);
  final int col = getColumn(index);

  final int solvedBoardValue = solvedBoard[row][col];

  final List<bool> rowValidated =
      validateRow(value: board[index].value, board: board, row: row);
  final List<bool> colValidated =
      validateCol(value: board[index].value, board: board, col: col);
  final List<bool> boxValidated =
      validateBox(value: board[index].value, board: board, row: row, col: col);

  for (int i = 0; i < board.length; i++) {
    board[i].textColor = board[index].value == 0 ||
            (rowValidated[i] && colValidated[i] && boxValidated[i])
        ? textColor
        : invalidTextColor;
  }

  if (showInvalidEntries) {
    board[index].textColor =
        solvedBoardValue == board[index].value ? textColor : invalidTextColor;
  }
}

bool hasDuplicateValueInRow({
  required int value,
  required List<List<SudokuElementModel>> board,
  required int row,
}) =>
    board[row]
        .where((SudokuElementModel element) => element.value == value)
        .length >
    1;

bool hasDuplicateValueInCol({
  required int value,
  required List<List<SudokuElementModel>> board,
  required int col,
}) {
  final List<SudokuElementModel> cols = <SudokuElementModel>[];

  for (int i = 0; i < 9; i++) {
    cols.add(board[i][col]);
  }

  return cols
          .where((SudokuElementModel element) => element.value == value)
          .length >
      1;
}

bool hasDuplicateValueInBox({
  required int value,
  required List<List<SudokuElementModel>> board,
  required int row,
  required int col,
}) {
  final int boxRowStart = getBoxStartRow(row);
  final int boxColumnStart = getBoxStartColumn(col);

  int count = 0;

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[boxRowStart + i][boxColumnStart + j].value == value) {
        count++;
      }

      if (count > 1) {
        return true;
      }
    }
  }

  return false;
}

List<bool> validateRow({
  required int value,
  required List<SudokuElementModel> board,
  required int row,
}) {
  final List<List<SudokuElementModel>> board2d = convertTo2d(board: board);
  final bool hasDuplicate =
      hasDuplicateValueInRow(value: value, board: board2d, row: row);

  final List<bool> result = List<bool>.filled(81, true);

  for (int i = 0; i < 9; i++) {
    final int index = row * 9 + i;

    if (!board[index].readonly && board[index].value == value) {
      result[index] = !hasDuplicate;
    }
  }

  return result;
}

List<bool> validateCol({
  required int value,
  required List<SudokuElementModel> board,
  required int col,
}) {
  final List<List<SudokuElementModel>> board2d = convertTo2d(board: board);
  final bool hasDuplicate =
      hasDuplicateValueInCol(value: value, board: board2d, col: col);

  final List<bool> result = List<bool>.filled(81, true);

  for (int i = 0; i < 9; i++) {
    final int index = i * 9 + col;

    if (!board[index].readonly && board[index].value == value) {
      result[index] = !hasDuplicate;
    }
  }

  return result;
}

List<bool> validateBox({
  required int value,
  required List<SudokuElementModel> board,
  required int row,
  required int col,
}) {
  final int boxRowStart = getBoxStartRow(row);
  final int boxColumnStart = getBoxStartColumn(col);

  final List<List<SudokuElementModel>> board2d = convertTo2d(board: board);

  final List<bool> result = List<bool>.filled(81, true);

  final bool hasDuplicate =
      hasDuplicateValueInBox(value: value, board: board2d, row: row, col: col);

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      final int index = boxRowStart + i * 9 + boxColumnStart + j;

      result[index] = !hasDuplicate;
    }
  }

  return result;
}

List<List<SudokuElementModel>> convertTo2d({
  required List<SudokuElementModel> board,
  int size = 9,
}) {
  final List<List<SudokuElementModel>> board2d = <List<SudokuElementModel>>[];

  for (int i = 0; i < size; i++) {
    final List<SudokuElementModel> row = <SudokuElementModel>[];

    for (int j = 0; j < size; j++) {
      row.add(board[i * size + j]);
    }

    board2d.add(row);
  }

  return board2d;
}
