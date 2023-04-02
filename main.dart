import 'dart:convert';

import 'package:sorted_list/sorted_list.dart';

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

  var visitedNodes = [];
  final openedNodes = SortedList<Node>((a, b) => a.cost.compareTo(b.cost));

  var interations = 0;
  while (true) {
    // É nodo objetivo?
    if (currentNode.isGoal()) {
      print("Nodo objetivo encontrado!");

      currentNode.printTree();

      break;
    }

    interations++;

    if (interations > 10) {
      print("Limite de iterações atingido!");
      break;
    }

    // Imprime o nodo atual
    currentNode.printTree();

    // Não é nodo objetivo, então gera os filhos
    final children = currentNode.generateChildren();

    // Adiciona os filhos a lista de nodos abertos
    openedNodes.addAll(children);

    // Adiciona o nodo atual a lista de nodos visitados
    visitedNodes.add(currentNode);

    // Remove o nodo atual da lista de nodos abertos
    openedNodes.remove(currentNode);

    // Pega o primeiro nodo da lista de nodos abertos
    currentNode = openedNodes.first;
  }

  print('Tempo de execução: ${stopwatch.elapsed}');
}
