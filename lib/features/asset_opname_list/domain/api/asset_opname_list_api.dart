import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_list_detail_response_model.dart';
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_list_response_model.dart';
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_schedule_response_model.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/url_util.dart';

class AssetOpnameListApi {
  AssetOpnameListResponseModel assetOpnameListResponseModel =
      AssetOpnameListResponseModel();
  AssetOpnameListDetailResponseModel assetOpnameListDetailResponseModel =
      AssetOpnameListDetailResponseModel();
  AssetOpnameScheduleResponseModel assetOpnameScheduleResponseModel =
      AssetOpnameScheduleResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<AssetOpnameListResponseModel> attemptAssetOpnameList() async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlAssetOpnameList()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        assetOpnameListResponseModel =
            AssetOpnameListResponseModel.fromJson(jsonDecode(res.body));
        return assetOpnameListResponseModel;
      } else {
        assetOpnameListResponseModel =
            AssetOpnameListResponseModel.fromJson(jsonDecode(res.body));
        throw assetOpnameListResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AssetOpnameListDetailResponseModel> attemptAssetOpnameListDetail(
      String code) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_opname_code'] = code;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(
          Uri.parse(urlUtil.getUrlAssetOpnameListDetail()),
          body: json,
          headers: header);
      if (res.statusCode == 200) {
        assetOpnameListDetailResponseModel =
            AssetOpnameListDetailResponseModel.fromJson(jsonDecode(res.body));
        return assetOpnameListDetailResponseModel;
      } else {
        assetOpnameListDetailResponseModel =
            AssetOpnameListDetailResponseModel.fromJson(jsonDecode(res.body));
        throw assetOpnameListDetailResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AssetOpnameListDetailResponseModel> attemptCalendarOpnameResult(
      String code, String date) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_opname_code'] = code;
    mapData['p_date'] = GeneralUtil.dateConvert(date);
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(
          Uri.parse(urlUtil.getUrlCalendarOpnameResult()),
          body: json,
          headers: header);
      if (res.statusCode == 200) {
        assetOpnameListDetailResponseModel =
            AssetOpnameListDetailResponseModel.fromJson(jsonDecode(res.body));
        return assetOpnameListDetailResponseModel;
      } else {
        assetOpnameListDetailResponseModel =
            AssetOpnameListDetailResponseModel.fromJson(jsonDecode(res.body));
        throw assetOpnameListDetailResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AssetOpnameScheduleResponseModel> attemptAssetOpnameSchedule(
      String code) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = code;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(
          Uri.parse(urlUtil.getUrlAssetOpnameSchedule()),
          body: json,
          headers: header);
      if (res.statusCode == 200) {
        assetOpnameScheduleResponseModel =
            AssetOpnameScheduleResponseModel.fromJson(jsonDecode(res.body));
        return assetOpnameScheduleResponseModel;
      } else {
        assetOpnameScheduleResponseModel =
            AssetOpnameScheduleResponseModel.fromJson(jsonDecode(res.body));
        throw assetOpnameScheduleResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }
}
