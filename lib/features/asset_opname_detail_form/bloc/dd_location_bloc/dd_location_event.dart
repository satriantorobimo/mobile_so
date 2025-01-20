import 'package:equatable/equatable.dart';

abstract class DDLocationEvent extends Equatable {
  const DDLocationEvent();
}

class DDLocationAttempt extends DDLocationEvent {

  @override
  List<Object> get props => [];
}
