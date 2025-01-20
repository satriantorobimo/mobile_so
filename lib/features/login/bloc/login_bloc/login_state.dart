import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  const LoginLoaded({required this.generalResponseModel});
  final GeneralResponseModel generalResponseModel;

  @override
  List<Object> get props => [generalResponseModel];
}

class LoginError extends LoginState {
  const LoginError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class LoginException extends LoginState {
  const LoginException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
