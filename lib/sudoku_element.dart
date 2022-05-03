import 'package:flutter/material.dart';
import 'package:flutter_sudoku/sudoku_element_model.dart';

class SudokuElement extends StatelessWidget {
  const SudokuElement({required this.model, Key? key}) : super(key: key);

  final SudokuElementModel model;

  @override
  Widget build(BuildContext context) => Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: model.color,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildValue(model.value),
            buildHint(model.value, model.hints[0], Alignment.center),
            buildHint(model.value, model.hints[1], Alignment.topLeft),
            buildHint(model.value, model.hints[2], Alignment.topRight),
            buildHint(model.value, model.hints[3], Alignment.bottomLeft),
            buildHint(model.value, model.hints[4], Alignment.bottomRight),
          ],
        ),
      );

  Widget buildValue(int value) => value == 0
      ? const SizedBox.shrink()
      : Positioned.fill(
          child: Align(
            child: Text(
              '${model.value}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );

  Widget buildHint(int value, int hintValue, Alignment align) =>
      value == 0 && hintValue != 0
          ? Positioned.fill(
              child: Align(
                alignment: align,
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink();
}
