import 'package:test/test.dart';
import 'package:day01/src/lib.dart';

void main() {
  print('hello world');
  test("should properly calculate required fuel for given mass", () {
    expect(fuelForMass(13), 2);
    expect(fuelForMass(14), 2);
    expect(fuelForMass(1969), 654);
    expect(fuelForMass(100756), 33583);
  });


  test("should take into account the mass of the fuel", () {
    expect(calculateFuel(14), 2);
    expect(calculateFuel(1969), 966);
    expect(calculateFuel(100756), 50346);
  });
}