import 'package:test/test.dart';
import 'package:aoc2019/src/day04.dart';

void main() {

  // test("part 1", () {
  //   expect(checkPasswordCandidates([111111, 223450, 123789]), [111111]);
  // });

  // test("part 2", () {
  //   expect(checkPasswordCandidates([112233, 123444, 111122]), [112233, 111122]);
  // });

  // testPassword(111223, true);
  // testPassword(111111, true);
  testPassword(111122, true);
}

testPassword(int candidate, bool shouldPass) {
  test("test $candidate", () {
    expect(checkPasswordCandidates([candidate]), shouldPass ? [candidate] : []);
  });
}