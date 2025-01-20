import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/otp/data/otp_validate_request_model.dart';

abstract class ValidateOtpEvent extends Equatable {
  const ValidateOtpEvent();
}

class ValidateOtpAttempt extends ValidateOtpEvent {
  const ValidateOtpAttempt({required this.otpValidateRequestModel});
  final OtpValidateRequestModel otpValidateRequestModel;

  @override
  List<Object> get props => [otpValidateRequestModel];
}
