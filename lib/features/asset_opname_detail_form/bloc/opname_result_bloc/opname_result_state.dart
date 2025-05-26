import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/opname_result_response_model.dart';

abstract class OpnameResultState extends Equatable {
  const OpnameResultState();

  @override
  List<Object> get props => [];
}

class OpnameResultInitial extends OpnameResultState {}

class OpnameResultLoading extends OpnameResultState {}

class OpnameResultLoaded extends OpnameResultState {
  const OpnameResultLoaded({required this.opnameResultResponseModel});
  final OpnameResultResponseModel opnameResultResponseModel;

  @override
  List<Object> get props => [opnameResultResponseModel];
}

class OpnameResultError extends OpnameResultState {
  const OpnameResultError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class OpnameResultException extends OpnameResultState {
  const OpnameResultException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
