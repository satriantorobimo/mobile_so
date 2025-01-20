import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/upload_doc_request_model.dart';

abstract class UploadDocOpnameEvent extends Equatable {
  const UploadDocOpnameEvent();
}

class UploadDocOpnameAttempt extends UploadDocOpnameEvent {
  const UploadDocOpnameAttempt({required this.uploadDocRequestModelModel, required this.opnameCode});
  final UploadDocRequestModel uploadDocRequestModelModel;
  final String opnameCode;

  @override
  List<Object> get props => [uploadDocRequestModelModel, opnameCode];
}
