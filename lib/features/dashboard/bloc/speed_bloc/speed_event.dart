import 'package:equatable/equatable.dart';

abstract class SpeedEvent extends Equatable {
  const SpeedEvent();
}

class SpeedListAttempt extends SpeedEvent {
  const SpeedListAttempt();

  @override
  List<Object> get props => [];
}
