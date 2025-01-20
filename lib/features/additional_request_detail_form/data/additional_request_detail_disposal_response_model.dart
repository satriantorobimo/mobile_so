class AdditionalRequestDetailDisposalResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  AdditionalRequestDetailDisposalResponseModel(
      {this.result, this.message, this.data, this.code, this.id});

  AdditionalRequestDetailDisposalResponseModel.fromJson(
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
  String? requestCode;
  String? assetCode;
  String? assetName;
  String? barcode;
  String? requestType;
  String? status;
  String? requestorCode;
  String? requestorName;
  String? reasonTypeCode;
  String? reasonTypeName;
  int? purchasePrice;
  int? totalDepreComm;
  int? netBookValueComm;
  String? lastAssetStatus;
  String? reffCode;
  String? accessTypeCode;
  String? accessTypeName;
  String? isGrouping;
  String? remarks;
  String? remarks1;
  int? rowcount;
  List<Document>? document;

  Data(
      {this.requestCode,
      this.assetCode,
      this.assetName,
      this.barcode,
      this.requestType,
      this.status,
      this.requestorCode,
      this.requestorName,
      this.reasonTypeCode,
      this.reasonTypeName,
      this.purchasePrice,
      this.totalDepreComm,
      this.netBookValueComm,
      this.lastAssetStatus,
      this.reffCode,
      this.accessTypeCode,
      this.accessTypeName,
      this.isGrouping,
      this.remarks,
      this.remarks1,
      this.rowcount,
      this.document});

  Data.fromJson(Map<String, dynamic> json) {
    requestCode = json['request_code'];
    assetCode = json['asset_code'];
    assetName = json['asset_name'];
    barcode = json['barcode'];
    requestType = json['request_type'];
    status = json['status'];
    requestorCode = json['requestor_code'];
    requestorName = json['requestor_name'];
    reasonTypeCode = json['reason_type_code'];
    reasonTypeName = json['reason_type_name'];
    purchasePrice = json['purchase_price'];
    totalDepreComm = json['total_depre_comm'];
    netBookValueComm = json['net_book_value_comm'];
    lastAssetStatus = json['last_asset_status'];
    reffCode = json['reff_code'];
    accessTypeCode = json['access_type_code'];
    accessTypeName = json['access_type_name'];
    isGrouping = json['is_grouping'];
    remarks = json['remarks'];
    remarks1 = json['remarks1'];
    rowcount = json['rowcount'];
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
    data['status'] = status;
    data['requestor_code'] = requestorCode;
    data['requestor_name'] = requestorName;
    data['reason_type_code'] = reasonTypeCode;
    data['reason_type_name'] = reasonTypeName;
    data['purchase_price'] = purchasePrice;
    data['total_depre_comm'] = totalDepreComm;
    data['net_book_value_comm'] = netBookValueComm;
    data['last_asset_status'] = lastAssetStatus;
    data['reff_code'] = reffCode;
    data['access_type_code'] = accessTypeCode;
    data['access_type_name'] = accessTypeName;
    data['is_grouping'] = isGrouping;
    data['remarks'] = remarks;
    data['remarks1'] = remarks1;
    data['rowcount'] = rowcount;
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
