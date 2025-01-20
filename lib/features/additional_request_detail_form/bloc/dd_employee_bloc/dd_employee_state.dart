import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_employee.dart';

abstract class DDemployeeState extends Equatable {
  const DDemployeeState();

  @override
  List<Object> get props => [];
}

class DDemployeeInitial extends DDemployeeState {}

class DDemployeeLoading extends DDemployeeState {}

class DDemployeeLoaded extends DDemployeeState {
  const DDemployeeLoaded({required this.dropDownEmployee});
  final DropDownEmployee dropDownEmployee;

  @override
  List<Object> get props => [dropDownEmployee];
}

class DDemployeeError extends DDemployeeState {
  const DDemployeeError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDemployeeException extends DDemployeeState {
  const DDemployeeException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
