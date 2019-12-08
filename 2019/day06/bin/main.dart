import 'dart:io';
import 'package:solution/src/lib.dart';

void main() {
  var inputs = File('input.txt').readAsStringSync().split("\n");
  var orbits = Orbits.fromOrbitNotation(inputs);
  print(orbits.calcTransfers("YOU", "SAN"));
}
