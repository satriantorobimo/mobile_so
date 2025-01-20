class DropDownItemModel {
  int? result;
  String? message;
  int? statusCode;
  List<Data>? data;
  String? code;
  int? id;

  DropDownItemModel(
      {this.result,
      this.message,
      this.statusCode,
      this.data,
      this.code,
      this.id});

  DropDownItemModel.fromJson(Map<String, dynamic> json) {
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
  String? itemCode;
  String? itemName;
  String? itemGroupCode;
  String? itemGroupName;

  Data({this.itemCode, this.itemName, this.itemGroupCode, this.itemGroupName});

  Data.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemGroupCode = json['item_group_code'];
    itemGroupName = json['item_group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['item_group_code'] = itemGroupCode;
    data['item_group_name'] = itemGroupName;
    return data;
  }
}
