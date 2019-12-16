import 'package:aoc2019/src/day12.dart';
import 'package:vector_math/vector_math.dart';
import 'package:test/test.dart';

void main() {
  test("test case 1", () {
    var moons = [
      Moon(Vector3(-1, 0, 2)),
      Moon(Vector3(2, -10, -7)),
      Moon(Vector3(4, -8, 8)),
      Moon(Vector3(3, 5, -1))
    ];

    var x = findCycleForDimension(0, moons);
    var y = findCycleForDimension(1, moons);
    var z = findCycleForDimension(2, moons);

    var cycle = lcm(lcm(z, x), y);
    expect(cycle, 2772);
  });
}