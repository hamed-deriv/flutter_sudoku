import 'package:flutter/material.dart';

import 'package:flutter_sudoku/home_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Sudoku',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(title: 'Flutter Sudoku'),
      );
}
