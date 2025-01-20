import 'package:equatable/equatable.dart';

abstract class DDStatusEvent extends Equatable {
  const DDStatusEvent();
}

class DDStatusAttempt extends DDStatusEvent {

  @override
  List<Object> get props => [];
}
