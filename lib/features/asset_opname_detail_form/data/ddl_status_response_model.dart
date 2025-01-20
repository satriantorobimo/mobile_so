class DdlStatusResponseModel {
  int? result;
  String? message;
  int? statusCode;
  List<Data>? data;
  String? code;
  int? id;

  DdlStatusResponseModel(
      {this.result,
        this.message,
        this.statusCode,
        this.data,
        this.code,
        this.id});

  DdlStatusResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    statusCode = json['StatusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    data['StatusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['id'] = id;
    return data;
  }
}

class Data {
  String? code;
  String? status;

  Data({this.code, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    return data;
  }
}
