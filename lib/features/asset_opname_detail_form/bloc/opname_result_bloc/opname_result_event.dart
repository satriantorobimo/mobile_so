import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/asset_opname_detail_form/data/arguments_view_model.dart';

abstract class OpnameResultEvent extends Equatable {
  const OpnameResultEvent();
}

class OpnameResultAttempt extends OpnameResultEvent {
  const OpnameResultAttempt({required this.argumentsViewModel});
  final ArgumentsViewModel argumentsViewModel;

  @override
  List<Object> get props => [argumentsViewModel];
}
