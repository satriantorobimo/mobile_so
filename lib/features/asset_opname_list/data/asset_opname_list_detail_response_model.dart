class AssetOpnameListDetailResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;
  int? recordstotal;

  AssetOpnameListDetailResponseModel(
      {this.result,
      this.message,
      this.data,
      this.code,
      this.id,
      this.recordstotal});

  AssetOpnameListDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? opnameCode;
  String? assetCode;
  String? assetName;
  String? assetDescription;
  String? assetLocation;
  String? status;
  String? resultDate;

  Data(
      {this.opnameCode,
      this.assetCode,
      this.assetName,
      this.assetDescription,
      this.assetLocation,
      this.status,
      this.resultDate});

  Data.fromJson(Map<String, dynamic> json) {
    opnameCode = json['opname_code'];
    assetCode = json['asset_code'];
    assetName = json['asset_name'];
    assetDescription = json['asset_description'];
    assetLocation = json['asset_location'];
    status = json['status'];
    resultDate = json['result_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['opname_code'] = opnameCode;
    data['asset_code'] = assetCode;
    data['asset_name'] = assetName;
    data['asset_description'] = assetDescription;
    data['asset_location'] = assetLocation;
    data['status'] = status;
    data['result_date'] = resultDate;
    return data;
  }
}
