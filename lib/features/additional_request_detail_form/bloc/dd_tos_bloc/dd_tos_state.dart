import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_tos_mdel.dart';

abstract class DDTosState extends Equatable {
  const DDTosState();

  @override
  List<Object> get props => [];
}

class DDTosInitial extends DDTosState {}

class DDTosLoading extends DDTosState {}

class DDTosLoaded extends DDTosState {
  const DDTosLoaded({required this.dropDownTosModel});
  final DropDownTosModel dropDownTosModel;

  @override
  List<Object> get props => [dropDownTosModel];
}

class DDTosError extends DDTosState {
  const DDTosError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDTosException extends DDTosState {
  const DDTosException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
