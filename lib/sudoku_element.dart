import 'package:flutter/material.dart';
import 'package:flutter_sudoku/sudoku_element_model.dart';

class SudokuElement extends StatelessWidget {
  const SudokuElement({required this.model, required this.onPressed, Key? key})
      : super(key: key);

  final SudokuElementModel model;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
        child: Container(
          width: 64,
          height: 64,
          padding: const EdgeInsets.all(2),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildValue(model.value),
            ],
          ),
        ),
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: model.color,
        ),
        onPressed: onPressed,
      );

  Widget buildValue(int value) => value == 0
      ? const SizedBox.shrink()
      : Positioned.fill(
          child: Align(
            child: Text(
              '${model.value}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
                color:
                    model.readonly ? model.readonlyTextColor : model.textColor,
              ),
            ),
          ),
        );

  // Widget _buildHint(int value, int hintValue, Alignment align) =>
  //     value == 0 && hintValue != 0
  //         ? Positioned.fill(
  //             child: Align(
  //               alignment: align,
  //               child: Text(
  //                 '$value',
  //                 textAlign: TextAlign.center,
  //                 style: const TextStyle(
  //                   fontSize: 12,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //           )
  //         : const SizedBox.shrink();
}
