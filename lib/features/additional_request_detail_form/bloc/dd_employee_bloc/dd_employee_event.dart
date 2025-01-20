import 'package:equatable/equatable.dart';

abstract class DDemployeeEvent extends Equatable {
  const DDemployeeEvent();
}

class DDemployeeAttempt extends DDemployeeEvent {
  const DDemployeeAttempt({required this.action});
  final String action;

  @override
  List<Object> get props => [action];
}
