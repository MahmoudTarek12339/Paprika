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
