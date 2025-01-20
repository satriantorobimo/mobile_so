import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/email_otp/data/change_password_response_model.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordLoaded extends ChangePasswordState {
  const ChangePasswordLoaded({required this.changePasswordResponseModel});
  final ChangePasswordResponseModel changePasswordResponseModel;

  @override
  List<Object> get props => [changePasswordResponseModel];
}

class ChangePasswordError extends ChangePasswordState {
  const ChangePasswordError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class ChangePasswordException extends ChangePasswordState {
  const ChangePasswordException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
