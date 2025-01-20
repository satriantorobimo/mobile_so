import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/login/data/login_response_model.dart';

abstract class ValidateOtpState extends Equatable {
  const ValidateOtpState();

  @override
  List<Object> get props => [];
}

class ValidateOtpInitial extends ValidateOtpState {}

class ValidateOtpLoading extends ValidateOtpState {}

class ValidateOtpLoaded extends ValidateOtpState {
  const ValidateOtpLoaded({required this.loginResponseModel});
  final LoginResponseModel loginResponseModel;

  @override
  List<Object> get props => [loginResponseModel];
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
