import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_model.dart';

abstract class DDConditionState extends Equatable {
  const DDConditionState();

  @override
  List<Object> get props => [];
}

class DDConditionInitial extends DDConditionState {}

class DDConditionLoading extends DDConditionState {}

class DDConditionLoaded extends DDConditionState {
  const DDConditionLoaded({required this.dropDownModel});
  final DropDownModel dropDownModel;

  @override
  List<Object> get props => [dropDownModel];
}

class DDConditionError extends DDConditionState {
  const DDConditionError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDConditionException extends DDConditionState {
  const DDConditionException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
