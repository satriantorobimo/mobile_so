import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_employee.dart';

abstract class DDPicState extends Equatable {
  const DDPicState();

  @override
  List<Object> get props => [];
}

class DDPicInitial extends DDPicState {}

class DDPicLoading extends DDPicState {}

class DDPicLoaded extends DDPicState {
  const DDPicLoaded({required this.dropDownEmployee});
  final DropDownEmployee dropDownEmployee;

  @override
  List<Object> get props => [dropDownEmployee];
}

class DDPicError extends DDPicState {
  const DDPicError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDPicException extends DDPicState {
  const DDPicException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
