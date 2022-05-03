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

  int _selectedIndex = 0;

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
                    if (!_sudokuElements[index].readonly) {
                      for (int i = 0; i < 81; i++) {
                        if (isInSameRowColumnBox(index, i)) {
                          _sudokuElements[i].color = _sudokuElements[i].readonly
                              ? Colors.black54
                              : _sudokuElements[i].color.withOpacity(0.6);
                        } else {
                          _sudokuElements[i].color = _sudokuElements[i].readonly
                              ? Colors.black54
                              : _sudokuElements[i].color.withOpacity(1);
                        }
                      }

                      _selectedIndex = index;

                      setState(() {});

                      // _sudokuElements[index].value = await showNumberPicker(
                      //         context, _sudokuElements[index]) ??
                      //     _sudokuElements[index].value;

                      // setState(() {});
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      );

  List<SudokuElementModel> generateRandomSudoku() {
    final List<SudokuElementModel> elements = <SudokuElementModel>[];

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        elements.add(SudokuElementModel(
          value: board[i][j] == 0 ? 0 : board[i][j],
          readonly: board[i][j] != 0,
          color: board[i][j] == 0 ? Colors.grey : Colors.black54,
        ));
      }
    }

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
                    onTap: () => Navigator.of(context).pop(i),
                  ),
              ],
            ),
          ),
        ),
      );
}

final List<List<int>> board = <List<int>>[
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
