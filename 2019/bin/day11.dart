import 'dart:io';
import 'package:aoc2019/src/computer.dart';

class Coord {
  final int x;
  final int y;
  Coord(this.x, this.y);
  @override
  String toString() => "Coord($x, $y)";
  @override
  int get hashCode => x.hashCode ^ y.hashCode;
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coord && this.x == other.x && this.y == other.y;
}

enum Color { BLACK, WHITE }

class Hull {
  var colors = Map<Coord, Color>();

  Hull() {
    colors[Coord(0,0)] = Color.WHITE;
  }

  Color getColor(Coord coord) {
    return colors.putIfAbsent(coord, () => Color.BLACK);
  }
  void paint(Coord coord, Color color) {
    colors[coord] = color;
  }
}

class RobotIO extends IO {
  final Hull hull;
  final Robot robot;
  int lastOutput;

  RobotIO(this.hull, this.robot);

  @override
  void output(Computer computer, int value) {
    lastOutput = value;
    computer.suspend();
  }

  @override
  int input(Computer computer) {
    return hull.getColor(robot.position).index;
  }
}

enum Direction { UP, DOWN, LEFT, RIGHT }

Direction turn(Direction current, int instruction) {
  if (instruction == 0) {
    switch(current) {
      case Direction.UP: return Direction.LEFT;
      case Direction.LEFT: return Direction.DOWN;
      case Direction.DOWN: return Direction.RIGHT;
      case Direction.RIGHT: return Direction.UP;
    }
  } else if (instruction == 1) {
    switch(current) {
      case Direction.UP: return Direction.RIGHT;
      case Direction.RIGHT: return Direction.DOWN;
      case Direction.DOWN: return Direction.LEFT;
      case Direction.LEFT: return Direction.UP;
    }
  } else {
    throw "Unknown instruction!";
  }
}

class Robot {
  final Hull hull;
  RobotIO _io;
  Computer _computer;
  var direction = Direction.UP;
  var position = Coord(0, 0);

  Set<Coord> painted = {};

  Robot(this.hull, List<int> software) {
    this._io = RobotIO(hull, this);
    this._computer = Computer(software, io: _io);
  }

  void work() {
    while(!_computer.done) {
      _computer.run();
      if (_computer.done) break;
      var newColor = _io.lastOutput;
      _computer.run();
      var turnInstruction = _io.lastOutput;
      hull.paint(position, Color.values[newColor]);
      painted.add(position);

      direction = turn(direction, turnInstruction);
      switch(direction) {
        case Direction.UP: position = Coord(position.x, position.y+1); break;
        case Direction.DOWN: position = Coord(position.x, position.y-1); break;
        case Direction.LEFT: position = Coord(position.x-1, position.y); break;
        case Direction.RIGHT: position = Coord(position.x+1, position.y); break;
      }
    }
  }
}

void main() {
  var code = File("inputs/day11.txt").readAsStringSync().split(",").map(int.parse).toList();
  var hull = Hull();
  var robot = Robot(hull, code);
  robot.work();
  print(hull.colors.keys.length);
  print(robot.painted.length);

  var xs = hull.colors.keys.map((it) => it.x);
  var ys = hull.colors.keys.map((it) => it.y);

  var xMin = xs.reduce((a, b) => a < b ? a : b);
  var xMax = xs.reduce((a, b) => a > b ? a : b);
  var yMin = ys.reduce((a, b) => a < b ? a : b);
  var yMax = ys.reduce((a, b) => a > b ? a : b);

  for(var y=yMax; y >= yMin; y--) {
    for(var x=xMin-1; x <= xMax; x++) {
      var coord = Coord(x, y);
      var color = hull.getColor(coord);
      if (color == Color.BLACK) {
        stdout.write(" ");
      } else if (color == Color.WHITE) {
        stdout.write("#");
      } else {
        stdout.write("?");
      }
    }
    stdout.write("\n");
  }
}