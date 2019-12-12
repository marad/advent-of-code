import 'dart:collection' show HashMap;

import 'dart:math';

class Orbits {
  final HashMap<String, String> parentMap;

  Orbits(this.parentMap);

  factory Orbits.fromOrbitNotation(List<String> orbitNotation) {
    var parentMap = HashMap<String, String>();
    orbitNotation.forEach((it) {
      var tmp = it.split(')');
      var starA = tmp[0];
      var starB = tmp[1];
      parentMap.putIfAbsent(starB, () => starA);
    });
    return Orbits(parentMap);
  }

  int countOrbits(String starName) {
    var parent = starName;
    var count = 1;
    while((parent = parentMap[parent]) != "COM") {
      count += 1;
    }
    return count;
  }

  int totalOrbits() {
    return parentMap.keys
      .map(countOrbits)
      .reduce((sum, orbits) => sum + orbits);
  }

  List<String> getPath(String starName) {
    var path = <String>[starName];
    var star = starName;
    while((star = parentMap[star]) != "COM") {
      path.insert(0, star);
    }
    return path;
  }

  int calcTransfers(String source, String target) {
    var sourcePath = getPath(source)..removeLast();
    var targetPath = getPath(target)..removeLast();

    // find common ancestor
    var lastcommonStarIndex = 0;
    for(var i = 0; i <= min(sourcePath.length, targetPath.length); i++) {
      if (sourcePath[i] == targetPath[i]) {
        lastcommonStarIndex = i;
        continue;
      } else {
        break;
      }
    }

    // remove common prefix
    sourcePath.removeRange(0, lastcommonStarIndex);
    targetPath.removeRange(0, lastcommonStarIndex);

    print(sourcePath);
    print(targetPath);

    return sourcePath.length + targetPath.length - 2;
  }
}


void main() {
  var parentMap = HashMap<String, List<String>>();

  parentMap.putIfAbsent("A", () => []);
  parentMap.update("A", (current) => current..add("B"));
  parentMap.putIfAbsent("A", () => []);
  print(parentMap["A"]);
}