import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_employee.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/upload_doc_request_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/arguments_view_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_location_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_status_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/opname_result_response_model.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/submit_opname_request_model.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/url_util.dart';

class OpnameSubmitApi {
  DdlLocationResponseModel ddlLocationResponseModel =
      DdlLocationResponseModel();
  DropDownModel dropDownModel = DropDownModel();
  DdlStatusResponseModel ddlStatusResponseModel = DdlStatusResponseModel();
  DropDownEmployee dropDownEmployee = DropDownEmployee();
  GeneralResponseModel generalResponseModel = GeneralResponseModel();
  OpnameResultResponseModel opnameResultResponseModel =
      OpnameResultResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<OpnameResultResponseModel> attemptOpnameResult(
      ArgumentsViewModel argumentViewModel) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_opname_code'] = argumentViewModel.opnameCode;
    mapData['p_asset_code'] = argumentViewModel.assetCode;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlOpnameResult()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        opnameResultResponseModel =
            OpnameResultResponseModel.fromJson(jsonDecode(res.body));
        return opnameResultResponseModel;
      } else {
        opnameResultResponseModel =
            OpnameResultResponseModel.fromJson(jsonDecode(res.body));
        throw opnameResultResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<DdlLocationResponseModel> attemptDdlLocation() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['action'] = 'default';
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlDDLocation()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        ddlLocationResponseModel =
            DdlLocationResponseModel.fromJson(jsonDecode(res.body));
        return ddlLocationResponseModel;
      } else {
        ddlLocationResponseModel =
            DdlLocationResponseModel.fromJson(jsonDecode(res.body));
        throw ddlLocationResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<DropDownModel> attemptDdlCondition() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = 'M0001328';
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlDDCondition()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        dropDownModel = DropDownModel.fromJson(jsonDecode(res.body));
        return dropDownModel;
      } else {
        dropDownModel = DropDownModel.fromJson(jsonDecode(res.body));
        throw dropDownModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<DdlStatusResponseModel> attemptDdlStatus() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_transaction_code'] = 'MTR.2409.000001';
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlDDStatus()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        ddlStatusResponseModel =
            DdlStatusResponseModel.fromJson(jsonDecode(res.body));
        return ddlStatusResponseModel;
      } else {
        ddlStatusResponseModel =
            DdlStatusResponseModel.fromJson(jsonDecode(res.body));
        throw ddlStatusResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<DropDownEmployee> attemptDdlEmployee(String action) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['action'] = action;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlDDLEmployee()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        dropDownEmployee = DropDownEmployee.fromJson(jsonDecode(res.body));
        return dropDownEmployee;
      } else {
        dropDownEmployee = DropDownEmployee.fromJson(jsonDecode(res.body));
        throw dropDownEmployee.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<GeneralResponseModel> attemptSubmit(
      SubmitOpnameRequestModel submitOpnameRequestModel) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_opname_code'] = submitOpnameRequestModel.pOpnameCode;
    mapData['p_asset_code'] = submitOpnameRequestModel.pAssetCode;
    mapData['p_condition_code'] = submitOpnameRequestModel.pConditionCode;
    mapData['p_asset_status_code'] = submitOpnameRequestModel.pAssetStatusCode;
    mapData['p_pic_code'] = submitOpnameRequestModel.pPicCode;
    mapData['p_location_code'] = submitOpnameRequestModel.pLocationCode;
    mapData['p_remark'] = submitOpnameRequestModel.pRemark;

    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlSubmitOpname()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        generalResponseModel =
            GeneralResponseModel.fromJson(jsonDecode(res.body));
        return generalResponseModel;
      } else {
        generalResponseModel =
            GeneralResponseModel.fromJson(jsonDecode(res.body));
        throw generalResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<GeneralResponseModel> attemptUpload(
      UploadDocRequestModel uploadDocRequestModel, String opnameCode) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);
    File file = File(uploadDocRequestModel.filePath!);
    Uint8List bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    final Map mapData = {};
    mapData['p_opname_code'] = opnameCode;
    mapData['p_asset_code'] = uploadDocRequestModel.pAssetRegisterCode;
    mapData['p_file_name'] = uploadDocRequestModel.pFileName;
    mapData['p_base64'] = base64Image;

    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlUploadDocOpname()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        generalResponseModel =
            GeneralResponseModel.fromJson(jsonDecode(res.body));
        return generalResponseModel;
      } else {
        generalResponseModel =
            GeneralResponseModel.fromJson(jsonDecode(res.body));
        throw generalResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }
}
