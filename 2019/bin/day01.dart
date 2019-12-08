import 'dart:io';
import 'package:aoc2019/src/day01.dart';

void main() {
  var inputs = File('inputs/day01.txt');
  var modules = inputs.readAsLinesSync();
  var cargoFuel = modules
    .map(int.parse)
    .map(calculateFuel)
    .fold(0, (acc, x) => acc + x);

  print('Fuel required: $cargoFuel');
}
