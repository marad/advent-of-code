import 'computer.dart';

List<int> runProgram(List<int> program) {
  var computer = Computer(program);
  computer.run();
  return computer.memory.take(program.length).toList();
}

int runWithArgs(List<int> input, int noun, int verb) {
  List<int> program = List.from(input);
  program[1] = noun;
  program[2] = verb;
  var computer = Computer(program);
  computer.run();
  return computer.memory[0];
}