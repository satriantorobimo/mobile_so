import 'package:equatable/equatable.dart';

abstract class BarEvent extends Equatable {
  const BarEvent();
}

class BarListAttempt extends BarEvent {
  const BarListAttempt();

  @override
  List<Object> get props => [];
}

class BarCalendartAttempt extends BarEvent {
  const BarCalendartAttempt(this.opnameCode, this.date);
  final String opnameCode;
  final String date;

  @override
  List<Object> get props => [opnameCode, date];
}
