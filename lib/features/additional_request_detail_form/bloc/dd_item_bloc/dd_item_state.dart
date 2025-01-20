import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_item_model.dart';

abstract class DDItemState extends Equatable {
  const DDItemState();

  @override
  List<Object> get props => [];
}

class DDItemInitial extends DDItemState {}

class DDItemLoading extends DDItemState {}

class DDItemLoaded extends DDItemState {
  const DDItemLoaded({required this.downItemModel});
  final DropDownItemModel downItemModel;

  @override
  List<Object> get props => [downItemModel];
}

class DDItemError extends DDItemState {
  const DDItemError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDItemException extends DDItemState {
  const DDItemException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
