import 'dart:convert';

import 'package:sorted_list/sorted_list.dart';
import 'package:collection/collection.dart';

import 'node.dart';

List<dynamic> readProgramParameters(List<String> arguments) {
  if (arguments.isNotEmpty) {
    return jsonDecode(arguments[0]);
  }

  throw Exception("No arguments passed");
}

void main(List<String> arguments) {
  Stopwatch stopwatch = Stopwatch()..start();

  final initialState = readProgramParameters(arguments);
  final node = Node.fromParameters(initialState);

  var currentNode = node;

  Map<String, List<Node>> visitedNodes = {};
  final openedNodes = SortedList<Node>((a, b) => a.cost.compareTo(b.cost));

  while (true) {
    if (currentNode.isGoal()) {
      break;
    }

    if (visitedNodes[currentNode.stateToString()] == null) {
      visitedNodes[currentNode.stateToString()] = [];
    }

    visitedNodes[currentNode.stateToString()]!.add(currentNode);

    final children = currentNode.generateChildren();

    children.forEach((child) {
      final hasBetterNode = visitedNodes[child.stateToString()]?.any((element) => element.cost < child.cost) ?? false;

      if (!hasBetterNode) {
        openedNodes.add(child);
      }
    });

    currentNode = openedNodes.first;

    openedNodes.remove(currentNode);
  }

  print('Tempo de execução: ${stopwatch.elapsed}');
  print('Quantidade de nodos visitados: ${visitedNodes.length}');
  print('Quantidade de passos para resolver o problema: ${currentNode.goalPath.length}');

  print('\nLista de passos para resolver o problema:');

  currentNode.goalPath.forEachIndexed((index, node) {
    print("Passo ${index + 1}: ${node.getDescriptionOfThePerformedStep()}");
  });
}
