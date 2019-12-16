import 'dart:io';
import 'package:aoc2019/src/computer.dart';
import 'package:vector_math/vector_math.dart';

enum TileType {
  EMPTY,
  WALL,
  BLOCK,
  PADDLE,
  BALL,
}

enum State {
  WAITING_X,
  WAITING_Y,
  WAITING_TYPE,
}

class GameIO extends IO {
  Map<Vector2, TileType> map = Map();
  State state = State.WAITING_X;
  int x;
  int y;
  int score;
  Vector2 ball = Vector2.zero(), paddle = Vector2.zero();

  @override
  int input(Computer computer) {
    if (paddle.x > ball.x) {
      return -1;
    } else if (paddle.x < ball.x) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void output(Computer computer, int value) {
    switch(state) {
      case State.WAITING_X:
        x = value;
        state = State.WAITING_Y;
      break;
      case State.WAITING_Y:
        y = value;
        state = State.WAITING_TYPE;
      break;
      case State.WAITING_TYPE:
        if (x == -1 && y == 0) {
          score = value;
        } else {
          TileType type = TileType.values[value];
          map[Vector2(x.toDouble(),y.toDouble())] = type;
          switch(type) {
            case TileType.BALL:
              ball = Vector2(x.toDouble(), y.toDouble());
              break;
            case TileType.PADDLE:
              paddle = Vector2(x.toDouble(), y.toDouble());
              break;
            default:
          }
        }
        state = State.WAITING_X;
      break;
    }
  }

}

void main() {
  // screen 40x25
  var code = File('inputs/day13.txt').readAsStringSync().split(",").map(int.parse).toList();
  var io = GameIO();
  var computer = Computer(code, io: io);
  computer.run();

  var blockCount = io.map.values.where((it) => it == TileType.BLOCK).length;
  print('Block count: $blockCount');

  code[0] = 2; // hack the system and play for free!!
  io = GameIO();
  computer = Computer(code, io: io);
  computer.run();
  print('Score: ${io.score}');
}