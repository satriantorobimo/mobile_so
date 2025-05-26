import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_list_detail_response_model.dart';
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_list_response_model.dart';
import 'package:mobile_so/features/asset_opname_list/data/asset_opname_schedule_response_model.dart';

abstract class AssetOpnameListState extends Equatable {
  const AssetOpnameListState();

  @override
  List<Object> get props => [];
}

class AssetOpnameListInitial extends AssetOpnameListState {}

class AssetOpnameListLoading extends AssetOpnameListState {}

class AssetOpnameListLoaded extends AssetOpnameListState {
  const AssetOpnameListLoaded({required this.assetOpnameListResponseModel});
  final AssetOpnameListResponseModel assetOpnameListResponseModel;

  @override
  List<Object> get props => [assetOpnameListResponseModel];
}

class AssetOpnameListDetailLoaded extends AssetOpnameListState {
  const AssetOpnameListDetailLoaded(
      {required this.assetOpnameListDetailResponseModel});
  final AssetOpnameListDetailResponseModel assetOpnameListDetailResponseModel;

  @override
  List<Object> get props => [assetOpnameListDetailResponseModel];
}

class CalendarOpnameResultLoaded extends AssetOpnameListState {
  const CalendarOpnameResultLoaded(
      {required this.assetOpnameListDetailResponseModel});
  final AssetOpnameListDetailResponseModel assetOpnameListDetailResponseModel;

  @override
  List<Object> get props => [assetOpnameListDetailResponseModel];
}

class AssetOpnameShceduleLoaded extends AssetOpnameListState {
  const AssetOpnameShceduleLoaded(
      {required this.assetOpnameScheduleResponseModel});
  final AssetOpnameScheduleResponseModel assetOpnameScheduleResponseModel;

  @override
  List<Object> get props => [assetOpnameScheduleResponseModel];
}

class AssetOpnameListError extends AssetOpnameListState {
  const AssetOpnameListError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class AssetOpnameListException extends AssetOpnameListState {
  const AssetOpnameListException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
