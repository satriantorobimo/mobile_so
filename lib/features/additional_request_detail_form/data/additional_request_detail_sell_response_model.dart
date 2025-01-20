class AdditionalRequestDetailSellResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  AdditionalRequestDetailSellResponseModel(
      {this.result, this.message, this.data, this.code, this.id});

  AdditionalRequestDetailSellResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? requestCode;
  String? assetCode;
  String? assetName;
  String? barcode;
  String? requestType;
  String? reasonCode;
  String? reasonName;
  String? status;
  String? requestorCode;
  String? requestorName;
  var totalDepreComm;
  var netBookValueComm;
  var totalDepreFiscal;
  var netBookValueFiscal;
  var sellingPrice;
  String? remarks;
  List<Document>? document;

  Data(
      {this.requestCode,
      this.assetCode,
      this.assetName,
      this.barcode,
      this.requestType,
      this.reasonCode,
      this.reasonName,
      this.status,
      this.requestorCode,
      this.requestorName,
      this.totalDepreComm,
      this.netBookValueComm,
      this.totalDepreFiscal,
      this.netBookValueFiscal,
      this.sellingPrice,
      this.remarks,
      this.document});

  Data.fromJson(Map<String, dynamic> json) {
    requestCode = json['request_code'];
    assetCode = json['asset_code'];
    assetName = json['asset_name'];
    barcode = json['barcode'];
    requestType = json['request_type'];
    reasonCode = json['reason_code'];
    reasonName = json['reason_name'];
    status = json['status'];
    requestorCode = json['requestor_code'];
    requestorName = json['requestor_name'];
    totalDepreComm = json['total_depre_comm'];
    netBookValueComm = json['net_book_value_comm'];
    totalDepreFiscal = json['total_depre_fiscal'];
    netBookValueFiscal = json['net_book_value_fiscal'];
    sellingPrice = json['selling_price'];
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
    data['request_code'] = requestCode;
    data['asset_code'] = assetCode;
    data['asset_name'] = assetName;
    data['barcode'] = barcode;
    data['request_type'] = requestType;
    data['reason_code'] = reasonCode;
    data['reason_name'] = reasonName;
    data['status'] = status;
    data['requestor_code'] = requestorCode;
    data['requestor_name'] = requestorName;
    data['total_depre_comm'] = totalDepreComm;
    data['net_book_value_comm'] = netBookValueComm;
    data['total_depre_fiscal'] = totalDepreFiscal;
    data['net_book_value_fiscal'] = netBookValueFiscal;
    data['selling_price'] = sellingPrice;
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
