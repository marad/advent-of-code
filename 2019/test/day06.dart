import 'package:aoc2019/src/day06.dart';

void main() {
  var input = """COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN""";
  var orbitNotation = input.split("\n");

  var orbits = Orbits.fromOrbitNotation(orbitNotation);
  print(orbits.parentMap);
  print(orbits.parentMap.keys);
  print(orbits.countOrbits('D'));
  print(orbits.totalOrbits());

  print(orbits.calcTransfers("YOU", "SAN"));
}