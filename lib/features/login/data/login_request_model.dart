class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory LoginRequestModel.fromMap(Map<String, dynamic> map) {
    return LoginRequestModel(
      username: map['username'],
      password: map['password'],
    );
  }
}
