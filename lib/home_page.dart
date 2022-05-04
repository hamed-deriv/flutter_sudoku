import 'package:flutter/material.dart';

import 'package:flutter_sudoku/helpers.dart';

import 'package:flutter_sudoku/sudoku_element.dart';
import 'package:flutter_sudoku/sudoku_element_model.dart';
import 'package:flutter_sudoku/sudoku_generator.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color _color = Colors.white;
  final Color _textColor = Colors.black;
  final Color _readonlyTextColor = Colors.grey;

  final Color _selectedColor = Colors.green.shade400;
  final Color _selectedRowColBoxColor = Colors.green.shade100;

  late final List<SudokuElementModel> _sudokuElements;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _sudokuElements = generateRandomSudoku(
      boardBlueprint,
      _color,
      _textColor,
      _readonlyTextColor,
    );

    _setValue(_sudokuElements[_selectedIndex].value);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(elevation: 0, title: Text(widget.title)),
        backgroundColor: Colors.blueGrey,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: _buildBoard(),
            ),
            _buildInputNumbers(),
          ],
        ),
      );

  Widget _buildBoard() => GridView.builder(
        shrinkWrap: true,
        itemCount: _sudokuElements.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
        ),
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: EdgeInsets.only(
            top: get2dCoordinates(index)[0] % 3 == 0 ? 4 : 1,
            left: get2dCoordinates(index)[1] % 3 == 0 ? 4 : 1,
          ),
          child: SudokuElement(
              model: _sudokuElements[index],
              onPressed: () {
                _selectedIndex = index;

                _setValue(_sudokuElements[_selectedIndex].value);
              }),
        ),
      );

  Widget _buildInputNumbers() => Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildInputNumber(1),
            _buildInputNumber(2),
            _buildInputNumber(3),
            _buildInputNumber(4),
            _buildInputNumber(5),
            _buildInputNumber(6),
            _buildInputNumber(7),
            _buildInputNumber(8),
            _buildInputNumber(9),
            _buildClearButton(),
          ],
        ),
      );

  Widget _buildInputNumber(int number) => SizedBox(
        width: 48,
        height: 48,
        child: TextButton(
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: 30,
              color: _sudokuElements[_selectedIndex].value == number
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            if (!_sudokuElements[_selectedIndex].readonly) {
              _setValue(number);
            }
          },
        ),
      );

  Widget _buildClearButton() => SizedBox(
        width: 48,
        height: 48,
        child: TextButton(
          child: const Icon(Icons.delete, color: Colors.black),
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            if (!_sudokuElements[_selectedIndex].readonly) {
              _setValue(0);
            }
          },
        ),
      );

  void _setValue(int number) {
    _sudokuElements[_selectedIndex].value = number;

    highlightRowColBox(
      _sudokuElements,
      _selectedIndex,
      _color,
      _selectedColor,
      _selectedRowColBoxColor,
    );

    highlightNumbers(_sudokuElements, number, Colors.red, Colors.red);

    setState(() {});
  }
}
