import 'package:equatable/equatable.dart';

abstract class ReqChangePasswordEvent extends Equatable {
  const ReqChangePasswordEvent();
}

class ReqChangePasswordAttempt extends ReqChangePasswordEvent {
  const ReqChangePasswordAttempt({required this.userName});
  final String userName;

  @override
  List<Object> get props => [userName];
}
