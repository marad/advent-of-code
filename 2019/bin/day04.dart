import 'package:aoc2019/src/day04.dart';

void main() {
  var candidates = generateRange(134792, 675810);
  var matching = checkPasswordCandidates(candidates);
  print("Matching candidates: ${matching.length}");
}
