class ChangePasswordRequestModel {
  String username;
  String password;
  String confirmPassword;

  ChangePasswordRequestModel(
      {required this.username,
      required this.password,
      required this.confirmPassword});
}
