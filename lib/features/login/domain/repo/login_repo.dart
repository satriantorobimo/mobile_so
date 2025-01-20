import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';
import 'package:mobile_so/features/login/data/login_request_model.dart';
import 'package:mobile_so/features/login/domain/api/login_api.dart';

class LoginRepo {
  final LoginApi loginApi = LoginApi();

  Future<GeneralResponseModel?> attemptLogin(
          LoginRequestModel loginRequestModel) =>
      loginApi.attemptLogin(loginRequestModel);
}
