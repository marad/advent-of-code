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

class ChemicalFactory {
  var storage = <String, int>{};
  var usedOre = 0;
  final Map<String, Recipe> recipeBook;

  ChemicalFactory(this.recipeBook);

  void runRecipe(String chemical) {
    var recipe = recipeBook[chemical];
  }
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


int requiredOreX(Map<String, Recipe> book, String chemical, int amout) {
  var map = <String, int>{"FUEL": 1};
  var fromRaw = <String, int>{};
  while(map.keys.length > 1 && map.keys.length != "ORE") {
    print(map);
    if (map.keys.length == 1 && map.keys.first == "ORE") {
      return map["ORE"];
    }

    var chemical = map.keys.where((it) => it != "ORE").first;
    var amount = map[chemical];
    var recipe = book[chemical];

    // if (recipe.ingredients.length == 1 && recipe.ingredients.first.name == "ORE") {
    //   fromRaw.putIfAbsent(chemical, () => 0);
    //   fromRaw[chemical] += amount;
    // } else {
      recipe.ingredients.forEach((ingredient) {
          map.putIfAbsent(ingredient.name, () => 0);
          map[ingredient.name] += (amount / recipe.resultAmount.toDouble()).ceil() * ingredient.amount;
      });
    // }
    map.remove(chemical);
  }

  print('From raw $fromRaw');
  int result = 0;
  for(var chemical in fromRaw.keys) {
    var recipe = book[chemical];
    var factor = (fromRaw[chemical].toDouble() / recipe.resultAmount.toDouble()).ceil();
    result += factor * recipe.ingredients.first.amount;
  }
  return result;
}

void main() {
  var desc = """
    10 ORE => 10 A
    1 ORE => 1 B
    7 A, 1 B => 1 C
    7 A, 1 C => 1 D
    7 A, 1 D => 1 E
    7 A, 1 E => 1 FUEL
  """.trim();
  var book = createRecipeMap(desc);
  var storage = <String,int>{};
  var recipeQueue = Queue<Recipe>();
  var usedOre = 0;

  recipeQueue.add(book["FUEL"]);

  while(recipeQueue.isNotEmpty) {
    print(recipeQueue.map((it) => it.name));
    var recipe = recipeQueue.removeLast();

    // take ore from space
    if (recipe.ingredients.first.name == "ORE") {
      storage.putIfAbsent("ORE", () => 0);
      storage["ORE"] += recipe.ingredients.first.amount;
    }

    // check for ingredients 
    var missingIngQueue = Queue<Recipe>();
    recipe.ingredients.forEach((ingredient) {
      var ingRequired = ingredient.amount;
      var ingStored = storage.putIfAbsent(ingredient.name, () => 0);
      var ingMissing = ingRequired - ingStored;
      if (ingMissing > 0) {
        var ingRecipe = book[ingredient.name];
        var recipeTimes = (ingMissing.toDouble() / ingRecipe.resultAmount).ceil();
        for(var i=0; i < recipeTimes; i++) {
          missingIngQueue.add(ingRecipe);
        }
      }
    });

    if (missingIngQueue.isNotEmpty) {
      recipeQueue.add(recipe); // we still need to make this recipe
      recipeQueue.addAll(missingIngQueue); // make missing ingredients first
    } else {
      // consume resources and create the chemical
      recipe.ingredients.forEach((it) {
        if (it.name == "ORE") {
          usedOre += it.amount;
        }
        storage[it.name] -= it.amount;
      });
      storage.putIfAbsent(recipe.name, () => 0);
      storage[recipe.name] += recipe.resultAmount;
    }
  }

  print(usedOre);
}