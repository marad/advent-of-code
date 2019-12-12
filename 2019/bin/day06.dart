import 'dart:io';
import 'package:aoc2019/src/day06.dart';

void main() {
  var inputs = File('inputs/day06.txt').readAsStringSync().split("\n");
  var orbits = Orbits.fromOrbitNotation(inputs);
  print(orbits.calcTransfers("YOU", "SAN"));
}
