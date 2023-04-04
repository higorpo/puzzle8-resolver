import 'package:collection/collection.dart';

bool deepListEquals(List<List<int>> first, List<List<int>> second) {
  if (first.length != second.length) {
    return false;
  }

  for (var i = 0; i < first.length; i++) {
    if (first[i].length != second[i].length) {
      return false;
    }

    for (var j = 0; j < first[i].length; j++) {
      if (first[i][j] != second[i][j]) {
        return false;
      }
    }
  }

  return true;
}

class SortedList<E> extends DelegatingList<E> {
  int Function(E a, E b)? _compareFunction;

  List<E> get _listBase => super.toList();

  SortedList([int Function(E a, E b)? compareFunction]) : super(<E>[]) {
    this._compareFunction = compareFunction;
  }

  @override
  void add(E value) {
    var index = lowerBound(_listBase, value, compare: _compareFunction);
    super.insert(index, value);
  }

  @override
  void addAll(Iterable<E> iterable) {
    _throwNotSupportedException();
  }

  @override
  List<E> operator +(List<E> other) {
    throw Exception('Cannot add two sorted lists.');
  }

  _throwNotSupportedException() {
    throw Exception('Cannot insert element at a specific index in a sorted list.');
  }

  @deprecated
  @override
  void insert(int index, E element) {
    _throwNotSupportedException();
  }

  @deprecated
  @override
  void insertAll(int index, Iterable<E> iterable) {
    _throwNotSupportedException();
  }

  @deprecated
  @override
  void operator []=(int index, E value) {
    _throwNotSupportedException();
  }

  @deprecated
  @override
  void setAll(int index, Iterable<E> iterable) {
    _throwNotSupportedException();
  }

  @deprecated
  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    _throwNotSupportedException();
  }
}
