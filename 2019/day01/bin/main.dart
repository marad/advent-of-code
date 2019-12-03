import 'dart:io';
import 'package:day01/src/lib.dart';

void main() {
  var inputs = File('input.txt');
  var modules = inputs.readAsLinesSync();
  var cargoFuel = modules
    .map(int.parse)
    .map(calculateFuel)
    .fold(0, (acc, x) => acc + x);

  print('Fuel required: $cargoFuel');
}
