import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

abstract class SubmitAddReqState extends Equatable {
  const SubmitAddReqState();

  @override
  List<Object> get props => [];
}

class SubmitAddReqInitial extends SubmitAddReqState {}

class SubmitAddReqLoading extends SubmitAddReqState {}

class SubmitAddReqLoaded extends SubmitAddReqState {
  const SubmitAddReqLoaded({required this.generalResponseModel});
  final GeneralResponseModel generalResponseModel;

  @override
  List<Object> get props => [generalResponseModel];
}

class SubmitAddReqError extends SubmitAddReqState {
  const SubmitAddReqError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class SubmitAddReqException extends SubmitAddReqState {
  const SubmitAddReqException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
