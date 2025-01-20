import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

abstract class UploadDocReqState extends Equatable {
  const UploadDocReqState();

  @override
  List<Object> get props => [];
}

class UploadDocReqInitial extends UploadDocReqState {}

class UploadDocReqLoading extends UploadDocReqState {}

class UploadDocReqLoaded extends UploadDocReqState {
  const UploadDocReqLoaded({required this.generalResponseModel});
  final GeneralResponseModel generalResponseModel;

  @override
  List<Object> get props => [generalResponseModel];
}

class UploadDocReqError extends UploadDocReqState {
  const UploadDocReqError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class UploadDocReqException extends UploadDocReqState {
  const UploadDocReqException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
