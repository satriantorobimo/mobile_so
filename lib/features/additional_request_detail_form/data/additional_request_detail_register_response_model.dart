class AdditionalRequestDetailRegisterResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  AdditionalRequestDetailRegisterResponseModel(
      {this.result, this.message, this.data, this.code, this.id});

  AdditionalRequestDetailRegisterResponseModel.fromJson(
      Map<String, dynamic> json) {
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
  String? assetRegisterCode;
  String? itemCode;
  String? itemName;
  String? purchaseCondition;
  String? picCode;
  String? picName;
  String? remarks;
  List<Document>? document;

  Data(
      {this.assetRegisterCode,
      this.itemCode,
      this.itemName,
      this.purchaseCondition,
      this.picCode,
      this.picName,
      this.remarks,
      this.document});

  Data.fromJson(Map<String, dynamic> json) {
    assetRegisterCode = json['asset_register_code'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    purchaseCondition = json['purchase_condition'];
    picCode = json['pic_code'];
    picName = json['pic_name'];
    remarks = json['remarks'];
    if (json['document'] != null) {
      document = <Document>[];
      json['document'].forEach((v) {
        document!.add(Document.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['asset_register_code'] = assetRegisterCode;
    data['item_code'] = itemCode;
    data['item_name'] = itemName;
    data['purchase_condition'] = purchaseCondition;
    data['pic_code'] = picCode;
    data['pic_name'] = picName;
    data['remarks'] = remarks;
    if (document != null) {
      data['document'] = document!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Document {
  String? documentCode;
  String? description;
  String? fileName;
  String? path;
  String? uploadDate;

  Document(
      {this.documentCode,
      this.description,
      this.fileName,
      this.path,
      this.uploadDate});

  Document.fromJson(Map<String, dynamic> json) {
    documentCode = json['document_code'];
    description = json['description'];
    fileName = json['file_name'];
    path = json['path'];
    uploadDate = json['upload_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['document_code'] = documentCode;
    data['description'] = description;
    data['file_name'] = fileName;
    data['path'] = path;
    data['upload_date'] = uploadDate;
    return data;
  }
}
