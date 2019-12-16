import 'dart:collection';

class Ingredient {
  final String name;
  final int amount;
  Ingredient(this.name, this.amount);
  @override
  String toString() => '$amount $name';

  factory Ingredient.from(String ingredientDescription) {
    var tmp = ingredientDescription.trim().split(" ");
    var name = tmp[1].trim();
    var amount = int.parse(tmp[0].trim());
    return Ingredient(name, amount);
  }
}

class Recipe {
    final String name;
    final int resultAmount;
    final List<Ingredient> ingredients;
    Recipe(this.name, this.resultAmount, this.ingredients);

    factory Recipe.from(String recipeDescription) {
      var tmp = recipeDescription.split("=>");
      var ingredientsDesc = tmp[0].trim().split(",");
      var resultDesc = tmp[1].trim();

      tmp = resultDesc.split(" ");
      var resultAmount = int.parse(tmp[0].trim());
      var name = tmp[1].trim();
      var ingredients = ingredientsDesc.map((it) => Ingredient.from(it)).toList();

      return Recipe(name, resultAmount, ingredients);
    }

    @override
  String toString() => "${ingredients.join(", ")} => $resultAmount $name";
}

Map<String, Recipe> createRecipeMap(String recipeDescriptions) {
  var result = <String, Recipe>{};
  recipeDescriptions
    .split("\n")
    .map((it) => Recipe.from(it.trim()))
    .forEach((recipe) => result[recipe.name] = recipe);
  return result;
}

// class Requirement {
//   final int amount;
//   final String name;
//   Requirement(this.amount, this.name);
//   factory Requirement.from(Ingredient ingredient) =>
//     Requirement(ingredient.amount, ingredient.name);
// }

int calculateRequiredOre(Map<String, Recipe> recipeBook) {
  var requirements = <String, int>{"FUEL": 1};
  var recipeQueue = Queue<Recipe>.from([recipeBook["FUEL"]]);
  while(recipeQueue.isNotEmpty) {
    var recipe = recipeQueue.removeFirst();
    recipe.ingredients.forEach((ing) {
      if (ing.name != "ORE") {
        requirements.putIfAbsent(ing.name, () => 0);
        requirements[ing.name] += ing.amount;
        recipeQueue.add(recipeBook[ing.name]);
      }
    });
  }

  var ore = 0;
  print(requirements);
  return ore;
}

int requiredOre(Map<String, Recipe> book, String chemical, int amount) {
  if (chemical == "ORE") {
    return amount;
  } else {
    var recipe = book[chemical];
    var reactionCountRequired = (amount.toDouble() / recipe.resultAmount.toDouble()).ceil();
    return reactionCountRequired * recipe.ingredients
      .map((it) => requiredOre(book, it.name, it.amount))
      .reduce((a,b) => a+b);
  }
}
