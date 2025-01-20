import 'package:equatable/equatable.dart';

abstract class DDTosEvent extends Equatable {
  const DDTosEvent();
}

class DDTosAttempt extends DDTosEvent {
  const DDTosAttempt({required this.assetCode});
  final String assetCode;

  @override
  List<Object> get props => [assetCode];
}
