import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_disposal_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_maintenance_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_register_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/additional_request_detail_sell_response_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_item_model.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/drop_down_model.dart';

abstract class DetailViewState extends Equatable {
  const DetailViewState();

  @override
  List<Object> get props => [];
}

class DetailViewInitial extends DetailViewState {}

class DetailViewLoading extends DetailViewState {}

class DetailViewRegisterLoaded extends DetailViewState {
  const DetailViewRegisterLoaded(
      {required this.additionalRequestDetailRegisterResponseModel});
  final AdditionalRequestDetailRegisterResponseModel
      additionalRequestDetailRegisterResponseModel;

  @override
  List<Object> get props => [additionalRequestDetailRegisterResponseModel];
}

class DetailViewSellLoaded extends DetailViewState {
  const DetailViewSellLoaded(
      {required this.additionalRequestDetailSellResponseModel});
  final AdditionalRequestDetailSellResponseModel
      additionalRequestDetailSellResponseModel;

  @override
  List<Object> get props => [additionalRequestDetailSellResponseModel];
}

class DetailViewDisposalLoaded extends DetailViewState {
  const DetailViewDisposalLoaded(
      {required this.additionalRequestDetailDisposalResponseModel});
  final AdditionalRequestDetailDisposalResponseModel
      additionalRequestDetailDisposalResponseModel;

  @override
  List<Object> get props => [additionalRequestDetailDisposalResponseModel];
}

class DetailViewMaintenanceLoaded extends DetailViewState {
  const DetailViewMaintenanceLoaded(
      {required this.additionalRequestDetailMaintenanceResponseModel});
  final AdditionalRequestDetailMaintenanceResponseModel
      additionalRequestDetailMaintenanceResponseModel;

  @override
  List<Object> get props => [additionalRequestDetailMaintenanceResponseModel];
}

class DetailViewError extends DetailViewState {
  const DetailViewError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class DetailViewException extends DetailViewState {
  const DetailViewException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
