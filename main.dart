import 'dart:convert';

import 'package:sorted_list/sorted_list.dart';
import 'package:collection/collection.dart';

import 'node.dart';
import 'utils.dart';

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

  var visitedNodes = [];
  final openedNodes = SortedList<Node>((a, b) => a.cost.compareTo(b.cost));

  while (true) {
    if (currentNode.isGoal()) {
      break;
    }

    visitedNodes.add(currentNode);

    final children = currentNode.generateChildren();

    children.forEach((child) {
      final hasBetterNode = visitedNodes.any((node) => deepListEquals(node.state, child.state) && node.cost < child.cost);

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
