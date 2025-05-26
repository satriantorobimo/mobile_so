import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/dashboard/data/line_chart_response_model.dart';

abstract class LineState extends Equatable {
  const LineState();

  @override
  List<Object> get props => [];
}

class LineInitial extends LineState {}

class LineLoading extends LineState {}

class LineLoaded extends LineState {
  const LineLoaded({required this.lineChartResponseModel});
  final LineChartResponseModel lineChartResponseModel;

  @override
  List<Object> get props => [lineChartResponseModel];
}

class LineError extends LineState {
  const LineError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class LineException extends LineState {
  const LineException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
