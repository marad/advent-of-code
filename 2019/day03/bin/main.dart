import 'dart:io';
import 'package:solution/src/lib.dart';

void main() {
  var inputs = File('input.txt');
  var wires = inputs.readAsLinesSync();
  var result = findNearestCrossingDistance(
    wires[0], 
    wires[1]);

  print('Closest distance: $result.');
}
