class BarChartResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;
  int? recordstotal;

  BarChartResponseModel(
      {this.result,
      this.message,
      this.data,
      this.code,
      this.id,
      this.recordstotal});

  BarChartResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    id = json['id'];
    recordstotal = json['recordstotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['id'] = id;
    data['recordstotal'] = recordstotal;
    return data;
  }
}

class Data {
  String? code;
  String? description;
  int? total;

  Data({this.code, this.description, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['description'] = description;
    data['total'] = total;
    return data;
  }
}
