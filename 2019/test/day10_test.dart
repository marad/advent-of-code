import 'package:test/test.dart';
import 'package:aoc2019/src/day10.dart';



void main() {
  test("test case 1", () {
    var map = SpaceMap.fromDesc("""
      .#..#
      .....
      #####
      ....#
      ...##
      """.trimLines());
    
    var result = findBestAsteroid(map);
    expect(result.asteroid, Asteroid(3, 4));
    expect(result.visibleCount, 8);
  });

  test("test case 2", () {
    var map = SpaceMap.fromDesc("""
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
    
    var result = findBestAsteroid(map);
    expect(result.asteroid, Asteroid(5, 8));
    expect(result.visibleCount, 33);
  });

  test("test case 3", () {
    var map = SpaceMap.fromDesc("""
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
    
    var result = findBestAsteroid(map);
    expect(result.asteroid, Asteroid(1, 2));
    expect(result.visibleCount, 35);
  });

  test("vaporization test 1", () {
    var map = SpaceMap.fromDesc("""
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
      ###.##.####.##.#..##
    """.trimLines());

    var result = getNthVaporizedAsteroid(200, map);

    expect(result, Asteroid(11, 12));
  });

  test("simple test", () {
    var map = SpaceMap.fromDesc("""
      #####
      #.###
      #####
    """.trimLines());

    var result = findBestAsteroid(map);

    print(result.asteroid);
    print(result.visibleCount);
    print(getNthVaporizedAsteroid(1, map));
  });
}
