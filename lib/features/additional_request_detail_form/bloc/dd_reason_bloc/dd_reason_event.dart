import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_request_model.dart';

abstract class DDReasonEvent extends Equatable {
  const DDReasonEvent();
}

class DDReasonAttempt extends DDReasonEvent {
  const DDReasonAttempt({required this.action});
  final String action;

  @override
  List<Object> get props => [action];
}
