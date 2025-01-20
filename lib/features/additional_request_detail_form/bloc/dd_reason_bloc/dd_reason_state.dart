import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_item_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_model.dart';

abstract class DDReasonState extends Equatable {
  const DDReasonState();

  @override
  List<Object> get props => [];
}

class DDReasonInitial extends DDReasonState {}

class DDReasonLoading extends DDReasonState {}

class DDReasonLoaded extends DDReasonState {
  const DDReasonLoaded({required this.downItemModel});
  final DropDownModel downItemModel;

  @override
  List<Object> get props => [downItemModel];
}

class DDReasonError extends DDReasonState {
  const DDReasonError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDReasonException extends DDReasonState {
  const DDReasonException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
