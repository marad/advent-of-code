import 'dart:io';
import 'package:aoc2019/src/computer.dart';

void main() {
  var constantIO = TestIO(toInput: 2);
  var code = File('inputs/day09.txt').readAsStringSync().split(",").map(int.parse).toList();
  print(code.length);
  var computer = Computer(code, io: constantIO);
  computer.run();
  print(constantIO.outputs);
}