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
