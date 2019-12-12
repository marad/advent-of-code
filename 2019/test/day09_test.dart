import 'package:aoc2019/src/computer.dart';
import 'package:test/test.dart';

void main() {
  test("test case 1", () {
    var code = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99];
    var io = TestIO();
    var computer = Computer(code, io: io);
    computer.run();
    expect(io.outputs, code);
  });

  test("test case 2", () {
    var io = TestIO();
    var computer = Computer([1102,34915192,34915192,7,4,7,99,0], io: io);
    computer.run();
    expect(io.lastOutput, 1219070632396864);
  });

  test("test case 3", () {
    var io = TestIO();
    var computer = Computer([104,1125899906842624,99], io: io);
    computer.run();
    expect(io.lastOutput, 1125899906842624);
  });

  test("move relative base forward", () {
    var computer = Computer([109,19,99], io: TestIO());
    computer.run();
    expect(computer.relativeBase, 19);
  });

  test("move relative base backward", () {
    var computer = Computer([109,-100,99], io: TestIO());
    computer.run();
    expect(computer.relativeBase, -100);
  });

  test("add in relative mode", () {
    var io = TestIO();
    var computer = Computer([109, 8, 2201, 1, 2, 11, 4, 11, 99, 39, 3], io: io);
    computer.run();
    expect(io.lastOutput, 42);
  });

  test("relational input mode", () {
    var io = TestIO(toInput: 123);
    Computer([109, 6, 203, 1, 4, 7, 99], io: io).run();
    expect(io.lastOutput, 123);
  });
}