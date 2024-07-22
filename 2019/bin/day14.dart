import 'package:aoc2019/src/day14.dart';
import 'dart:io';

void main() {
  var recipeDescs = File("inputs/day14.txt").readAsStringSync();
  var map = createRecipeMap(recipeDescs);
  print(requiredOreX(map, "FUEL", 1));
}