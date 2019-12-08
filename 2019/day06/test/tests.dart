import 'package:solution/src/lib.dart';

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

  var myPath = orbits.getPath('YOU');
  var sanPath = orbits.getPath('SAN');


  print(orbits.calcTransfers("YOU", "SAN"));
}