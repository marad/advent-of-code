import 'package:aoc2019/src/day10.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'dart:math';
import 'dart:core';

var desc = """
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

class AsteroidInfo {
  final Asteroid asteroid;
  final int distance; // distance from monitoring station
  final double angle;

  AsteroidInfo(this.asteroid, this.distance, this.angle);

  factory AsteroidInfo.from(Asteroid monitoringStation, Asteroid target) {
    var distance = (monitoringStation.x - target.x).abs() + (monitoringStation.y - target.y).abs();
    var top = Asteroid(monitoringStation.x, monitoringStation.y - 1);
    var angle = getAngle(target, monitoringStation, top);

    return AsteroidInfo(target, distance, angle < 0 ? angle + pi * 2 : angle);
  }

}

// TODO: group and sort by angle, then by distance
// for each laser rotation it destroys first asteroid in each group

double getAngle(Asteroid a, Asteroid b, Asteroid c) {
  return atan2(c.y - b.y, c.x - b.x) - atan2(a.y-b.y, a.x-b.x);
}

void main() {
  var map = Map.fromDesc(desc);
  var result = findBesetAsteroid(map);
  print('Best asteroid: ${result.asteroid}, ${result.visibleCount} others visible');


  var monitoringStation = Asteroid(30,34);
  var asteroids = map.asteroids.map((it) => AsteroidInfo.from(monitoringStation, it)).toList();
  var grouped = groupBy(asteroids, (AsteroidInfo info) => info.angle);
  print(grouped.keys);
}