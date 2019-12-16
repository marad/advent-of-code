import 'package:vector_math/vector_math.dart';
import 'package:aoc2019/src/day12.dart';

void main() {

  var template = <Moon>[
    Moon(Vector3(-15,   1,  4)),
    Moon(Vector3(  1, -10, -8)),
    Moon(Vector3( -5,   4,  9)),
    Moon(Vector3(  4,   6, -2)),
  ];

  var moons = template.clone();
  for(var i=0; i < 1000; i++) {
    moons.simulationStep();
  }
  var totalEnergy = moons.sumOfTotalEnergy();
  print('Total energy: $totalEnergy');

  moons = template.clone();
  var x = findCycleForDimension(0, moons);
  var y = findCycleForDimension(1, moons);
  var z = findCycleForDimension(2, moons);

  var cycle = lcm(lcm(z, x), y);
  print('Cycle length: $cycle');
}

