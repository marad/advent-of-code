import 'dart:io';
import 'package:solution/src/lib.dart';

void main() {
  var candidates = generateRange(134792, 675810);
  var matching = checkPasswordCandidates(candidates);
  print("Matching candidates: ${matching.length}");
}
