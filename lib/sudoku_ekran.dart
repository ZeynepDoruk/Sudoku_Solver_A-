import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudokusolver_ver1/model.dart';
import 'package:sudokusolver_ver1/sudoku_grid.dart';

class SudokuSayfasi extends StatelessWidget {
  const SudokuSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4x4 Sudoku Çözücü'),
        automaticallyImplyLeading: false, 
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SudokuGrid(),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Provider.of<SudokuModel>(context, listen: false).solveSudokuAStar();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              textStyle: const TextStyle(
                fontSize: 20,
              ),
              backgroundColor: const Color.fromARGB(255, 141, 181, 249),
            ),
            child: const Text(
              'Başla',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Provider.of<SudokuModel>(context, listen: false).yenideBaslat();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              textStyle: const TextStyle(
                fontSize: 20,
              ),
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Yeniden Başlat',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
