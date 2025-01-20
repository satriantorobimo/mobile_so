import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';

abstract class ReqChangePasswordState extends Equatable {
  const ReqChangePasswordState();

  @override
  List<Object> get props => [];
}

class ReqChangePasswordInitial extends ReqChangePasswordState {}

class ReqChangePasswordLoading extends ReqChangePasswordState {}

class ReqChangePasswordLoaded extends ReqChangePasswordState {
  const ReqChangePasswordLoaded({required this.changePasswordResponseModel});
  final ChangePasswordResponseModel changePasswordResponseModel;

  @override
  List<Object> get props => [changePasswordResponseModel];
}

class ReqChangePasswordError extends ReqChangePasswordState {
  const ReqChangePasswordError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class ReqChangePasswordException extends ReqChangePasswordState {
  const ReqChangePasswordException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
