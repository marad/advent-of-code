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
const OP_MOVE_RELATIVE_BASE = 9;
const OP_END = 99;

const MODE_POSITION = 0;
const MODE_IMMEDIATE = 1;
const MODE_RELATIVE = 2;

abstract class IO {
  int input(Computer computer);
  void output(Computer computer, int value);
}

class RealIO extends IO {
  @override
  int input(Computer computer) => int.parse(stdin.readLineSync(encoding: Encoding.getByName('utf-8')));

  @override
  void output(Computer computer, int value) => print(value);
}

class TestIO extends IO {
  var toInput = 0;
  var outputs = <int>[];
  int get lastOutput => outputs.last;

  TestIO({this.toInput});

  @override
  int input(Computer computer) => toInput;
  

  @override
  void output(Computer computer, int value) => outputs.add(value);
}


class Computer {
  bool _debug;
  int ip; // instruction pointer
  List<int> memory;
  IO io;
  bool _suspended = false;
  bool _done = false;
  int _relativeBase = 0;

  Computer(List<int> code, {debug: false, IO io, memorySize: 10000}) {
    this.memory = List.filled(memorySize, 0);
    for(var i=0; i < code.length; i++) {
      memory[i] = code[i];
    }
    this._debug = debug;
    this.io = io != null ? io : RealIO();
    ip = 0;
  }

  void run() {
    _suspended = false;
    while(!_suspended && tick());
  }

  void suspend() {
    _suspended = true;
  }

  bool get suspended => _suspended;
  bool get done => _done;
  int get relativeBase => _relativeBase;

  bool tick() {
    var opcode = _getOpCode();
    if (opcode == OP_END) {
      if (_debug) print('Finished.');
      _done = true;
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
        var input = io.input(this);
        _saveValueAt(input, targetAddress);
        ip += 2;
        break;

      case OP_OUTPUT:
        io.output(this, _getArgValue(1));
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
      
      case OP_MOVE_RELATIVE_BASE:
        var a = _getArgValue(1);
        _relativeBase += a;
        ip += 2;
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
    } else if (mode == MODE_RELATIVE) {
      return _getArgRelativeMode(argNum);
    } else {
      throw "Unknown mode: $mode";
    }
  }
  int _getArgPositionalValue(int argNum) => memory[memory[ip + argNum]];
  int _getArgImmediateValue(int argNum) => memory[ip + argNum];
  int _getArgRelativeMode(int argNum) => memory[relativeBase + memory[ip + argNum]];
  void _saveValueAt(int value, int address) => memory[address] = value;
}