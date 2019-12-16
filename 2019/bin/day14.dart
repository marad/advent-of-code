import 'package:aoc2019/src/day14.dart';

void main() {
  var recipeDescs = """
    10 ORE => 10 A
    1 ORE => 1 B
    7 A, 1 B => 1 C
    7 A, 1 C => 1 D
    7 A, 1 D => 1 E
    7 A, 1 E => 1 FUEL""";
  
  var map = createRecipeMap(recipeDescs);
  // calculateRequiredOre(map);
  print(requiredOre(map, "D", 1));
  // map.forEach((k,v) => print('$k: $v'));
}