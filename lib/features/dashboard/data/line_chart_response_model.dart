class LineChartResponseModel {
  int? result;
  int? recordsTotal;
  List<Data>? data;
  String? message;
  String? code;
  int? id;
  int? recordstotal;

  LineChartResponseModel(
      {this.recordsTotal,
      this.data,
      this.message,
      this.code,
      this.id,
      this.result,
      this.recordstotal});

  LineChartResponseModel.fromJson(Map<String, dynamic> json) {
    recordsTotal = json['recordsTotal'];
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
    id = json['id'];
  }
}

class Data {
  String? date;
  List<Datas>? data;

  Data({this.date, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['data'] != null) {
      data = <Datas>[];
      json['data'].forEach((v) {
        data!.add(Datas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  String? code;
  String? description;
  int? total;

  Datas({this.code, this.description, this.total});

  Datas.fromJson(Map<String, dynamic> json) {
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
