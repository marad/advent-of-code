import 'package:aoc2019/src/day10.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'dart:math';
import 'dart:core';

var desc2 = """
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

var desc = """
.#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##""".trimLines();

class AsteroidInfo {
  final Asteroid asteroid;
  final int distance; // distance from monitoring station
  final int angle;

  AsteroidInfo(this.asteroid, this.distance, this.angle);

  factory AsteroidInfo.from(Asteroid monitoringStation, Asteroid target) {
    var distance = (monitoringStation.x - target.x).abs() + (monitoringStation.y - target.y).abs();
    var top = Asteroid(monitoringStation.x, monitoringStation.y - 1);
    // var angle = getAngle(target, monitoringStation, top);
    var angle = getAngle(target, monitoringStation, top);
    angle = angle < 0 ? angle + pi * 2 : angle;
    var intang = (angle * 100000).toInt();

    return AsteroidInfo(target, distance, intang);
  }

}

// TODO: group and sort by angle, then by distance
// for each laser rotation it destroys first asteroid in each group

int byDistance(AsteroidInfo a, AsteroidInfo b) {
  return a.distance.compareTo(b.distance);
}

void main() {
  var map = SpaceMap.fromDesc(desc2);
  var result = findBestAsteroid(map);
  print('Best asteroid: ${result.asteroid}, ${result.visibleCount} others visible');


  var monitoringStation = result.asteroid;
  var asteroids = map.asteroids.map((it) => AsteroidInfo.from(monitoringStation, it)).toList();
  var groups = groupBy(asteroids, (AsteroidInfo info) => info.angle)
    .map((angle, asteroids) {
      return MapEntry(angle, asteroids..sort(byDistance));
    });
  print('Asteroids: ${asteroids.length}');
  print('Groups: ${groups.length}');

  var angles = groups.keys.toList()..sort();
  // print(angles);

  var currentAngleIndex = 0;
  var currentAsteroid = 0;
  while(true) {
    var angle = angles[currentAngleIndex];
    var asteroidGroup = groups[angle];
    if (asteroidGroup.length > 0) {
      currentAsteroid += 1;
      var info = asteroidGroup.removeAt(0);
      print('Vaporized asteroid #$currentAsteroid: ${info.asteroid}');
      currentAngleIndex += 1;
    }
  }
}