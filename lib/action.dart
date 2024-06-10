class SudokuAction {
  int num;
  int row, col;
  SudokuAction(this.row, this.col, this.num);

  @override
  String toString() {
    return '[$row, $col] -> $num';
  }
}
