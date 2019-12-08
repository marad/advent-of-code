import 'dart:convert';
import 'dart:io';
import 'dart:math';

const OP_ADD = 1;
const OP_MUL = 2;
const OP_INPUT = 3;
const OP_OUTPUT = 4;
const OP_JNZ = 5;
const OP_JZ = 6;
const OP_LT = 7;
const OP_EQ = 8;
const OP_END = 99;

const MODE_POSITION = 0;
const MODE_IMMEDIATE = 1;

List<int> runProgram(List<int> program, {IO io=null, debug: false}) {
  var computer = Computer(List.from(program), io: io, debug: debug);
  computer.run();
  return computer.memory;
}

// int runWithArgs(List<int> input, int noun, int verb) {
//   List<int> program = List.from(input);
//   program[1] = noun;
//   program[2] = verb;
//   var computer = Computer(program);
//   computer.run();
//   return computer.memory[0];
// }

abstract class IO {
  int input();
  void output(int value);
}

class RealIO extends IO {
  @override
  int input() => int.parse(stdin.readLineSync(encoding: Encoding.getByName('utf-8')));

  @override
  void output(int value) => print(value);
}

class TestIO extends IO {
  var toInput = 0;
  var lastOutput = 0;

  TestIO({this.toInput});

  @override
  int input() => toInput;
  

  @override
  void output(int value) => lastOutput = value;
}


class Computer {
  bool _debug;
  int ip; // instruction pointer
  List<int> memory;
  IO io;

  Computer(this.memory, {debug: false, IO io}) {
    this._debug = debug;
    this.io = io != null ? io : RealIO();
    ip = 0;
  }

  void run() {
    while(tick());
  }

  bool tick() {
    var opcode = _getOpCode();
    if (opcode == OP_END) {
      if (_debug) print('Finished.');
      return false;
    }

    switch(_getOpCode()) {
      case OP_ADD: 
        var a = _getArgValue(1);
        var b = _getArgValue(2);
        var targetAddress = _getArgImmediateValue(3);
        if (_debug) printInstructions(3);
        _saveValueAt(a+b, targetAddress);
        ip += 4;
         break;

      case OP_MUL:
        var a = _getArgValue(1);
        var b = _getArgValue(2);
        var targetAddress = _getArgImmediateValue(3);
        if (_debug) printInstructions(3);
        _saveValueAt(a*b, targetAddress);
        ip += 4;
        break;

      case OP_INPUT:
        var targetAddress = _getArgImmediateValue(1);
        var input = io.input();
        _saveValueAt(input, targetAddress);
        ip += 2;
        break;

      case OP_OUTPUT:
        io.output(_getArgValue(1));
        ip += 2;
        break;
      
      case OP_JNZ:
        // var jumpTarget = _getArgImmediateValue(1);
        var condition = _getArgValue(1);
        var jumpTarget = _getArgValue(2);
        if (condition != 0) {
          ip = jumpTarget;
        } else {
          ip += 3;
        }
        break;

      case OP_JZ:
        var condition = _getArgValue(1);
        var jumpTarget = _getArgValue(2);
        // var jumpTarget = _getArgImmediateValue(2);
        if (condition == 0) {
          ip = jumpTarget;
        } else {
          ip += 3;
        }
        break;

      case OP_LT:
        var a = _getArgValue(1);
        var b = _getArgValue(2);
        var targetAddress = _getArgImmediateValue(3);
        // var targetAddress = _getArgValue(1);
        if (a < b) {
          _saveValueAt(1, targetAddress);
        } else {
          _saveValueAt(0, targetAddress);
        }
        ip += 4;
        break;

      case OP_EQ:
        var a = _getArgValue(1);
        var b = _getArgValue(2);
        var targetAddress = _getArgImmediateValue(3);
        if (a == b) {
          _saveValueAt(1, targetAddress);
        } else {
          _saveValueAt(0, targetAddress);
        }
        ip += 4;
        break;

      default:
        throw "Unknown opcode: $opcode";
        break;
    }
    return true;
  }

  void printInstructions(int argCount) {
    var result = "${memory[ip]}";
    for(var i=0; i<argCount; i++) {
      result += " ${memory[ip+i+1]}";
    }
    print(result);
  }
  int _getInstruction() => memory[ip];
  int _getOpCode() => _getInstruction() % 100;
  int _getMode(int argNum) => (_getInstruction() ~/ pow(10, 1+argNum)) % 10;
  int _getArgValue(int argNum) {
    var mode = _getMode(argNum);
    if (mode == MODE_POSITION) {
      return _getArgPositionalValue(argNum);
    } else if (mode == MODE_IMMEDIATE) {
      return _getArgImmediateValue(argNum);
    } else {
      throw "Unknown mode: $mode";
    }
  }
  int _getArgPositionalValue(int argNum) => memory[memory[ip + argNum]];
  int _getArgImmediateValue(int argNum) => memory[ip + argNum];
  void _saveValueAt(int value, int address) => memory[address] = value;

}

int getMode(int code, int argNum) => (code ~/ pow(10, 1+argNum)) % 10;

void main() {
  int code = 1002;
  int opcode = code % 100;
  // int modeF = (code ~/ 100) % 10;
  // int modeS = (code ~/ 1000) % 10;
  // int modeT = (code ~/ 10000) % 10;
  int modeF = getMode(code, 1);
  int modeS = getMode(code, 2);
  int modeT = getMode(code, 3);

  print(pow(10, 2));

  print('opcode $opcode');
  print('first mode $modeF');
  print('second mode $modeS');
  print('third mode $modeT');

}