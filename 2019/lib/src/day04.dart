List<int> generateRange(int from, int to) {
  assert(to >= from);
  return List.generate(to-from, (i) => i + from);
}

List<int> checkPasswordCandidates(List<int> candidates) {
    return candidates
      .where(_isSixDigitNumber)
      .where(_hasTwoAdjacentDigits)
      .where(_hasOnlyIncreasingDigits)
      .toList();
}

bool _isSixDigitNumber(int candidate) {
  return 100000 <= candidate && candidate <= 999999;
}

bool _hasTwoAdjacentDigits(int candidate) {
  var chars = candidate.toString().codeUnits;
  var groups = List<List<int>>();
  var currentGroup = <int>[];

  for(int i=0; i < chars.length; i++) {
    var char = chars[i];
    if (currentGroup.isEmpty || currentGroup[0] == char) {
      currentGroup.add(char);
    } else if (currentGroup[0] != char) {
      groups.add(currentGroup);
      currentGroup = [char];
    }
  }

  groups.add(currentGroup);

  return groups.where((group) => group.length == 2).length > 0;


  // for(int i=1; i < chars.length; i++) {
  //   if (chars[i-1] == chars[i]) {
  //     lastGroupLength += 1;
  //   } else if (lastGroupLength > 1 && lastGroupLength % 2 == 1) {
  //     return false;
  //   } else {
  //     lastGroupLength = 1;
  //   }
  // }
  // return lastGroupLength % 2 == 0;
}

bool _hasOnlyIncreasingDigits(int candidate) {
  var chars = candidate.toString().codeUnits;
  for(int i=1; i < chars.length; i++) {
    if (chars[i-1] > chars[i]) {
      return false;
    }
  }
  return true;
}