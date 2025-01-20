import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/dashboard/data/calendar_list_response_model.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  const CalendarLoaded({required this.calendarListResponseModel});
  final CalendarListResponseModel calendarListResponseModel;

  @override
  List<Object> get props => [calendarListResponseModel];
}

class CalendarError extends CalendarState {
  const CalendarError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class CalendarException extends CalendarState {
  const CalendarException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
