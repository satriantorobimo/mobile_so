import 'package:mobile_so/features/email_otp/data/change_password_request_model.dart';
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';
import 'package:mobile_so/features/email_otp/domain/api/change_password_api.dart';

class ChangePasswordRepo {
  final ChangePasswordApi changePasswordApi = ChangePasswordApi();

  Future<ChangePasswordResponseModel?> attemptReqChangePassword(
          String userName) =>
      changePasswordApi.attemptReqChangePassword(userName);

  Future<ChangePasswordResponseModel?> attemptChangePassword(
          ChangePasswordRequestModel changePasswordRequestModel) =>
      changePasswordApi.attemptChangePassword(changePasswordRequestModel);
}
