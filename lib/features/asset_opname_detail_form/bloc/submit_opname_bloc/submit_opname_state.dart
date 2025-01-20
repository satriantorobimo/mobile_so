import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

abstract class SubmitOpnameState extends Equatable {
  const SubmitOpnameState();

  @override
  List<Object> get props => [];
}

class SubmitOpnameInitial extends SubmitOpnameState {}

class SubmitOpnameLoading extends SubmitOpnameState {}

class SubmitOpnameLoaded extends SubmitOpnameState {
  const SubmitOpnameLoaded({required this.generalResponseModel});
  final GeneralResponseModel generalResponseModel;

  @override
  List<Object> get props => [generalResponseModel];
}

class SubmitOpnameError extends SubmitOpnameState {
  const SubmitOpnameError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class SubmitOpnameException extends SubmitOpnameState {
  const SubmitOpnameException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
