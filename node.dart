import 'package:equatable/equatable.dart';

import 'heuristics.dart';
import 'utils.dart';

class Node extends Equatable {
  final List<List<int>> state;
  final int depth;

  final Node? parent;
  final List<Node> currentPath;

  List<Node> get goalPath {
    if (isGoal()) {
      currentPath.removeWhere((element) => element.isRoot);
      return currentPath + [this];
    }
    throw Exception('This node is not a goal node');
  }

  final List<Node> children = [];

  late final int cost;
  late final bool isRoot;

  Node({
    required this.state,
    this.parent = null,
    this.depth = 1,
    this.currentPath = const [],
  }) {
    isRoot = parent == null;
    if (parent != null) {
      cost = calculateDistanceToSucess(this) + calculateNumOfMisplacedParts(this) + calculateLinearConflict(this) + parent!.cost + 1;
    } else {
      cost = 1;
    }
  }

  @override
  List<Object> get props {
    return [state, depth, cost];
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
    return deepListEquals(state, [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 0],
    ]);
  }

  String getDescriptionOfThePerformedStep() {
    if (isRoot) return "";

    final emptyPosition = _getEmptyPosition();
    final parentEmptyPosition = parent!._getEmptyPosition();

    if (emptyPosition.values.first > parentEmptyPosition.values.first) {
      return "Mova o número ${_getValueLeftFromEmptySpace(emptyPosition)}";
    } else if (emptyPosition.values.first < parentEmptyPosition.values.first) {
      return "Mova o número ${_getValueRightFromEmptySpace(emptyPosition)}";
    } else if (emptyPosition.keys.first > parentEmptyPosition.keys.first) {
      return "Mova o número ${_getValueUpFromEmptySpace(emptyPosition)}";
    } else if (emptyPosition.keys.first < parentEmptyPosition.keys.first) {
      return "Mova o número ${_getValueDownFromEmptySpace(emptyPosition)}";
    }

    return "";
  }

  String stateToString() {
    return state.map((row) => row.join('')).join('');
  }

  List<Node> generateChildren() {
    final emptyPosition = _getEmptyPosition();

    if (_canMoveEmptySpaceToLeft(emptyPosition)) {
      _moveEmptySpaceToLeft(emptyPosition);
    }

    if (_canMoveEmptySpaceToRight(emptyPosition)) {
      _moveEmptySpaceToRight(emptyPosition);
    }

    if (_canMoveEmptySpaceToUp(emptyPosition)) {
      _moveEmptySpaceToUp(emptyPosition);
    }

    if (_canMoveEmptySpaceToDown(emptyPosition)) {
      _moveEmptySpaceToDown(emptyPosition);
    }

    return children;
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

  void _moveEmptySpaceToLeft(Map<int, int> emptyPosition) {
    final newState = _deepCloneState();
    newState[emptyPosition.keys.first][emptyPosition.values.first] = newState[emptyPosition.keys.first][emptyPosition.values.first - 1];
    newState[emptyPosition.keys.first][emptyPosition.values.first - 1] = 0;

    _createNewChild(newState);
  }

  void _moveEmptySpaceToRight(Map<int, int> emptyPosition) {
    final newState = _deepCloneState();
    newState[emptyPosition.keys.first][emptyPosition.values.first] = newState[emptyPosition.keys.first][emptyPosition.values.first + 1];
    newState[emptyPosition.keys.first][emptyPosition.values.first + 1] = 0;

    _createNewChild(newState);
  }

  void _moveEmptySpaceToUp(Map<int, int> emptyPosition) {
    final newState = _deepCloneState();
    newState[emptyPosition.keys.first][emptyPosition.values.first] = newState[emptyPosition.keys.first - 1][emptyPosition.values.first];
    newState[emptyPosition.keys.first - 1][emptyPosition.values.first] = 0;

    _createNewChild(newState);
  }

  void _moveEmptySpaceToDown(Map<int, int> emptyPosition) {
    final newState = _deepCloneState();
    newState[emptyPosition.keys.first][emptyPosition.values.first] = newState[emptyPosition.keys.first + 1][emptyPosition.values.first];
    newState[emptyPosition.keys.first + 1][emptyPosition.values.first] = 0;

    _createNewChild(newState);
  }

  void _createNewChild(List<List<int>> newState) {
    final currentPath = this.currentPath + [this];

    children.add(Node(
      state: newState,
      parent: this,
      depth: depth + 1,
      currentPath: currentPath,
    ));
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

  int _getValueLeftFromEmptySpace(Map<int, int> emptyPosition) {
    return state[emptyPosition.keys.first][emptyPosition.values.first - 1];
  }

  int _getValueRightFromEmptySpace(Map<int, int> emptyPosition) {
    return state[emptyPosition.keys.first][emptyPosition.values.first + 1];
  }

  int _getValueUpFromEmptySpace(Map<int, int> emptyPosition) {
    return state[emptyPosition.keys.first - 1][emptyPosition.values.first];
  }

  int _getValueDownFromEmptySpace(Map<int, int> emptyPosition) {
    return state[emptyPosition.keys.first + 1][emptyPosition.values.first];
  }
}
