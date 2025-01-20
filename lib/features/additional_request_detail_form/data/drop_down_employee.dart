class DropDownEmployee {
  int? result;
  String? message;
  int? statusCode;
  List<Data>? data;
  String? code;
  int? id;

  DropDownEmployee(
      {this.result,
      this.message,
      this.statusCode,
      this.data,
      this.code,
      this.id});

  DropDownEmployee.fromJson(Map<String, dynamic> json) {
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
  String? employeeCode;
  String? employeeName;
  String? nik;
  String? positionCode;
  String? positionDescription;
  String? nikEmployeeNamePositionDescription;

  Data(
      {this.employeeCode,
      this.employeeName,
      this.nik,
      this.positionCode,
      this.positionDescription,
      this.nikEmployeeNamePositionDescription});

  Data.fromJson(Map<String, dynamic> json) {
    employeeCode = json['employee_code'];
    employeeName = json['employee_name'];
    nik = json['nik'];
    positionCode = json['position_code'];
    positionDescription = json['position_description'];
    nikEmployeeNamePositionDescription =
        json['nik_employee_name_position_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_code'] = employeeCode;
    data['employee_name'] = employeeName;
    data['nik'] = nik;
    data['position_code'] = positionCode;
    data['position_description'] = positionDescription;
    data['nik_employee_name_position_description'] =
        nikEmployeeNamePositionDescription;
    return data;
  }
}
