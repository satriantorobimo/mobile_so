import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/dashboard/data/pie_chart_response_model.dart';

abstract class PieState extends Equatable {
  const PieState();

  @override
  List<Object> get props => [];
}

class PieInitial extends PieState {}

class PieLoading extends PieState {}

class PieLoaded extends PieState {
  const PieLoaded({required this.pieChartResponseModel});
  final PieChartResponseModel pieChartResponseModel;

  @override
  List<Object> get props => [pieChartResponseModel];
}

class PieError extends PieState {
  const PieError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class PieException extends PieState {
  const PieException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
