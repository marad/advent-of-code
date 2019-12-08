import 'computer.dart';

List<int> runProgram(List<int> program, {IO io=null, debug: false}) {
  var computer = Computer(List.from(program), io: io, debug: debug);
  computer.run();
  return computer.memory;
}