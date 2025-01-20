import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/login/data/general_response_model.dart';

abstract class UploadDocOpnameState extends Equatable {
  const UploadDocOpnameState();

  @override
  List<Object> get props => [];
}

class UploadDocOpnameInitial extends UploadDocOpnameState {}

class UploadDocOpnameLoading extends UploadDocOpnameState {}

class UploadDocOpnameLoaded extends UploadDocOpnameState {
  const UploadDocOpnameLoaded({required this.generalResponseModel});
  final GeneralResponseModel generalResponseModel;

  @override
  List<Object> get props => [generalResponseModel];
}

class UploadDocOpnameError extends UploadDocOpnameState {
  const UploadDocOpnameError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class UploadDocOpnameException extends UploadDocOpnameState {
  const UploadDocOpnameException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
