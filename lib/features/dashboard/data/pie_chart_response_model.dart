class PieChartResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;
  int? recordstotal;

  PieChartResponseModel(
      {this.result,
      this.message,
      this.data,
      this.code,
      this.id,
      this.recordstotal});

  PieChartResponseModel.fromJson(Map<String, dynamic> json) {
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
  var percentageResult;

  Data({this.code, this.description, this.total, this.percentageResult});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    total = json['total'];
    percentageResult = json['percentage_result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['description'] = description;
    data['total'] = total;
    data['percentage_result'] = percentageResult;
    return data;
  }
}
