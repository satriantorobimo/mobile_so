class OtpValidateRequestModel {
  String username;
  String otp;

  OtpValidateRequestModel({required this.username, required this.otp});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'otp': otp,
    };
  }

  factory OtpValidateRequestModel.fromMap(Map<String, dynamic> map) {
    return OtpValidateRequestModel(
      username: map['username'],
      otp: map['otp'],
    );
  }
}
