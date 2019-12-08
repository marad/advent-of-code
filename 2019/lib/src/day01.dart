
int fuelForMass(int mass) {
  return (mass / 3).floor() - 2;
}

int calculateFuel(int mass) {
  var totalFuelRequired = 0;
  for(var fuelRequired = fuelForMass(mass); fuelRequired >= 0; fuelRequired = fuelForMass(fuelRequired)) {
    totalFuelRequired += fuelRequired;
  }
  return totalFuelRequired;
}