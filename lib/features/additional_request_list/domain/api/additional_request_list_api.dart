import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/additional_request_list/data/additional_request_list_response_model.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/url_util.dart';

class AdditionalRequestListApi {
  AdditionalRequestListResponseModel additionalRequestListResponseModel =
      AdditionalRequestListResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<AdditionalRequestListResponseModel> attemptAdditionalRegister() async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlAddResgisterList()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        return additionalRequestListResponseModel;
      } else {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        throw additionalRequestListResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AdditionalRequestListResponseModel> attemptAdditionalSell() async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlAddSellList()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        return additionalRequestListResponseModel;
      } else {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        throw additionalRequestListResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AdditionalRequestListResponseModel> attemptAdditionalDisposal() async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlAddDisposalList()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        return additionalRequestListResponseModel;
      } else {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        throw additionalRequestListResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AdditionalRequestListResponseModel>
      attemptAdditionalMaintenance() async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlAddMaintenanceList()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        return additionalRequestListResponseModel;
      } else {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        throw additionalRequestListResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AdditionalRequestListResponseModel> attemptAdditionalMutation() async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlAddMutationList()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        return additionalRequestListResponseModel;
      } else {
        additionalRequestListResponseModel =
            AdditionalRequestListResponseModel.fromJson(jsonDecode(res.body));
        throw additionalRequestListResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }
}
