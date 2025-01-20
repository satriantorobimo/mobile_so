import 'package:equatable/equatable.dart';

abstract class DDpcEvent extends Equatable {
  const DDpcEvent();
}

class DDpcAttempt extends DDpcEvent {
  const DDpcAttempt({required this.action});
  final String action;

  @override
  List<Object> get props => [action];
}
