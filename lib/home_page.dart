import 'package:flutter/material.dart';

import 'package:flutter_sudoku/helpers.dart';

import 'package:flutter_sudoku/sudoku_element.dart';
import 'package:flutter_sudoku/sudoku_element_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<SudokuElementModel> _sudokuElements;

  @override
  void initState() {
    super.initState();

    _sudokuElements = generateRandomSudoku();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(elevation: 0, title: Text(widget.title)),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            itemCount: 81,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
            ),
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.only(
                top: get2dCoordinates(index)[0] % 3 == 0 ? 4 : 1,
                left: get2dCoordinates(index)[1] % 3 == 0 ? 4 : 1,
              ),
              child: Material(
                child: InkWell(
                  child: SudokuElement(model: _sudokuElements[index]),
                  onTap: () async {
                    for (int i = 0; i < 81; i++) {
                      if (isInSameRowColumnBox(index, i)) {
                        _sudokuElements[i].color = Colors.grey;
                      } else {
                        _sudokuElements[i].color = Colors.red;
                      }
                    }

                    // _sudokuElements[index].value = await showNumberPicker(
                    //         context, _sudokuElements[index]) ??
                    //     _sudokuElements[index].value;

                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        ),
      );

  List<SudokuElementModel> generateRandomSudoku() {
    final List<SudokuElementModel> elements = List<SudokuElementModel>.generate(
      81,
      (int index) => SudokuElementModel(
        value: index % 9 + 1,
        readonly: true,
        color: Colors.red,
        hints: <int>[0, 0, 0, 0, 0, 0],
      ),
    );

    return elements;
  }

  Future<int?> showNumberPicker(
    BuildContext context,
    SudokuElementModel sudokuElement,
  ) async =>
      showDialog<int?>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Pick a number'),
          content: Container(
            width: 180,
            height: 180,
            child: GridView.count(
              crossAxisCount: 3,
              children: <Widget>[
                for (int i = 1; i <= 9; i++)
                  GestureDetector(
                    child: Material(
                      child: Text(
                        '$i',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: sudokuElement.value == i
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                    onTap: () => Navigator.of(context).pop(i),
                  ),
              ],
            ),
          ),
        ),
      );
}
