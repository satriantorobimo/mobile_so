import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_status_response_model.dart';

abstract class DDStatusState extends Equatable {
  const DDStatusState();

  @override
  List<Object> get props => [];
}

class DDStatusInitial extends DDStatusState {}

class DDStatusLoading extends DDStatusState {}

class DDStatusLoaded extends DDStatusState {
  const DDStatusLoaded({required this.ddlStatusResponseModel});
  final DdlStatusResponseModel ddlStatusResponseModel;

  @override
  List<Object> get props => [ddlStatusResponseModel];
}

class DDStatusError extends DDStatusState {
  const DDStatusError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDStatusException extends DDStatusState {
  const DDStatusException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
