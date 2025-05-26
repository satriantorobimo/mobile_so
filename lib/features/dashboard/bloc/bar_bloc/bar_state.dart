import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/dashboard/data/bar_chart_response_model.dart';

abstract class BarState extends Equatable {
  const BarState();

  @override
  List<Object> get props => [];
}

class BarInitial extends BarState {}

class BarLoading extends BarState {}

class BarLoaded extends BarState {
  const BarLoaded({required this.barChartResponseModel});
  final BarChartResponseModel barChartResponseModel;

  @override
  List<Object> get props => [barChartResponseModel];
}

class BarError extends BarState {
  const BarError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class BarException extends BarState {
  const BarException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
