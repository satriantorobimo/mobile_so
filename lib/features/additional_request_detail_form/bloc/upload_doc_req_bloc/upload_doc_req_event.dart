import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/upload_doc_request_model.dart';

abstract class UploadDocReqEvent extends Equatable {
  const UploadDocReqEvent();
}

class UploadDocReqAttempt extends UploadDocReqEvent {
  const UploadDocReqAttempt({required this.uploadDocRequestModel});
  final UploadDocRequestModel uploadDocRequestModel;

  @override
  List<Object> get props => [uploadDocRequestModel];
}

class UploadDocDisposalAttempt extends UploadDocReqEvent {
  const UploadDocDisposalAttempt(
      {required this.uploadDocRequestModel, required this.opnameCode});
  final UploadDocRequestModel uploadDocRequestModel;
  final String opnameCode;

  @override
  List<Object> get props => [uploadDocRequestModel, opnameCode];
}

class UploadDocMutaionAttempt extends UploadDocReqEvent {
  const UploadDocMutaionAttempt(
      {required this.uploadDocRequestModel, required this.opnameCode});
  final UploadDocRequestModel uploadDocRequestModel;
  final String opnameCode;

  @override
  List<Object> get props => [uploadDocRequestModel, opnameCode];
}

class UploadDocMaintenanceAttempt extends UploadDocReqEvent {
  const UploadDocMaintenanceAttempt(
      {required this.uploadDocRequestModel, required this.opnameCode});
  final UploadDocRequestModel uploadDocRequestModel;
  final String opnameCode;

  @override
  List<Object> get props => [uploadDocRequestModel, opnameCode];
}

class UploadDocSellAttempt extends UploadDocReqEvent {
  const UploadDocSellAttempt(
      {required this.uploadDocRequestModel, required this.opnameCode});
  final UploadDocRequestModel uploadDocRequestModel;
  final String opnameCode;

  @override
  List<Object> get props => [uploadDocRequestModel, opnameCode];
}
