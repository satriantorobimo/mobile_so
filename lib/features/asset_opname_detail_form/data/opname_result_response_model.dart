class OpnameResultResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  OpnameResultResponseModel(
      {this.result, this.message, this.data, this.code, this.id});

  OpnameResultResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? opnameCode;
  String? assetCode;
  String? barcode;
  String? itemCode;
  String? itemName;
  int? usefull;
  String? opnameScale;
  String? opnameResultDate;
  String? conditionCode;
  String? conditionName;
  String? branchCode;
  String? branchName;
  String? locationCode;
  String? locationName;
  String? longitude;
  String? latitude;
  String? picAssetCode;
  String? picAssetName;
  String? picAssetNik;
  String? opnameAssetStatusCode;
  String? opnameAssetStatusName;
  String? opnameByCode;
  String? opnameByName;
  String? opnameRemark;
  List<Document>? document;

  Data(
      {this.opnameCode,
      this.assetCode,
      this.barcode,
      this.itemCode,
      this.itemName,
      this.usefull,
      this.opnameScale,
      this.opnameResultDate,
      this.conditionCode,
      this.conditionName,
      this.branchCode,
      this.branchName,
      this.locationCode,
      this.locationName,
      this.longitude,
      this.latitude,
      this.picAssetCode,
      this.picAssetName,
      this.picAssetNik,
      this.opnameAssetStatusCode,
      this.opnameAssetStatusName,
      this.opnameByCode,
      this.opnameByName,
      this.opnameRemark,
      this.document});

  Data.fromJson(Map<String, dynamic> json) {
    opnameCode = json['opname_code'];
    assetCode = json['asset_code'];
    barcode = json['barcode'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    usefull = json['usefull'];
    opnameScale = json['opname_scale'];
    opnameResultDate = json['opname_result_date'];
    conditionCode = json['condition_code'];
    conditionName = json['condition_name'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    locationCode = json['location_code'];
    locationName = json['location_name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    picAssetCode = json['pic_asset_code'];
    picAssetName = json['pic_asset_name'];
    picAssetNik = json['pic_asset_nik'];
    opnameAssetStatusCode = json['opname_asset_status_code'];
    opnameAssetStatusName = json['opname_asset_status_name'];
    opnameByCode = json['opname_by_code'];
    opnameByName = json['opname_by_name'];
    opnameRemark = json['opname_remark'];
    if (json['document'] != null) {
      document = <Document>[];
      json['document'].forEach((v) {
        document!.add(Document.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['opname_code'] = opnameCode;
    data['asset_code'] = assetCode;
    data['barcode'] = barcode;
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['usefull'] = usefull;
    data['opname_scale'] = opnameScale;
    data['opname_result_date'] = opnameResultDate;
    data['condition_code'] = conditionCode;
    data['condition_name'] = conditionName;
    data['branch_code'] = branchCode;
    data['branch_name'] = branchName;
    data['location_code'] = locationCode;
    data['location_name'] = locationName;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['pic_asset_code'] = picAssetCode;
    data['pic_asset_name'] = picAssetName;
    data['pic_asset_nik'] = picAssetNik;
    data['opname_asset_status_code'] = opnameAssetStatusCode;
    data['opname_asset_status_name'] = opnameAssetStatusName;
    data['opname_by_code'] = opnameByCode;
    data['opname_by_name'] = opnameByName;
    data['opname_remark'] = opnameRemark;
    if (document != null) {
      data['document'] = document!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Document {
  String? fileName;
  String? path;

  Document({this.fileName, this.path});

  Document.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_name'] = fileName;
    data['path'] = path;
    return data;
  }
}
