import 'package:equatable/equatable.dart';

abstract class ResendOtpEvent extends Equatable {
  const ResendOtpEvent();
}

class ResendOtpAttempt extends ResendOtpEvent {
  const ResendOtpAttempt({required this.userName});
  final String userName;

  @override
  List<Object> get props => [userName];
}
