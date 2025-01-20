import 'package:equatable/equatable.dart';

abstract class DDPicEvent extends Equatable {
  const DDPicEvent();
}

class DDPicAttempt extends DDPicEvent {
  const DDPicAttempt({required this.action});
  final String action;

  @override
  List<Object> get props => [action];
}
