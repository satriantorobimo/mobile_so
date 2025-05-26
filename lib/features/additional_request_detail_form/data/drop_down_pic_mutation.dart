class DropDownPicMutation {
  int? result;
  String? message;
  int? statusCode;
  List<Data>? data;
  String? code;
  int? id;

  DropDownPicMutation(
      {this.result,
      this.message,
      this.statusCode,
      this.data,
      this.code,
      this.id});

  DropDownPicMutation.fromJson(Map<String, dynamic> json) {
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
  String? regionCode;
  String? regionName;
  String? areaCode;
  String? areaName;
  String? branchCode;
  String? branchName;
  String? locationCode;
  String? locationName;
  String? departmentCode;
  String? departmentName;
  String? subDepartmentCode;
  String? subDepartmentName;
  String? unitCode;
  String? unitName;
  String? divisionCode;
  String? divisionName;

  Data(
      {this.employeeCode,
      this.employeeName,
      this.nik,
      this.regionCode,
      this.regionName,
      this.areaCode,
      this.areaName,
      this.branchCode,
      this.branchName,
      this.locationCode,
      this.locationName,
      this.departmentCode,
      this.departmentName,
      this.subDepartmentCode,
      this.subDepartmentName,
      this.unitCode,
      this.unitName,
      this.divisionCode,
      this.divisionName});

  Data.fromJson(Map<String, dynamic> json) {
    employeeCode = json['employee_code'];
    employeeName = json['employee_name'];
    nik = json['nik'];
    regionCode = json['region_code'];
    regionName = json['region_name'];
    areaCode = json['area_code'];
    areaName = json['area_name'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    locationCode = json['location_code'];
    locationName = json['location_name'];
    departmentCode = json['department_code'];
    departmentName = json['department_name'];
    subDepartmentCode = json['sub_department_code'];
    subDepartmentName = json['sub_department_name'];
    unitCode = json['unit_code'];
    unitName = json['unit_name'];
    divisionCode = json['division_code'];
    divisionName = json['division_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_code'] = employeeCode;
    data['employee_name'] = employeeName;
    data['nik'] = nik;
    data['region_code'] = regionCode;
    data['region_name'] = regionName;
    data['area_code'] = areaCode;
    data['area_name'] = areaName;
    data['branch_code'] = branchCode;
    data['branch_name'] = branchName;
    data['location_code'] = locationCode;
    data['location_name'] = locationName;
    data['department_code'] = departmentCode;
    data['department_name'] = departmentName;
    data['sub_department_code'] = subDepartmentCode;
    data['sub_department_name'] = subDepartmentName;
    data['unit_code'] = unitCode;
    data['unit_name'] = unitName;
    data['division_code'] = divisionCode;
    data['division_name'] = divisionName;
    return data;
  }
}
