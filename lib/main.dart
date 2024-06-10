import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudokusolver_ver1/giris_ekran.dart';
import 'package:sudokusolver_ver1/model.dart';
import 'package:sudokusolver_ver1/sudoku_ekran.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SudokuModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const GirisSayfasi(),
      routes: {
        '/sudoku': (context) => const SudokuSayfasi(),
      },
    );
  }
}
