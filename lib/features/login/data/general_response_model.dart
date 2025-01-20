class GeneralResponseModel {
  int? status;
  String? message;
  int? result;
  String? code;

  GeneralResponseModel({this.status, this.message, this.result, this.code});

  GeneralResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['result'] = result;
    data['message'] = message;
    return data;
  }
}
