
var dirMap = {
  'U': 1, 'D': -1,
  'R': 1, 'L': -1, 
};

int findNearestCrossingDistance(String wireA, String wireB) {
  var pointsA = WireTracer().traceWire(wireA);
  var pointsB = WireTracer().traceWire(wireB);
  var crossingPoints = pointsA.intersection(pointsB);
  var origin = Point(0, 0);
  return crossingPoints
    .map((p) => manhattanDistance(origin, p))
    .reduce((smallestSoFar, value) => smallestSoFar < value ? smallestSoFar : value);
}

int manhattanDistance(Point a, Point b) {
  return (a.x - b.x).abs() + (a.y - b.y).abs();
}

class WireTracer {
  Point _currentPosition = Point(0, 0);

  Set<Point> traceWire(String desc) {
    return desc.split(",")
      .map(traceStep)
      .fold(Set<Point>(), (acc, x) => acc.union(x));
  }

  Set<Point> traceStep(String step) {
    // Step is like U123
    var dirStr = step[0]; // this gets the 'U'
    var dir = dirMap[dirStr];   // and this translates it to numerical direction
    var length = int.parse(step.substring(1)); // this parses the length
    var result = Set<Point>();
    for(var i=0; i < length; i++) {
      if (dirStr == 'U' || dirStr == 'D') {
        _currentPosition = _currentPosition.move(0, dir);
      } else {
        _currentPosition = _currentPosition.move(dir, 0);
      }
      result.add(_currentPosition);
    }
    return result;
  }
}

class Point {
  final int x;
  final int y;
  Point(this.x, this.y);

  Point move(int dx, int dy) => Point(x+dx, y+dy);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Point &&
    x == other.x &&
    y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}