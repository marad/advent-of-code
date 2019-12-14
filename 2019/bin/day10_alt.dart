import 'package:aoc2019/src/day10.dart';
import 'package:collection/collection.dart';
import 'package:vector_math/vector_math.dart';


class AsteroidAndAngle {
  AsteroidAndAngle(this.asteroid, this.angle) {
    if(this.angle < 0) {
      this.angle += 360;
    }
  }

  Vector2 asteroid;
  double angle;

  @override
  String toString() => 'Pair[$asteroid, $angle]';
}

int gcd(int a, int b) {
  while(a != b) {
    if (a == 0) {
      return b;
    } else if (b == 0) {
      return a;
    } else if (a > b) {
      a -= b;
    } else {
      b -= a;
    }
  }
  return a;
}

Set<Vector2> readMap(String desc) {
    int asteroidChar = "#".codeUnitAt(0);
    Set<Vector2> asteroids = {};
    var lines = desc.split("\n");
    for (var y = 0; y < lines.length; y++) {
      var line = lines[y];
      for (var x = 0; x < line.length; x++) {
        var char = line.codeUnitAt(x);
        if (char == asteroidChar) {
          asteroids.add(Vector2(x.toDouble(), y.toDouble()));
        }
      }
    }
    return asteroids;
}

void main() {
  var map = """
....#.....#.#...##..........#.......#......
.....#...####..##...#......#.........#.....
.#.#...#..........#.....#.##.......#...#..#
.#..#...........#..#..#.#.......####.....#.
##..#.................#...#..........##.##.
#..##.#...#.....##.#..#...#..#..#....#....#
##...#.............#.#..........#...#.....#
#.#..##.#.#..#.#...#.....#.#.............#.
...#..##....#........#.....................
##....###..#.#.......#...#..........#..#..#
....#.#....##...###......#......#...#......
.........#.#.....#..#........#..#..##..#...
....##...#..##...#.....##.#..#....#........
............#....######......##......#...#.
#...........##...#.#......#....#....#......
......#.....#.#....#...##.###.....#...#.#..
..#.....##..........#..........#...........
..#.#..#......#......#.....#...##.......##.
.#..#....##......#.............#...........
..##.#.....#.........#....###.........#..#.
...#....#...#.#.......#...#.#.....#........
...####........#...#....#....#........##..#
.#...........#.................#...#...#..#
#................#......#..#...........#..#
..#.#.......#...........#.#......#.........
....#............#.............#.####.#.#..
.....##....#..#...........###........#...#.
.#.....#...#.#...#..#..........#..#.#......
.#.##...#........#..#...##...#...#...#.#.#.
#.......#...#...###..#....#..#...#.........
.....#...##...#.###.#...##..........##.###.
..#.....#.##..#.....#..#.....#....#....#..#
.....#.....#..............####.#.........#.
..#..#.#..#.....#..........#..#....#....#..
#.....#.#......##.....#...#...#.......#.#..
..##.##...........#..........#.............
...#..##....#...##..##......#........#....#
.....#..........##.#.##..#....##..#........
.#...#...#......#..#.##.....#...#.....##...
...##.#....#...........####.#....#.#....#..
...#....#.#..#.........#.......#..#...##...
...##..............#......#................
........................#....##..#........#
    """.trimLines();

  var station = Vector2(30, 34);
  var asteroids = (readMap(map)..remove(station))
    .map((asteroid) => asteroid - station)
    .map((asteroid) => AsteroidAndAngle(asteroid, degrees(Vector2(0, -1).angleToSigned(asteroid))));

  var groups = (groupBy(asteroids, (it) => it.angle)
    .map((k, v) => MapEntry(k, v..sort((a, b) => a.asteroid.length2.compareTo(b.asteroid.length2))))
    .values.toList()
    ..sort((a, b) => a.first.angle.compareTo(b.first.angle)))
    .map((group) => group.map((withAngle) => withAngle.asteroid).toList()).toList()
    ;

  var i = 1;
  groups
    .map((it) => it.map((it) => it + station).toList())
    .take(200)
    .forEach((it) {
      print('${i++} - $it');
    });
}
