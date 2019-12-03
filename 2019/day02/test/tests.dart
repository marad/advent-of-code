import 'package:test/test.dart';
import 'package:solution/src/lib.dart';

void main() {
  group("computer", () {
    test("should take into account the mass of the fuel", () {
      expect(runProgram([1,9,10,3,2,3,11,0,99,30,40,50]), [3500,9,10,70,2,3,11,0,99,30,40,50]);
      expect(runProgram([1,0,0,0,99]), [2,0,0,0,99]);
      expect(runProgram([2,3,0,3,99]), [2,3,0,6,99]);
      expect(runProgram([2,4,4,5,99,0]), [2,4,4,5,99,9801]);
      expect(runProgram([1,1,1,4,99,5,6,0,99]), [30,1,1,4,2,5,6,0,99]);
    });
  });
}