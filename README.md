# Algorithm for solving Puzzle 8 problems

This project consists in the implementation of an algorithm for solving puzzles in the Puzzle 8 game, using the Dart language. The algorithm can use A\* with basic or advanced heuristics, or just use Uniform Cost to determine the best solution for a given problem.

## Requirements

To run the algorithm, you will need to have the Dart SDK installed on your machine. To install Dart, you can follow the instructions available in the official documentation.

## How to use

To use the algorithm, it is necessary to execute the file main.dart through the terminal, passing as a parameter the initial state of the board and the algorithm to be used. The initial state must be passed as a 3x3 matrix of integers, where the number 0 represents the empty position of the board. The algorithm can be chosen from AStar, SimpleAStar and UniformCost.

Example of execution with the initial state [1, 2, 3], [4, 5, 6], [7, 8, 0] and the algorithm A\*:

```dart
dart run main.dart [[1,2,3], [4,5,6], [7,8,0]] AStar
```

## Algorithm operation

The algorithm follows the graph search model, where each state of the board is represented by a node in the graph. For each node, the algorithm searches for its successor states, that is, the possible moves that can be made from the current state to reach a new state.

A* uses heuristics to determine the order of expansion of the nodes, always aiming to expand the nodes that have the lowest cost. Simple A* is a simplified version of A\*, which uses a simpler and faster heuristic to calculate. The Uniform Cost, as its name suggests, expands the nodes with less cost, but does not use heuristics.

## Optimizations:

- The algorithm was created optimized to use binary search when inserting elements in the list of open nodes in an ordered way, which results in a significant reduction in execution time.
- For this, a Dart list implementation called SortedList was created using the collections package, which already has binary search and ordered insertion methods implemented.
- Furthermore, the heuristic used in the algorithm was chosen in order to be efficient in terms of execution time and ability to guide the algorithm towards the goal state.
- The code was written in a clear and organized manner, following good programming practices and clean code standards, which facilitates algorithm maintenance and optimization.
