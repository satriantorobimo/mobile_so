import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';
import 'package:mobile_so/features/otp/data/otp_validate_request_model.dart';
import 'package:mobile_so/features/otp/domain/api/otp_api.dart';

class OtpRepo {
  final OtpApi otpApi = OtpApi();

  Future<ChangePasswordResponseModel?> attemptValidateOtp(
          OtpValidateRequestModel otpValidateRequestModel) =>
      otpApi.attemptValidateOtp(otpValidateRequestModel);

  Future<ChangePasswordResponseModel?> attemptResendOtp(String userName) =>
      otpApi.attemptResendOtp(userName);
}
