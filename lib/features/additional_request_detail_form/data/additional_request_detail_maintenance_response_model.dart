class AdditionalRequestDetailMaintenanceResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  AdditionalRequestDetailMaintenanceResponseModel(
      {this.result, this.message, this.data, this.code, this.id});

  AdditionalRequestDetailMaintenanceResponseModel.fromJson(
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
  String? requestType;
  String? assetCode;
  String? assetName;
  String? branchCode;
  String? branchName;
  String? locationCode;
  String? locationName;
  String? maintenanceBy;
  String? serviceCode;
  String? serviceName;
  String? requestorCode;
  String? requestorName;
  String? remarks;
  List<Document>? document;

  Data(
      {this.requestCode,
      this.requestType,
      this.assetCode,
      this.assetName,
      this.branchCode,
      this.branchName,
      this.locationCode,
      this.locationName,
      this.maintenanceBy,
      this.serviceCode,
      this.serviceName,
      this.requestorCode,
      this.requestorName,
      this.remarks,
      this.document});

  Data.fromJson(Map<String, dynamic> json) {
    requestCode = json['request_code'];
    requestType = json['request_type'];
    assetCode = json['asset_code'];
    assetName = json['asset_name'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    locationCode = json['location_code'];
    locationName = json['location_name'];
    maintenanceBy = json['maintenance_by'];
    serviceCode = json['service_code'];
    serviceName = json['service_name'];
    requestorCode = json['requestor_code'];
    requestorName = json['requestor_name'];
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
    data['request_type'] = requestType;
    data['asset_code'] = assetCode;
    data['asset_name'] = assetName;
    data['branch_code'] = branchCode;
    data['branch_name'] = branchName;
    data['location_code'] = locationCode;
    data['location_name'] = locationName;
    data['maintenance_by'] = maintenanceBy;
    data['service_code'] = serviceCode;
    data['service_name'] = serviceName;
    data['requestor_code'] = requestorCode;
    data['requestor_name'] = requestorName;
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
