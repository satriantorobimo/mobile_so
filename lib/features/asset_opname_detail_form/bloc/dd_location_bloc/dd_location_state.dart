import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/ddl_location_response_model.dart';

abstract class DDLocationState extends Equatable {
  const DDLocationState();

  @override
  List<Object> get props => [];
}

class DDLocationInitial extends DDLocationState {}

class DDLocationLoading extends DDLocationState {}

class DDLocationLoaded extends DDLocationState {
  const DDLocationLoaded({required this.ddlLocationResponseModel});
  final DdlLocationResponseModel ddlLocationResponseModel;

  @override
  List<Object> get props => [ddlLocationResponseModel];
}

class DDLocationError extends DDLocationState {
  const DDLocationError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDLocationException extends DDLocationState {
  const DDLocationException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
