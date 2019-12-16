import 'package:vector_math/vector_math.dart';

class Moon {
  Vector3 position = Vector3.zero();
  Vector3 velocity = Vector3.zero();
  Moon(Vector3 startingPosition) {
    position = startingPosition;
  }

  Moon clone() {
    var cloned = Moon(Vector3.copy(position));
    cloned.velocity = Vector3.copy(velocity);
    return cloned;
  }

  int potentialEnergy() {
    return position.x.abs().toInt() + position.y.abs().toInt() + position.z.abs().toInt();
  }

  int kineticEnergy() {
    return velocity.x.abs().toInt() + velocity.y.abs().toInt() + velocity.z.abs().toInt();
  }

  int totalEnergy() {
    return potentialEnergy() * kineticEnergy();
  }

  @override
  String toString() => "Moon($position, $velocity)";

  @override
  int get hashCode => position.hashCode ^ velocity.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Moon &&
    this.velocity == other.velocity && this.position == other.position;
}

extension MoonList on List<Moon> {
  int sumOfTotalEnergy() => this.map((it) => it.totalEnergy()).reduce((a,b) => a+b);

  void updateVelocity() {
    for(var a=0; a < this.length; a++) {
      var moonA = this[a];
      for(var b=a; b < this.length; b++) {
        var moonB = this[b];
        if (moonA == moonB) {
          continue;
        }

        for(var i=0; i < 3; i++) {
          var valA = moonA.position[i];
          var valB = moonB.position[i];
          if (valA == valB) {
            continue;
          } else if (valA < valB) {
            moonA.velocity[i] += 1;
            moonB.velocity[i] -= 1;
          } else {
            moonA.velocity[i] -= 1;
            moonB.velocity[i] += 1;
          }
        }

      }
    }
  }

  void updatePositions() {
    for(var moon in this) {
      moon.position += moon.velocity;
    }
  }

  void simulationStep() {
    this.updateVelocity();
    this.updatePositions();
  }

  bool isTheSame(List<Moon> other) {
    if (this.length != other.length) {
      return false;
    }
    for(var i=0; i < this.length; i++) {
      if (this[i].position != other[i].position) {
        return false;
      }
    }
    return true;
  }

  List<Moon> clone() {
    return this.map((it) => it.clone()).toList();
  }
}

int findCycleForDimension(var dimensionIndex, List<Moon> template) {
  var moons = template.clone();
  var steps = 1;
  while(true) {
    steps++;
    moons.simulationStep();
    
    var isTheSame = List.generate(4, (moonIndex) => template[moonIndex].position[dimensionIndex] == moons[moonIndex].position[dimensionIndex])
      .reduce((a, b) => a && b);

    if (isTheSame) {
      return steps;
    }
  }
}

int lcm(int a, int b) => (a * b) ~/ gcd(a, b);

int gcd(int a, int b) {
  while (b != 0) {
    var t = b;
    b = a % t;
    a = t;
  }
  return a;
}