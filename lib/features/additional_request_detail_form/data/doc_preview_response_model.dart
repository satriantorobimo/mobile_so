class DocPreviewResponseModel {
  Value? value;
  String? message;
  int? statusCode;

  DocPreviewResponseModel({this.value, this.message, this.statusCode});

  DocPreviewResponseModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value']) : null;
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Value {
  String? data;
  String? filename;

  Value({this.data, this.filename});

  Value.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['filename'] = filename;
    return data;
  }
}
