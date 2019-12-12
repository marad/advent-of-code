
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

  @override
  int get hashCode => _x.hashCode ^ _y.hashCode;

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Asteroid && this._x == other._x && this._y == other._y;
}

class Map {
  final String _desc;
  final Set<Asteroid> _asteroids;
  final int _width;
  final int _height;
  int get width => _width;
  int get height => _height;
  Set<Asteroid> get asteroids => Set.from(_asteroids);

  Map(this._desc, this._asteroids, this._width, this._height);

  factory Map.fromDesc(String desc) {
    var asteroids = _readAsteroids(desc);
    var lines = desc.split("\n");
    var width = lines[0].length;
    var height = lines.length;
    return Map(desc, asteroids, width, height);
  }

  bool contains(int x, int y) {
    return x >= 0 && y >= 0 && x < _width && y < _height;
  }

  static Set<Asteroid> _readAsteroids(String map) {
    int asteroidChar = "#".codeUnitAt(0);
    Set<Asteroid> asteroids = {};
    var lines = map.split("\n");
    for (var y = 0; y < lines.length; y++) {
      var line = lines[y];
      for (var x = 0; x < line.length; x++) {
        var char = line.codeUnitAt(x);
        if (char == asteroidChar) {
          asteroids.add(Asteroid(x, y));
        }
      }
    }
    return asteroids;
  }
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

int countVisibleAsteroids(int x, int y, Map map) {
  var asteroids = map.asteroids..remove(Asteroid(x, y));
  var result = Set.from(asteroids);
  for(var candidate in asteroids) {
    var dx = candidate.x - x;
    var dy = candidate.y - y;
    var divisor = gcd(dx.abs(), dy.abs());
    dx = dx ~/ divisor;
    dy = dy ~/ divisor;

    var a = candidate.x + dx;
    var b = candidate.y + dy;
    while(true) {
      if (map.contains(a, b)) {
        result.remove(Asteroid(a, b));
        a += dx;
        b += dy;
      } else {
        break;
      }
    }
  }
  return result.length;
}

class Result {
  final Asteroid asteroid;
  final int visibleCount;
  Result(this.asteroid, this.visibleCount);
}

Result findBesetAsteroid(Map map) {
  var asteroids = map.asteroids;
  Asteroid bestAsteroid = null;
  int visibleCount = -1;
  asteroids.forEach((asteroid) {
    var count = countVisibleAsteroids(asteroid.x, asteroid.y, map);
    if (count > visibleCount) {
      bestAsteroid = asteroid;
      visibleCount = count;
    }
  });
  return Result(bestAsteroid, visibleCount);
}

extension Trimmer on String {
  String trimLines() {
    return this
        .replaceAll(RegExp(r"\n\s+"), "\n")
        .replaceAll(RegExp(r"\s+\n"), "\n")
        .trim();
  }
}