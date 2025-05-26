import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';
import 'package:mobile_so/features/login/data/login_request_model.dart';
import 'package:mobile_so/utility/url_util.dart';

class LoginApi {
  GeneralResponseModel generalResponseModel = GeneralResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<GeneralResponseModel> attemptLogin(
      LoginRequestModel loginRequestModel) async {
    final Map<String, String> header = urlUtil.getHeaderTypeForm();

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlLogin()),
          body: {
            'username': loginRequestModel.username,
            'password': loginRequestModel.password,
          },
          headers: header);
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
      throw ex.toString();
    }
  }
}
