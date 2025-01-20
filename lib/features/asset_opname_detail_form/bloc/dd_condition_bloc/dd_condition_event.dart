import 'package:equatable/equatable.dart';

abstract class DDConditionEvent extends Equatable {
  const DDConditionEvent();
}

class DDConditionAttempt extends DDConditionEvent {

  @override
  List<Object> get props => [];
}
