import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

abstract class ReservedState extends Equatable {
  const ReservedState();

  @override
  List<Object> get props => [];
}

class ReservedInitial extends ReservedState {}

class ReservedLoading extends ReservedState {}

class ReservedLoaded extends ReservedState {
  const ReservedLoaded({required this.generalResponseModel});
  final GeneralResponseModel generalResponseModel;

  @override
  List<Object> get props => [generalResponseModel];
}

class ReservedError extends ReservedState {
  const ReservedError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class ReservedException extends ReservedState {
  const ReservedException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
