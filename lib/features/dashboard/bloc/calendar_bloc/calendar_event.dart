import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class CalendarListAttempt extends CalendarEvent {
  const CalendarListAttempt({required this.month, required this.year});
  final String month;
  final String year;

  @override
  List<Object> get props => [month, year];
}
