class PriorityQueue<E extends Comparable<E>> {
  final List<E> _list = [];

  void enqueue(E value) {
    _list.add(value);
    _list.sort();
  }

  E dequeue() {
    return _list.removeAt(0);
  }

  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() {
    return '--- Top ---\n${_list.join('\n')}\n-----------';
  }
}