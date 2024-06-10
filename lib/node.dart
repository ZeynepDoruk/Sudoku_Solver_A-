
import 'package:sudokusolver_ver1/action.dart';
import 'package:sudokusolver_ver1/coordinate.dart';

class Node implements Comparable<Node> {
  Node(this.coor, this.action, this.parent, this.state, this.cost, this.heuristic)
      : depth = (parent?.depth ?? 0) + 1,
        fScore = cost + heuristic;
  Node.initState(this.coor, this.action, this.state, this.cost, this.heuristic)
      : parent = null,
        depth = 0,
        fScore = cost + heuristic;

  Coordinate coor;
  int depth, cost, heuristic, fScore;
  SudokuAction action;
  Node? parent;
  List<List<int?>> state;

  @override
  String toString() {
    return '${coor.toString()}, $depth, $cost, $heuristic, $action';
  }

  @override
  int compareTo(Node other) {
    return fScore.compareTo(other.fScore);
  }
}
