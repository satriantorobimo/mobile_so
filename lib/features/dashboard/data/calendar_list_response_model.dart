class CalendarListResponseModel {
  int? recordsTotal;
  List<Results>? results;
  String? message;

  CalendarListResponseModel({this.recordsTotal, this.results, this.message});

  CalendarListResponseModel.fromJson(Map<String, dynamic> json) {
    recordsTotal = json['recordsTotal'];
    message = json['message'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recordsTotal'] = recordsTotal;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? date;
  List<Data>? data;

  Results({this.date, this.data});

  Results.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? code;
  String? opnameStartDate;
  String? opnameEndDate;
  String? status;
  int? totalAsset;

  Data(
      {this.code,
      this.opnameStartDate,
      this.opnameEndDate,
      this.status,
      this.totalAsset});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    opnameStartDate = json['opname_start_date'];
    opnameEndDate = json['opname_end_date'];
    status = json['status'];
    totalAsset = json['total_asset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['opname_start_date'] = opnameStartDate;
    data['opname_end_date'] = opnameEndDate;
    data['status'] = status;
    data['total_asset'] = totalAsset;
    return data;
  }
}
