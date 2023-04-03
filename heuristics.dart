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
      int currentNumber = node.state[row][column];
      List<int> correctLocation = correctLocations[currentNumber]!;
      distance += (correctLocation[0] - row).abs() + (correctLocation[1] - column).abs();
    }
  }

  return distance;
}

int calculateNumOfMisplacedParts(Node node) {
  int numOfMisplacedParts = 0;

  for (int row = 0; row < node.state.length; row++) {
    for (int column = 0; column < node.state[row].length; column++) {
      int currentNumber = node.state[row][column];
      List<int> correctLocation = correctLocations[currentNumber]!;
      if (correctLocation[0] != row || correctLocation[1] != column) {
        numOfMisplacedParts++;
      }
    }
  }

  return numOfMisplacedParts;
}

int calculateLinearConflict(Node node) {
  int linearConflicts = 0;

  for (int row = 0; row < node.state.length; row++) {
    for (int column = 0; column < node.state[row].length; column++) {
      final currentNumber = node.state[row][column];

      final currentRow = row;
      final currentCol = column;

      final currentGoalRow = correctLocations[currentNumber]![0];
      final currentGoalCol = correctLocations[currentNumber]![1];

      final goalAndNumberAreInSameRow = currentRow == currentGoalRow;
      final goalAndNumberAreInSameColumn = currentCol == currentGoalCol;

      if (currentCol > currentGoalCol && goalAndNumberAreInSameRow) {
        linearConflicts++;
      } else if (currentCol < currentGoalCol && goalAndNumberAreInSameRow) {
        linearConflicts += 2;
      }

      if (goalAndNumberAreInSameRow) {
        for (final nextNumber in node.state[row].skip(column + 1)) {
          final nextGoalRow = correctLocations[nextNumber]![0];
          final nextGoalCol = correctLocations[nextNumber]![1];

          if (nextGoalRow == currentRow && currentGoalCol > nextGoalCol) {
            linearConflicts++;
          }
        }
      } else if (goalAndNumberAreInSameColumn) {
        for (final nextNumber in node.state.skip(row + 1).map((e) => e[column])) {
          final nextGoalRow = correctLocations[nextNumber]![0];
          final nextGoalCol = correctLocations[nextNumber]![1];

          if (nextGoalCol == currentCol && currentGoalRow > nextGoalRow) {
            linearConflicts++;
          }
        }
      }
    }
  }

  return linearConflicts;
}

int calculatePositionOfEmptySpace(Node node) {
  if (node.state[0][0] == 0) return 100;
  if (node.state[0][1] == 0) return 80;
  if (node.state[0][2] == 0) return 65;
  if (node.state[1][0] == 0) return 70;
  if (node.state[1][1] == 0) return 60;
  if (node.state[1][2] == 0) return 35;
  if (node.state[2][0] == 0) return 68;
  if (node.state[2][1] == 0) return 30;
  return 0;
}

int calculateOrderedMatch(Node node) {
  int orderedMatch = 0;

  for (int row = 0; row < node.state.length; row++) {
    // Verify if row is ordered
    if (!(node.state[row][0] > node.state[row][1] && node.state[row][1] > node.state[row][2])) {
      orderedMatch += 10;
    }
  }

  return orderedMatch;
}
