import 'dart:io';
import 'package:aoc2019/src/day03.dart';

void main() {
  var inputs = File('inputs/day03.txt');
  var wires = inputs.readAsLinesSync();
  var result = findNearestCrossingDistance(
    wires[0], 
    wires[1]);

  print('Closest distance: $result.');
}
