
const OP_ADD = 1;
const OP_MUL = 2;
const OP_END = 99;

List<int> runProgram(List<int> program) {
  var computer = Computer(List.from(program));
  computer.run();
  return computer.memory;
}

int runWithArgs(List<int> input, int noun, int verb) {
  List<int> program = List.from(input);
  program[1] = noun;
  program[2] = verb;
  var computer = Computer(program);
  computer.run();
  return computer.memory[0];
}

class Computer {
  bool _debug;
  int _ip; // instruction pointer
  List<int> memory;

  Computer(this.memory, {debug: false}) {
    this._debug = debug;
    _ip = 0;
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

    var a = _getFirstArg();
    var b = _getSecondArg();
    switch(_getOpCode()) {
      case OP_ADD: 
        if (_debug) print('$a + $b => ${memory[_ip+3]}');
        _saveAtTarget(a+b);
        _ip += 4;
         break;
      case OP_MUL:
        if (_debug) print('$a * $b => ${memory[_ip+3]}');
       _saveAtTarget(a*b);
        _ip += 4;
        break;
    }
    return true;
  }

  int _getOpCode() => memory[_ip];
  int _getFirstArg() => memory[memory[_ip + 1]];
  int _getSecondArg() => memory[memory[_ip + 2]];
  void _saveAtTarget(int value) => memory[memory[_ip + 3]] = value;

}