import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

abstract class ResendOtpState extends Equatable {
  const ResendOtpState();

  @override
  List<Object> get props => [];
}

class ResendOtpInitial extends ResendOtpState {}

class ResendOtpLoading extends ResendOtpState {}

class ResendOtpLoaded extends ResendOtpState {
  const ResendOtpLoaded({required this.generalResponseModel});
  final GeneralResponseModel generalResponseModel;

  @override
  List<Object> get props => [generalResponseModel];
}

class ResendOtpError extends ResendOtpState {
  const ResendOtpError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class ResendOtpException extends ResendOtpState {
  const ResendOtpException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
