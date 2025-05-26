class AssetOpnameListResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;
  int? recordstotal;

  AssetOpnameListResponseModel(
      {this.result,
      this.message,
      this.data,
      this.code,
      this.id,
      this.recordstotal});

  AssetOpnameListResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? opnameStartDate;
  String? opnameEndDate;
  var totalAsset;
  var percentageOpname;

  Data(
      {this.code,
      this.opnameStartDate,
      this.opnameEndDate,
      this.totalAsset,
      this.percentageOpname});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    opnameStartDate = json['opname_start_date'];
    opnameEndDate = json['opname_end_date'];
    totalAsset = json['total_asset'];
    percentageOpname = json['percentage_opname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['opname_start_date'] = opnameStartDate;
    data['opname_end_date'] = opnameEndDate;
    data['total_asset'] = totalAsset;
    data['percentage_opname'] = percentageOpname;
    return data;
  }
}
