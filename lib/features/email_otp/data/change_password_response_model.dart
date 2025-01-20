class ChangePasswordResponseModel {
  int? result;
  String? message;
  int? statusCode;
  String? data;
  String? code;
  int? id;

  ChangePasswordResponseModel(
      {this.result,
      this.message,
      this.statusCode,
      this.data,
      this.code,
      this.id});

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    statusCode = json['StatusCode'];
    data = json['data'];
    code = json['code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['StatusCode'] = statusCode;
    data['data'] = this.data;
    data['code'] = code;
    data['id'] = id;
    return data;
  }
}
