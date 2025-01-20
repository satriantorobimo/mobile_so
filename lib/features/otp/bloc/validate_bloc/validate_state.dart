import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';

abstract class ValidateOtpState extends Equatable {
  const ValidateOtpState();

  @override
  List<Object> get props => [];
}

class ValidateOtpInitial extends ValidateOtpState {}

class ValidateOtpLoading extends ValidateOtpState {}

class ValidateOtpLoaded extends ValidateOtpState {
  const ValidateOtpLoaded({required this.changePasswordResponseModel});
  final ChangePasswordResponseModel changePasswordResponseModel;

  @override
  List<Object> get props => [changePasswordResponseModel];
}

class ValidateOtpError extends ValidateOtpState {
  const ValidateOtpError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class ValidateOtpException extends ValidateOtpState {
  const ValidateOtpException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
