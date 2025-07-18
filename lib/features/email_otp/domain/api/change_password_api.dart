import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/email_otp/data/change_password_request_model.dart';
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';
import 'package:mobile_so/utility/url_util.dart';

class ChangePasswordApi {
  ChangePasswordResponseModel changePasswordResponseModel =
      ChangePasswordResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<ChangePasswordResponseModel> attemptReqChangePassword(
      String userName) async {
    List a = [];

    final Map<String, String> header = urlUtil.getHeaderType();

    final Map mapData = {};
    mapData['p_username'] = userName;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlChangePassword()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        changePasswordResponseModel =
            ChangePasswordResponseModel.fromJson(jsonDecode(res.body));
        return changePasswordResponseModel;
      } else {
        changePasswordResponseModel =
            ChangePasswordResponseModel.fromJson(jsonDecode(res.body));
        throw changePasswordResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }

  Future<ChangePasswordResponseModel> attemptChangePassword(
      ChangePasswordRequestModel changePasswordRequestModel) async {
    List a = [];

    final Map<String, String> header = urlUtil.getHeaderType();

    final Map mapData = {};
    mapData['p_username'] = changePasswordRequestModel.username;
    mapData['p_new_password'] = changePasswordRequestModel.password;
    mapData['p_confirm_new_password'] =
        changePasswordRequestModel.confirmPassword;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlConfirmPassword()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        changePasswordResponseModel =
            ChangePasswordResponseModel.fromJson(jsonDecode(res.body));
        return changePasswordResponseModel;
      } else {
        changePasswordResponseModel =
            ChangePasswordResponseModel.fromJson(jsonDecode(res.body));
        throw changePasswordResponseModel.message!;
      }
    } on SocketException {
      throw 'No Internet connection. Make sure it is connected to wifi or data, then try again';
    } catch (ex) {
      throw 'Terjadi Kesalahan Sistem, silahkan coba kembali';
    }
  }
}
