import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_model.dart';

abstract class DDpcState extends Equatable {
  const DDpcState();

  @override
  List<Object> get props => [];
}

class DDpcInitial extends DDpcState {}

class DDpcLoading extends DDpcState {}

class DDpcLoaded extends DDpcState {
  const DDpcLoaded({required this.dropDownModel});
  final DropDownModel dropDownModel;

  @override
  List<Object> get props => [dropDownModel];
}

class DDpcError extends DDpcState {
  const DDpcError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDpcException extends DDpcState {
  const DDpcException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
