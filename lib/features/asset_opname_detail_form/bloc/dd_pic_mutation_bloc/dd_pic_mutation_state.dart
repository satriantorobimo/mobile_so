import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_pic_mutation.dart';

abstract class DDPicMutationState extends Equatable {
  const DDPicMutationState();

  @override
  List<Object> get props => [];
}

class DDPicMutationInitial extends DDPicMutationState {}

class DDPicMutationLoading extends DDPicMutationState {}

class DDPicMutationLoaded extends DDPicMutationState {
  const DDPicMutationLoaded({required this.dropDownPicMutation});
  final DropDownPicMutation dropDownPicMutation;

  @override
  List<Object> get props => [dropDownPicMutation];
}

class DDPicMutationError extends DDPicMutationState {
  const DDPicMutationError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DDPicMutationException extends DDPicMutationState {
  const DDPicMutationException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
