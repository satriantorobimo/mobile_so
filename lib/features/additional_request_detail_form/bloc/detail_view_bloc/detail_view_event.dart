import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail/data/asset_grow_request_model.dart';

abstract class DetailViewEvent extends Equatable {
  const DetailViewEvent();
}

class DetailViewRegisterAttempt extends DetailViewEvent {
  const DetailViewRegisterAttempt({required this.pCode});
  final String pCode;

  @override
  List<Object> get props => [pCode];
}

class DetailViewSellAttempt extends DetailViewEvent {
  const DetailViewSellAttempt({required this.pCode});
  final String pCode;

  @override
  List<Object> get props => [pCode];
}

class DetailViewDisposalAttempt extends DetailViewEvent {
  const DetailViewDisposalAttempt({required this.pCode});
  final String pCode;

  @override
  List<Object> get props => [pCode];
}

class DetailViewMaintenanceAttempt extends DetailViewEvent {
  const DetailViewMaintenanceAttempt({required this.pCode});
  final String pCode;

  @override
  List<Object> get props => [pCode];
}
