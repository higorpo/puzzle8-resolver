import 'heuristics.dart';

class Node {
  Node? parent;
  List<List<int>> state;
  List<Node> children = [];
  int depth;

  late bool isRoot;

  Node({
    required this.state,
    this.parent = null,
    this.depth = 0,
  }) {
    isRoot = parent == null;
  }

  factory Node.fromParameters(List<dynamic> value) {
    return Node(
      state: [
        for (var row in value)
          [
            for (var cell in row) cell as int,
          ],
      ],
    );
  }

  bool isGoal() {
    return state ==
        [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 0],
        ];
  }

  printTree() {
    print("| ${_getNumber(0, 0)} | ${_getNumber(0, 1)} | ${_getNumber(0, 2)} |");
    print("| ${_getNumber(1, 0)} | ${_getNumber(1, 1)} | ${_getNumber(1, 2)} |");
    print("| ${_getNumber(2, 0)} | ${_getNumber(2, 1)} | ${_getNumber(2, 2)} |");
    print("Distância: ${calculateDistanceToSucess(this)}");
  }

  void generateChildren() {
    final emptyPosition = _getEmptyPosition();

    // Check if can move empty space to left
    if (_canMoveEmptySpaceToLeft(emptyPosition)) {
      final newState = _deepCloneState();
      newState[emptyPosition.keys.first][emptyPosition.values.first] = newState[emptyPosition.keys.first][emptyPosition.values.first - 1];
      newState[emptyPosition.keys.first][emptyPosition.values.first - 1] = 0;

      children.add(Node(
        state: newState,
        parent: this,
        depth: depth + 1,
      ));
    }

    // Check if can move empty space to right
    if (_canMoveEmptySpaceToRight(emptyPosition)) {
      final newState = _deepCloneState();
      newState[emptyPosition.keys.first][emptyPosition.values.first] = newState[emptyPosition.keys.first][emptyPosition.values.first + 1];
      newState[emptyPosition.keys.first][emptyPosition.values.first + 1] = 0;

      children.add(Node(
        state: newState,
        parent: this,
        depth: depth + 1,
      ));
    }

    // // Check if can move empty space to up
    if (_canMoveEmptySpaceToUp(emptyPosition)) {
      final newState = _deepCloneState();
      newState[emptyPosition.keys.first][emptyPosition.values.first] = newState[emptyPosition.keys.first - 1][emptyPosition.values.first];
      newState[emptyPosition.keys.first - 1][emptyPosition.values.first] = 0;

      children.add(Node(
        state: newState,
        parent: this,
        depth: depth + 1,
      ));
    }

    // // Check if can move empty space to down
    if (_canMoveEmptySpaceToDown(emptyPosition)) {
      final newState = _deepCloneState();
      newState[emptyPosition.keys.first][emptyPosition.values.first] = newState[emptyPosition.keys.first + 1][emptyPosition.values.first];
      newState[emptyPosition.keys.first + 1][emptyPosition.values.first] = 0;

      children.add(Node(
        state: newState,
        parent: this,
        depth: depth + 1,
      ));
    }
  }

  String _getNumber(int row, int column) {
    return state[row][column] == 0 ? " " : state[row][column].toString();
  }

  List<List<int>> _deepCloneState() {
    return [
      for (var row in state)
        [
          for (var cell in row) cell,
        ],
    ];
  }

  bool _canMoveEmptySpaceToLeft(Map<int, int> emptyPosition) {
    return emptyPosition.values.first > 0;
  }

  bool _canMoveEmptySpaceToRight(Map<int, int> emptyPosition) {
    return emptyPosition.values.first < state.length - 1;
  }

  bool _canMoveEmptySpaceToUp(Map<int, int> emptyPosition) {
    return emptyPosition.keys.first > 0;
  }

  bool _canMoveEmptySpaceToDown(Map<int, int> emptyPosition) {
    return emptyPosition.keys.first < state.length - 1;
  }

  Map<int, int> _getEmptyPosition() {
    for (var row = 0; row < state.length; row++) {
      for (var column = 0; column < state[row].length; column++) {
        if (state[row][column] == 0) {
          return {row: column};
        }
      }
    }

    throw Exception("Empty space not found");
  }
}