import 'package:test/test.dart';
import 'package:aoc2019/src/computer.dart';

void main() {
  testComputer("noop program", 
    [99], 
    expectedMemory: [99],
    expectedIP: 0);

  testComputer("positional adding", 
    [OP_ADD, 5, 6, 0, 99, 10, 5],
    expectedMemory: [15, 5, 6, 0, 99, 10, 5],
    expectedIP: 4);

  testComputer("positional multiplying", 
    [OP_MUL, 5, 6, 0, 99, 10, 5],
    expectedMemory: [50, 5, 6, 0, 99, 10, 5],
    expectedIP: 4);

  testComputer("test input", 
    [OP_INPUT, 3, 99, 0],
    constantInput: 123,
    expectedMemory: [OP_INPUT, 3, 99, 123],
    expectedIP: 2);

  testComputer("test output", 
    [OP_OUTPUT, 3, 99, 123],
    expectedOutput: 123,
    expectedIP: 2);

  // TODO: fix those tests
  // testComputer("test no JNZ false",
  //   [100 + OP_JNZ, 0, 99],
  //   expectedIP: 2);

  // testComputer("test JNZ true", 
  //   [100 + OP_JNZ, 5, 99, 99, 99, 99],
  //   expectedIP: 5);

  testComputer("test JZ false",
    [100 + OP_JZ, 123, 0, 99],
    expectedIP: 3);

  testComputer("test JZ true",
    [1100 + OP_JZ, 0, 5, 99, 99, 99],
    expectedIP: 5);

  testComputer("test LT true",
    [OP_LT, 7, 8, 9, OP_OUTPUT, 9, 99, 1, 2, 100],
    expectedOutput: 1);

  testComputer("test LT false",
    [OP_LT, 7, 8, 9, OP_OUTPUT, 9, 99, 2, 1, 100],
    expectedOutput: 0);
  
  testComputer("test EQ", 
    [OP_EQ, 7, 8, 9, OP_OUTPUT, 9, 99, 2, 2, 100],
    expectedOutput: 1);

  testComputer("test EQ", 
    [OP_EQ, 7, 8, 9, OP_OUTPUT, 9, 99, 2, 3, 100],
    expectedOutput: 0);

  testComputer("test EQ in position mode true", 
    [3,9,8,9,10,9,4,9,99,-1,8],
    constantInput: 8,
    expectedOutput: 1);

  testComputer("test EQ in position mode false", 
    [3,9,8,9,10,9,4,9,99,-1,8],
    constantInput: 10,
    expectedOutput: 0);
    
  testComputer("test EQ in immediate mode true", 
    [3,3,1108,-1,8,3,4,3,99],
    constantInput: 8,
    expectedOutput: 1);

  testComputer("test EQ in immediate mode false", 
    [3,3,1108,-1,8,3,4,3,99],
    constantInput: 10,
    expectedOutput: 0);

  testComputer("test LT in position mode true",
    [3,9,7,9,10,9,4,9,99,-1,8],
    constantInput: 7,
    expectedOutput: 1);

  testComputer("test LT in position mode false",
    [3,9,7,9,10,9,4,9,99,-1,8],
    constantInput: 8,
    expectedOutput: 0);

  testComputer("test LT in immediate mode true",
    [3,3,1107,-1,8,3,4,3,99],
    constantInput: 7,
    expectedOutput: 1);

  testComputer("test LT in immediate mode false",
    [3,3,1107,-1,8,3,4,3,99],
    constantInput: 8,
    expectedOutput: 0);

  testComputer("test jump in position mode", 
    [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9],
    constantInput: 100,
    expectedOutput: 1);

  testComputer("test jump in immediate mode", 
    [3,3,1105,-1,9,1101,0,0,12,4,12,99,1],
    constantInput: 100,
    expectedOutput: 1);
}

void testComputer(String desc, List<int> program, 
                 {List<int> expectedMemory = null,
                  int constantInput = null,
                  int expectedOutput = null,
                  int expectedIP = null}) {
  var fakeIO = TestIO(toInput: constantInput);
  var computer = Computer(program, io: fakeIO);
  computer.run();
  test(desc, () {
    if (expectedMemory != null) {
      expect(computer.memory, expectedMemory);
    }
    if (expectedIP != null) {
      expect(computer.ip, expectedIP);
    }
    if (expectedOutput != null) {
      expect(fakeIO.lastOutput, expectedOutput);
    }
  });
}