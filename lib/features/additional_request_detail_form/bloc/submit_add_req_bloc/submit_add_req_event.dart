import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/additional_request_detail_form/data/submit_request_model.dart';

abstract class SubmitAddReqEvent extends Equatable {
  const SubmitAddReqEvent();
}

class SubmitAddReqAttempt extends SubmitAddReqEvent {
  const SubmitAddReqAttempt({required this.submitRequestModel});
  final SubmitRequestModel submitRequestModel;

  @override
  List<Object> get props => [submitRequestModel];
}

class SubmitAdditionalAttempt extends SubmitAddReqEvent {
  const SubmitAdditionalAttempt({required this.submitRequestModel});
  final SubmitRequestModel submitRequestModel;

  @override
  List<Object> get props => [submitRequestModel];
}

class SubmitAdditionalSellAttempt extends SubmitAddReqEvent {
  const SubmitAdditionalSellAttempt({required this.submitRequestModel});
  final SubmitRequestModel submitRequestModel;

  @override
  List<Object> get props => [submitRequestModel];
}

class SubmitAdditionalMaintenanceAttempt extends SubmitAddReqEvent {
  const SubmitAdditionalMaintenanceAttempt({required this.submitRequestModel});
  final SubmitRequestModel submitRequestModel;

  @override
  List<Object> get props => [submitRequestModel];
}
