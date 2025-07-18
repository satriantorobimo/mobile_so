import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_disposal_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_maintenance_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_mutation_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_register_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_sell_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/doc_preview_response_model.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/url_util.dart';

class AdditionalRequestDetailApi {
  AdditionalRequestDetailRegisterResponseModel
      additionalRequestDetailRegisterResponseModel =
      AdditionalRequestDetailRegisterResponseModel();
  AdditionalRequestDetailSellResponseModel
      additionalRequestDetailSellResponseModel =
      AdditionalRequestDetailSellResponseModel();
  AdditionalRequestDetailDisposalResponseModel
      additionalRequestDetailDisposalResponseModel =
      AdditionalRequestDetailDisposalResponseModel();
  AdditionalRequestDetailMaintenanceResponseModel
      additionalRequestDetailMaintenanceResponseModel =
      AdditionalRequestDetailMaintenanceResponseModel();
  AdditionalRequestDetailMutationResponseModel
      additionalRequestDetailMutationResponseModel =
      AdditionalRequestDetailMutationResponseModel();
  DocPreviewResponseModel docPreviewResponseModel = DocPreviewResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<AdditionalRequestDetailRegisterResponseModel> attemptRegisterDetail(
      String pCode) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = pCode;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlAddDetailRegister()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestDetailRegisterResponseModel =
            AdditionalRequestDetailRegisterResponseModel.fromJson(
                jsonDecode(res.body));
        return additionalRequestDetailRegisterResponseModel;
      } else {
        additionalRequestDetailRegisterResponseModel =
            AdditionalRequestDetailRegisterResponseModel.fromJson(
                jsonDecode(res.body));
        throw additionalRequestDetailRegisterResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AdditionalRequestDetailSellResponseModel> attemptSellDetail(
      String pCode) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = pCode;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlAddDetailSell()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestDetailSellResponseModel =
            AdditionalRequestDetailSellResponseModel.fromJson(
                jsonDecode(res.body));
        return additionalRequestDetailSellResponseModel;
      } else {
        additionalRequestDetailSellResponseModel =
            AdditionalRequestDetailSellResponseModel.fromJson(
                jsonDecode(res.body));
        throw additionalRequestDetailSellResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AdditionalRequestDetailDisposalResponseModel> attemptDisposalDetail(
      String pCode) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = pCode;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlAddDetailDisposal()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestDetailDisposalResponseModel =
            AdditionalRequestDetailDisposalResponseModel.fromJson(
                jsonDecode(res.body));
        return additionalRequestDetailDisposalResponseModel;
      } else {
        additionalRequestDetailDisposalResponseModel =
            AdditionalRequestDetailDisposalResponseModel.fromJson(
                jsonDecode(res.body));
        throw additionalRequestDetailDisposalResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AdditionalRequestDetailMaintenanceResponseModel>
      attemptMaintenanceDetail(String pCode) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = pCode;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(
          Uri.parse(urlUtil.getUrlAddDetailMaintenance()),
          body: json,
          headers: header);
      if (res.statusCode == 200) {
        additionalRequestDetailMaintenanceResponseModel =
            AdditionalRequestDetailMaintenanceResponseModel.fromJson(
                jsonDecode(res.body));
        return additionalRequestDetailMaintenanceResponseModel;
      } else {
        additionalRequestDetailMaintenanceResponseModel =
            AdditionalRequestDetailMaintenanceResponseModel.fromJson(
                jsonDecode(res.body));
        throw additionalRequestDetailMaintenanceResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<AdditionalRequestDetailMutationResponseModel> attemptMutationDetail(
      String pCode) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_code'] = pCode;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlAddDetailMutation()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        additionalRequestDetailMutationResponseModel =
            AdditionalRequestDetailMutationResponseModel.fromJson(
                jsonDecode(res.body));
        return additionalRequestDetailMutationResponseModel;
      } else {
        additionalRequestDetailMutationResponseModel =
            AdditionalRequestDetailMutationResponseModel.fromJson(
                jsonDecode(res.body));
        throw additionalRequestDetailMutationResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<DocPreviewResponseModel> attemptDocPreview(
      String pFileName, String pFilePaths) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? uid = await SharedPrefUtil.getSharedString('uid');
    String reversedString = uid!.split('').reversed.join('');
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(reversedString);
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, encoded);

    final Map mapData = {};
    mapData['p_file_name'] = pFileName;
    mapData['p_file_paths'] = pFilePaths;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlDocPreview()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        docPreviewResponseModel =
            DocPreviewResponseModel.fromJson(jsonDecode(res.body));
        return docPreviewResponseModel;
      } else {
        docPreviewResponseModel =
            DocPreviewResponseModel.fromJson(jsonDecode(res.body));
        throw docPreviewResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }
}
