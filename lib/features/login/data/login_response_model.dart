class LoginResponseModel {
  int? status;
  String? token;
  String? message;
  List<Datalist>? datalist;

  LoginResponseModel({this.status, this.token, this.message, this.datalist});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    message = json['message'];
    if (json['datalist'] != null) {
      datalist = <Datalist>[];
      json['datalist'].forEach((v) {
        datalist!.add(Datalist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    data['message'] = message;
    if (datalist != null) {
      data['datalist'] = datalist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datalist {
  String? uid;
  String? username;
  String? name;
  String? systemDate;
  String? companyCode;
  String? officeCode;
  String? idleTime;

  Datalist(
      {this.uid,
      this.username,
      this.name,
      this.systemDate,
      this.companyCode,
      this.officeCode,
      this.idleTime});

  Datalist.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    name = json['name'];
    systemDate = json['system_date'];
    companyCode = json['company_code'];
    officeCode = json['office_code'];
    idleTime = json['idle_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['name'] = name;
    data['system_date'] = systemDate;
    data['company_code'] = companyCode;
    data['office_code'] = officeCode;
    data['idle_time'] = idleTime;
    return data;
  }
}
