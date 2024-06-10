import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sudokusolver_ver1/action.dart';
import 'package:sudokusolver_ver1/coordinate.dart';
import 'package:sudokusolver_ver1/node.dart';
import 'package:sudokusolver_ver1/priority_queue.dart';

class SudokuModel with ChangeNotifier {
  List<List<int?>> sudokuHaritasi =
      List.generate(4, (index) => List.generate(4, (_) => null));
  Random random = Random();
  bool cozumKontrol = false;

  SudokuModel() {
    _caprazDoldur();
    _haritaSayiKaldir();
  }
  void yenideBaslat() {

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        sudokuHaritasi[i][j] = null;
      }
    }

    _caprazDoldur();
    _haritaSayiKaldir();
    notifyListeners(); 
  }

  void _caprazDoldur() {
    for (int i = 0; i < 4; i += 2) {
      _OyunHaritakareDoldur(i, i);
    }
  }

  void _OyunHaritakareDoldur(int row, int col) {
    List<int> oyunNumaraListe = [1, 2, 3, 4];
    oyunNumaraListe.shuffle(random);

    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        sudokuHaritasi[row + i][col + j] = oyunNumaraListe[i * 2 + j];
      }
    }
  }

  bool _kontrol(int row, int col, int num) {
    for (int i = 0; i < 4; i++) {
      if (sudokuHaritasi[row][i] == num || sudokuHaritasi[i][col] == num) {
        return false;
      }
    }

    int baslangicRow = row - row % 2;
    int BaslangicCol = col - col % 2;

    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        if (sudokuHaritasi[i + baslangicRow][j + BaslangicCol] == num) {
          return false;
        }
      }
    }

    return true;
  }

  Future<void> solveSudokuAStar() async {
    cozumKontrol = true;
    PriorityQueue<Node> open = PriorityQueue();
    open.enqueue(Node.initState(
        Coordinate(0, 0),
        SudokuAction(0, 0, 0),
        List.from(sudokuHaritasi.map((row) => List<int?>.from(row))),
        0,
        _heuristic(List.from(sudokuHaritasi.map((row) => List<int?>.from(row))))));

    while (open.isNotEmpty) {
      Node currentNode = open.dequeue();
      sudokuHaritasi = currentNode.state.map((row) => List<int?>.from(row)).toList();
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 500));

      if (sonKontrol(currentNode.state)) {
        cozumKontrol = false;
        notifyListeners();
        return;
      }

      List<Node> children = expand(currentNode);
      for (Node child in children) {
        open.enqueue(child);
      }
    }
    cozumKontrol = false;
    notifyListeners();
  }

  static int yazilabilecekSayiDeger(List<List<int?>> sudokuHaritasi, int row, int col) {
    Set<int> yazilacakSayiListesi = Set.from(Iterable<int>.generate(
        4, (i) => i + 1)); 
    for (int i = 0; i < 4; i++) {
    
      yazilacakSayiListesi.remove(sudokuHaritasi[row][i]);
      yazilacakSayiListesi.remove(sudokuHaritasi[i][col]);
    }
 
    int baslangicRow = row ~/ 2 * 2;
    int BaslangicCol = col ~/ 2 * 2;
    for (int i = baslangicRow; i < baslangicRow + 2; i++) {
    
      for (int j = BaslangicCol; j < BaslangicCol + 2; j++) {
    
        yazilacakSayiListesi.remove(sudokuHaritasi[i][j]);
      }
    }
    return yazilacakSayiListesi.length;
  }

  int _heuristic(List<List<int?>> state) {
    int totalHeuristicDeger = 0;
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (state[i][j] == null) {
          totalHeuristicDeger += yazilabilecekSayiDeger(state, i, j);
        }
      }
    }
    return totalHeuristicDeger;
  }

  bool sonKontrol(List<List<int?>> state) {
    for (var row in state) {
      for (var cell in row) {
        if (cell == null) return false;
      }
    }
    return true;
  }

  List<Node> expand(Node node) {
    List<Node> children = [];
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (node.state[row][col] == null) {
          for (int num = 1; num <= 4; num++) {
            if (_kontrol(row, col, num)) {
              var newState = node.state.map((r) => List<int?>.from(r)).toList();
              newState[row][col] = num;
              int cost = node.cost + 1;
              int heuristic = _heuristic(newState);
              children.add(Node(
                  Coordinate(row, col),
                  SudokuAction(row, col, num),
                  node,
                  newState,
                  cost,
                  heuristic));
            }
          }
          return children;
        }
      }
    }
    return children;
  }

  void _haritaSayiKaldir() {

    int kaldiracakCount = random.nextInt(4) + 4;

    while (kaldiracakCount != 0) {
      int cellId = random.nextInt(16);
      int row = cellId ~/ 4;
      int col = cellId % 4;
      if (sudokuHaritasi[row][col] != null) {
        sudokuHaritasi[row][col] = null;
        kaldiracakCount--;
      }
    }
  }
}
