import 'node.dart';

Map<int, List<int>> correctLocations = {
  1: [0, 0],
  2: [0, 1],
  3: [0, 2],
  4: [1, 0],
  5: [1, 1],
  6: [1, 2],
  7: [2, 0],
  8: [2, 1],
  0: [2, 2],
};

int calculateDistanceToSucess(Node node) {
  int distance = 0;

  for (int row = 0; row < node.state.length; row++) {
    for (int column = 0; column < node.state[row].length; column++) {
      int value = node.state[row][column];
      List<int> correctLocation = correctLocations[value]!;
      distance += (correctLocation[0] - row).abs() + (correctLocation[1] - column).abs();
    }
  }

  return distance;
}
