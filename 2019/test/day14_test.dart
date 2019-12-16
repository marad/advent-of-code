import 'package:test/test.dart';
import 'package:aoc2019/src/day14.dart';

void main() {
  test("should create recipe from description", () {
    var description = "7 A, 1 B => 2 C";
    var recipe = Recipe.from(description);
    expect(recipe.name, "C");
    expect(recipe.resultAmount, 2);
    expect(recipe.ingredients[0].amount, 7);
    expect(recipe.ingredients[0].name, "A");
    expect(recipe.ingredients[1].amount, 1);
    expect(recipe.ingredients[1].name, "B");
  });

  test("calculating ore", () {
    var description = """
      9 ORE => 2 A
      8 ORE => 3 B
      7 ORE => 5 C
      3 A, 4 B => 1 AB
      5 B, 7 C => 1 BC
      4 C, 1 A => 1 CA
      2 AB, 3 BC, 4 CA => 1 FUEL
    """.trim();

    var book = createRecipeMap(description);

    expect(requiredOre(book, "A", 1), 9);
    expect(requiredOre(book, "A", 2), 9);
    expect(requiredOre(book, "A", 3), 18);
    expect(requiredOre(book, "B", 4), 16);
    expect(requiredOre(book, "AB", 1), 34);
    // expect(requiredOre(book, "BC", ))
  });
}