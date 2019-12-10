import 'package:test/test.dart';

class Asteroid {
  int _x;
  int get x => _x;
  int _y;
  int get y => _y;

  Asteroid(this._x, this._y);

  @override
  String toString() {
    return "($_x, $_y)";
  }
}

class Map {
  List<Asteroid> _asteroids;
  List<Asteroid> get asteroids => _asteroids;
  Map(this._asteroids);

  factory Map.from(String mapDescription) {
    int asteroidChar = "#".codeUnitAt(0);
    List<Asteroid> asteroids = [];
    var lines = mapDescription.split("\n");
    for(var y=0; y < lines.length; y++) {
      var line = lines[y];
      for(var x=0; x < line.length; x++) {
        var char = line.codeUnitAt(x);
        if (char == asteroidChar) {
          asteroids.add(Asteroid(x, y));
        }
      }
    }
    return Map(asteroids);
  }

  @override
  String toString() {
    return _asteroids.toString();
  }
}

void main() {
  test("test case 1", () {
    var map = """
      .#..#
      .....
      #####
      ....#
      ...##
      """.trimLines();

    print(Map.from(map));
  });
}

extension Trimmer on String {
  String trimLines() {
    return this
      .replaceAll(RegExp(r"\n\s+"), "\n")
      .replaceAll(RegExp(r"\s+\n"), "\n")
      .trim();
  }
}