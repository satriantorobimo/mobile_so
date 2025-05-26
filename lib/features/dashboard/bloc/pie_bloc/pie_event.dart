import 'package:equatable/equatable.dart';

abstract class PieEvent extends Equatable {
  const PieEvent();
}

class PieCalendartAttempt extends PieEvent {
  const PieCalendartAttempt(this.opnameCode, this.date);
  final String opnameCode;
  final String date;

  @override
  List<Object> get props => [opnameCode, date];
}
