class AdditionalRequestListResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;
  int? recordstotal;

  AdditionalRequestListResponseModel(
      {this.result,
      this.message,
      this.data,
      this.code,
      this.id,
      this.recordstotal});

  AdditionalRequestListResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? requestCode;
  String? assetName;
  String? assetCode;
  String? itemCode;
  String? itemName;
  String? requestType;
  String? status;
  String? requestDate;

  Data(
      {this.requestCode,
      this.assetCode,
      this.itemCode,
      this.itemName,
      this.requestType,
      this.status,
      this.assetName,
      this.requestDate});

  Data.fromJson(Map<String, dynamic> json) {
    requestCode = json['request_code'];
    assetCode = json['asset_code'];
    itemCode = json['item_code'];
    assetName = json['asset_name'];
    itemName = json['item_name'];
    requestType = json['request_type'];
    status = json['status'];
    requestDate = json['request_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_code'] = requestCode;
    data['asset_code'] = assetCode;
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['request_type'] = requestType;
    data['status'] = status;
    data['request_date'] = requestDate;
    return data;
  }
}
