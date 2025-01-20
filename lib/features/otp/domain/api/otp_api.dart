import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';
import 'package:mobile_so/features/otp/data/otp_validate_request_model.dart';
import 'package:mobile_so/utility/url_util.dart';

class OtpApi {
  ChangePasswordResponseModel changePasswordResponseModel =
      ChangePasswordResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<ChangePasswordResponseModel> attemptValidateOtp(
      OtpValidateRequestModel otpValidateRequestModel) async {
    List a = [];

    final Map<String, String> header = urlUtil.getHeaderType();

    final Map mapData = {};
    mapData['p_username'] = otpValidateRequestModel.username;
    mapData['p_otp_code'] = otpValidateRequestModel.otp;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlValidateOtp()),
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
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<ChangePasswordResponseModel> attemptResendOtp(String userName) async {
    List a = [];

    final Map<String, String> header = urlUtil.getHeaderType();

    final Map mapData = {};
    mapData['p_username'] = userName;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlResendOtp()),
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
    } catch (ex) {
      throw ex.toString();
    }
  }
}
