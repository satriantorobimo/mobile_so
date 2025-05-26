import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

abstract class PrintState extends Equatable {
  const PrintState();

  @override
  List<Object> get props => [];
}

class PrintInitial extends PrintState {}

class PrintLoading extends PrintState {}

class PrintLoaded extends PrintState {
  const PrintLoaded({required this.generalResponseModel});
  final GeneralResponseModel generalResponseModel;

  @override
  List<Object> get props => [generalResponseModel];
}

class PrintError extends PrintState {
  const PrintError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class PrintException extends PrintState {
  const PrintException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
