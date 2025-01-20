class DdlLocationResponseModel {
  int? result;
  String? message;
  int? statusCode;
  List<Data>? data;
  String? code;
  int? id;

  DdlLocationResponseModel(
      {this.result,
        this.message,
        this.statusCode,
        this.data,
        this.code,
        this.id});

  DdlLocationResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    statusCode = json['StatusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  String? branchCode;
  String? branchName;
  String? locationCode;
  String? locationName;
  String? branchLocationName;
  String? longitude;
  String? latitude;

  Data(
      {this.branchCode,
        this.branchName,
        this.locationCode,
        this.locationName,
        this.branchLocationName,
        this.longitude,
        this.latitude});

  Data.fromJson(Map<String, dynamic> json) {
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    locationCode = json['location_code'];
    locationName = json['location_name'];
    branchLocationName = json['branch_location_name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branch_code'] = branchCode;
    data['branch_name'] = branchName;
    data['location_code'] = locationCode;
    data['location_name'] = locationName;
    data['branch_location_name'] = branchLocationName;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
