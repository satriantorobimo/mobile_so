class NewsResponseModel {
  int? result;
  String? message;
  int? statusCode;
  List<Data>? data;
  String? code;
  int? id;

  NewsResponseModel(
      {this.result,
      this.message,
      this.statusCode,
      this.data,
      this.code,
      this.id});

  NewsResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? description;
  String? newsStatus;
  String? link;
  String? newsTo;
  String? startDate;
  String? endDate;
  int? rowcount;

  Data(
      {this.name,
      this.description,
      this.newsStatus,
      this.link,
      this.newsTo,
      this.startDate,
      this.endDate,
      this.rowcount});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    newsStatus = json['news_status'];
    link = json['link'];
    newsTo = json['news_to'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    rowcount = json['rowcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['news_status'] = newsStatus;
    data['link'] = link;
    data['news_to'] = newsTo;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['rowcount'] = rowcount;
    return data;
  }
}
