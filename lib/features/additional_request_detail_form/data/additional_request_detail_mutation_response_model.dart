class AdditionalRequestDetailMutationResponseModel {
  int? result;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  AdditionalRequestDetailMutationResponseModel(
      {this.result, this.message, this.data, this.code, this.id});

  AdditionalRequestDetailMutationResponseModel.fromJson(
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
  String? fromRegionCode;
  String? fromRegionName;
  String? fromAreaCode;
  String? fromAreaName;
  String? fromBranchCode;
  String? fromBranchName;
  String? fromLocationCode;
  String? fromLocationName;
  String? fromDivisionCode;
  String? fromDivisionName;
  String? fromDepartmentCode;
  String? fromDepartmentName;
  String? fromSubDepartmentCode;
  String? fromSubDepartmentName;
  String? fromUnitCode;
  String? fromUnitName;
  String? toRegionCode;
  String? toRegionName;
  String? toAreaCode;
  String? toAreaName;
  String? toBranchCode;
  String? toBranchName;
  String? toLocationCode;
  String? toLocationName;
  String? toDivisionCode;
  String? toDivisionName;
  String? toDepartmentCode;
  String? toDepartmentName;
  String? toSubDepartmentCode;
  String? toSubDepartmentName;
  String? toUnitCode;
  String? toUnitName;
  String? toPicCode;
  String? toPicName;
  String? barcode1;
  String? lastAssetStatus;
  String? reffCode;
  String? accessTypeCode;
  String? accessTypeName;
  String? isGrouping;
  String? remarks;
  int? jumlah;
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
      this.fromRegionCode,
      this.fromRegionName,
      this.fromAreaCode,
      this.fromAreaName,
      this.fromBranchCode,
      this.fromBranchName,
      this.fromLocationCode,
      this.fromLocationName,
      this.fromDivisionCode,
      this.fromDivisionName,
      this.fromDepartmentCode,
      this.fromDepartmentName,
      this.fromSubDepartmentCode,
      this.fromSubDepartmentName,
      this.fromUnitCode,
      this.fromUnitName,
      this.toRegionCode,
      this.toRegionName,
      this.toAreaCode,
      this.toAreaName,
      this.toBranchCode,
      this.toBranchName,
      this.toLocationCode,
      this.toLocationName,
      this.toDivisionCode,
      this.toDivisionName,
      this.toDepartmentCode,
      this.toDepartmentName,
      this.toSubDepartmentCode,
      this.toSubDepartmentName,
      this.toUnitCode,
      this.toUnitName,
      this.toPicCode,
      this.toPicName,
      this.barcode1,
      this.lastAssetStatus,
      this.reffCode,
      this.accessTypeCode,
      this.accessTypeName,
      this.isGrouping,
      this.remarks,
      this.jumlah,
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
    fromRegionCode = json['from_region_code'];
    fromRegionName = json['from_region_name'];
    fromAreaCode = json['from_area_code'];
    fromAreaName = json['from_area_name'];
    fromBranchCode = json['from_branch_code'];
    fromBranchName = json['from_branch_name'];
    fromLocationCode = json['from_location_code'];
    fromLocationName = json['from_location_name'];
    fromDivisionCode = json['from_division_code'];
    fromDivisionName = json['from_division_name'];
    fromDepartmentCode = json['from_department_code'];
    fromDepartmentName = json['from_department_name'];
    fromSubDepartmentCode = json['from_sub_department_code'];
    fromSubDepartmentName = json['from_sub_department_name'];
    fromUnitCode = json['from_unit_code'];
    fromUnitName = json['from_unit_name'];
    toRegionCode = json['to_region_code'];
    toRegionName = json['to_region_name'];
    toAreaCode = json['to_area_code'];
    toAreaName = json['to_area_name'];
    toBranchCode = json['to_branch_code'];
    toBranchName = json['to_branch_name'];
    toLocationCode = json['to_location_code'];
    toLocationName = json['to_location_name'];
    toDivisionCode = json['to_division_code'];
    toDivisionName = json['to_division_name'];
    toDepartmentCode = json['to_department_code'];
    toDepartmentName = json['to_department_name'];
    toSubDepartmentCode = json['to_sub_department_code'];
    toSubDepartmentName = json['to_sub_department_name'];
    toUnitCode = json['to_unit_code'];
    toUnitName = json['to_unit_name'];
    toPicCode = json['to_pic_code'];
    toPicName = json['to_pic_name'];
    barcode1 = json['barcode1'];
    lastAssetStatus = json['last_asset_status'];
    reffCode = json['reff_code'];
    accessTypeCode = json['access_type_code'];
    accessTypeName = json['access_type_name'];
    isGrouping = json['is_grouping'];
    remarks = json['remarks'];
    jumlah = json['jumlah'];
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
    data['from_region_code'] = fromRegionCode;
    data['from_region_name'] = fromRegionName;
    data['from_area_code'] = fromAreaCode;
    data['from_area_name'] = fromAreaName;
    data['from_branch_code'] = fromBranchCode;
    data['from_branch_name'] = fromBranchName;
    data['from_location_code'] = fromLocationCode;
    data['from_location_name'] = fromLocationName;
    data['from_division_code'] = fromDivisionCode;
    data['from_division_name'] = fromDivisionName;
    data['from_department_code'] = fromDepartmentCode;
    data['from_department_name'] = fromDepartmentName;
    data['from_sub_department_code'] = fromSubDepartmentCode;
    data['from_sub_department_name'] = fromSubDepartmentName;
    data['from_unit_code'] = fromUnitCode;
    data['from_unit_name'] = fromUnitName;
    data['to_region_code'] = toRegionCode;
    data['to_region_name'] = toRegionName;
    data['to_area_code'] = toAreaCode;
    data['to_area_name'] = toAreaName;
    data['to_branch_code'] = toBranchCode;
    data['to_branch_name'] = toBranchName;
    data['to_location_code'] = toLocationCode;
    data['to_location_name'] = toLocationName;
    data['to_division_code'] = toDivisionCode;
    data['to_division_name'] = toDivisionName;
    data['to_department_code'] = toDepartmentCode;
    data['to_department_name'] = toDepartmentName;
    data['to_sub_department_code'] = toSubDepartmentCode;
    data['to_sub_department_name'] = toSubDepartmentName;
    data['to_unit_code'] = toUnitCode;
    data['to_unit_name'] = toUnitName;
    data['to_pic_code'] = toPicCode;
    data['to_pic_name'] = toPicName;
    data['barcode1'] = barcode1;
    data['last_asset_status'] = lastAssetStatus;
    data['reff_code'] = reffCode;
    data['access_type_code'] = accessTypeCode;
    data['access_type_name'] = accessTypeName;
    data['is_grouping'] = isGrouping;
    data['remarks'] = remarks;
    data['jumlah'] = jumlah;
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
