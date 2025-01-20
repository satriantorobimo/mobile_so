import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_list/data/additional_request_list_response_model.dart';

abstract class AdditionalListState extends Equatable {
  const AdditionalListState();

  @override
  List<Object> get props => [];
}

class AdditionalListInitial extends AdditionalListState {}

class AdditionalListLoading extends AdditionalListState {}

class AdditionalListLoaded extends AdditionalListState {
  const AdditionalListLoaded(
      {required this.additionalRequestListResponseModel});
  final AdditionalRequestListResponseModel additionalRequestListResponseModel;

  @override
  List<Object> get props => [additionalRequestListResponseModel];
}

class AdditionalListError extends AdditionalListState {
  const AdditionalListError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class AdditionalListException extends AdditionalListState {
  const AdditionalListException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
