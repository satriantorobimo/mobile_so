import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/submit_opname_request_model.dart';

abstract class SubmitOpnameEvent extends Equatable {
  const SubmitOpnameEvent();
}

class SubmitOpnameAttempt extends SubmitOpnameEvent {
  const SubmitOpnameAttempt({required this.submitOpnameRequestModel});
  final SubmitOpnameRequestModel submitOpnameRequestModel;

  @override
  List<Object> get props => [submitOpnameRequestModel];
}
