import 'package:equatable/equatable.dart';

abstract class ReservedEvent extends Equatable {
  const ReservedEvent();
}

class ReservedAttempt extends ReservedEvent {
  const ReservedAttempt({required this.assetCode});
  final String assetCode;

  @override
  List<Object> get props => [assetCode];
}
