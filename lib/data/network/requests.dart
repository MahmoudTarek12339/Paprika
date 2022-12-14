class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String email;
  String password;
  String name;
  String phone;

  RegisterRequest(this.email, this.password, this.name, this.phone);
}

class RandomRecipeRequest {
  String tags;
  int number;

  RandomRecipeRequest(this.tags, this.number);
}

class SearchRequest {
  int number;
  String query;

  SearchRequest(this.number, this.query);
}

class SearchWithIngRequest {
  String ingredients;
  int number;

  SearchWithIngRequest(this.ingredients, this.number);
}
