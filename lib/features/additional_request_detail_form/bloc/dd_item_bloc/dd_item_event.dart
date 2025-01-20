import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_request_model.dart';

abstract class DDItemEvent extends Equatable {
  const DDItemEvent();
}

class DDItemAttempt extends DDItemEvent {
  const DDItemAttempt({required this.action});
  final String action;

  @override
  List<Object> get props => [action];
}
