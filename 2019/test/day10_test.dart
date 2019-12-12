import 'package:test/test.dart';
import 'package:aoc2019/src/day10.dart';



void main() {
  test("test case 1", () {
    var map = Map.fromDesc("""
      .#..#
      .....
      #####
      ....#
      ...##
      """.trimLines());
    
    var result = findBesetAsteroid(map);
    expect(result.asteroid, Asteroid(3, 4));
    expect(result.visibleCount, 8);
  });

  test("test case 2", () {
    var map = Map.fromDesc("""
      ......#.#.
      #..#.#....
      ..#######.
      .#.#.###..
      .#..#.....
      ..#....#.#
      #..#....#.
      .##.#..###
      ##...#..#.
      .#....####""".trimLines());
    
    var result = findBesetAsteroid(map);
    expect(result.asteroid, Asteroid(5, 8));
    expect(result.visibleCount, 33);
  });

  test("test case 3", () {
    var map = Map.fromDesc("""
      #.#...#.#.
      .###....#.
      .#....#...
      ##.#.#.#.#
      ....#.#.#.
      .##..###.#
      ..#...##..
      ..##....##
      ......#...
      .####.###.""".trimLines());
    
    var result = findBesetAsteroid(map);
    expect(result.asteroid, Asteroid(1, 2));
    expect(result.visibleCount, 35);
  });
}
