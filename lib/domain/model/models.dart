class Data {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String token;

  Data(this.id, this.name, this.email, this.phone, this.image, this.token);
}

class User {
  Data? data;

  User(this.data);
}

class RecipeIngredients {
  double amount;
  String nameClean;
  String unit;
  String image;

  RecipeIngredients(this.amount, this.nameClean, this.unit, this.image);
}

class RecipeSteps {
  int number;
  String step;

  RecipeSteps(this.step, this.number);
}

class RecipeInformation {
  int id;
  String title;
  String image;
  int aggregateLikes;
  int readyInMinutes;
  int healthScore;
  int servings;
  String summary;

  RecipeInformation(this.id, this.title, this.image, this.aggregateLikes,
      this.readyInMinutes,this.healthScore, this.servings, this.summary);
}

class RecipeData {
  RecipeInformation? recipeInformation;
  List<RecipeIngredients>? recipeIngredients;
  List<RecipeSteps>? recipeSteps;

  RecipeData(this.recipeInformation, this.recipeIngredients, this.recipeSteps);
}

class SearchRecipeResults {
  int id;
  String title;
  String image;

  SearchRecipeResults(this.id, this.title, this.image);
}

class SearchIngredientResults {
  int id;
  String name;
  String image;

  SearchIngredientResults(this.id, this.name, this.image);
}

class SearchRecipeWithIngResult {
  int id;
  int usedIngredientCount;
  int missedIngredientCount;
  String title;
  String image;

  SearchRecipeWithIngResult(this.id, this.title, this.image,
      this.usedIngredientCount, this.missedIngredientCount);
}

class Category {
  String name;
  String image;

  Category(this.name, this.image);
}

class Ingredient {
  String name;
  String image;

  Ingredient(this.name, this.image);
}
