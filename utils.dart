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
