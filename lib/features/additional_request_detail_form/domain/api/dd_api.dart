import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_employee.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_item_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_tos_mdel.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/url_util.dart';

class DropDownApi {
  DropDownItemModel dropDownItemModel = DropDownItemModel();
  DropDownModel dropDownModel = DropDownModel();
  DropDownEmployee dropDownEmployee = DropDownEmployee();
  DropDownTosModel dropDownTosModel = DropDownTosModel();

  UrlUtil urlUtil = UrlUtil();

  Future<DropDownItemModel> attemptDDItem(String action) async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlDDLItem()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        dropDownItemModel = DropDownItemModel.fromJson(jsonDecode(res.body));
        return dropDownItemModel;
      } else {
        dropDownItemModel = DropDownItemModel.fromJson(jsonDecode(res.body));
        throw dropDownItemModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<DropDownModel> attemptDD(String action) async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlDDLItem()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        dropDownModel = DropDownModel.fromJson(jsonDecode(res.body));
        return dropDownModel;
      } else {
        dropDownModel = DropDownModel.fromJson(jsonDecode(res.body));
        throw dropDownModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<DropDownModel> attemptDDReason(String action) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = action;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlDDLReason()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        dropDownModel = DropDownModel.fromJson(jsonDecode(res.body));
        return dropDownModel;
      } else {
        dropDownModel = DropDownModel.fromJson(jsonDecode(res.body));
        throw dropDownModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<DropDownModel> attemptDDPurchaseCondition(String action) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = action;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(
          Uri.parse(urlUtil.getUrlDDLPurchaseCondition()),
          body: json,
          headers: header);
      if (res.statusCode == 200) {
        dropDownModel = DropDownModel.fromJson(jsonDecode(res.body));
        return dropDownModel;
      } else {
        dropDownModel = DropDownModel.fromJson(jsonDecode(res.body));
        throw dropDownModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<DropDownEmployee> attemptDDEmployee(String action) async {
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
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<DropDownTosModel> attemptDDTos(String assetCode) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_asset_code'] = assetCode;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlDDLTos()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        dropDownTosModel = DropDownTosModel.fromJson(jsonDecode(res.body));
        return dropDownTosModel;
      } else {
        dropDownTosModel = DropDownTosModel.fromJson(jsonDecode(res.body));
        throw dropDownTosModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}
