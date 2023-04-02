import 'dart:convert';

import 'heuristics.dart';
import 'node.dart';

List<dynamic> readProgramParameters(List<String> arguments) {
  if (arguments.isNotEmpty) {
    return jsonDecode(arguments[0]);
  }

  throw Exception("No arguments passed");
}

void main(List<String> arguments) {
  final initialState = readProgramParameters(arguments);
  final node = Node.fromParameters(initialState);

  node.generateChildren();

  node.printTree();
  for (var child in node.children) {
    print('\n');
    child.printTree();
  }
}
