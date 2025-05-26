class SpeedResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  SpeedResponseModel(
      {this.result, this.message, this.data, this.code, this.id});

  SpeedResponseModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Data {
  String? employeeCode;
  int? jumlahAssetPerHari;
  String? opnameSpeedTypeCode;
  String? opnameSpeedTypeName;
  String? fileName;
  String? base64;

  Data(
      {this.employeeCode,
      this.jumlahAssetPerHari,
      this.opnameSpeedTypeCode,
      this.opnameSpeedTypeName,
      this.fileName,
      this.base64});

  Data.fromJson(Map<String, dynamic> json) {
    employeeCode = json['employee_code'];
    jumlahAssetPerHari = json['jumlah_asset_per_hari'];
    opnameSpeedTypeCode = json['opname_speed_type_code'];
    opnameSpeedTypeName = json['opname_speed_type_name'];
    fileName = json['file_name'];
    base64 = json['base64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_code'] = employeeCode;
    data['jumlah_asset_per_hari'] = jumlahAssetPerHari;
    data['opname_speed_type_code'] = opnameSpeedTypeCode;
    data['opname_speed_type_name'] = opnameSpeedTypeName;
    data['file_name'] = fileName;
    data['base64'] = base64;
    return data;
  }
}
