import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/email_otp/data/change_password_request_model.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class ChangePasswordAttempt extends ChangePasswordEvent {
  const ChangePasswordAttempt({required this.changePasswordRequestModel});
  final ChangePasswordRequestModel changePasswordRequestModel;

  @override
  List<Object> get props => [changePasswordRequestModel];
}
