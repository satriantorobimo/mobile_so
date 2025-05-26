import 'package:equatable/equatable.dart';

abstract class LineEvent extends Equatable {
  const LineEvent();
}

class LineListAttempt extends LineEvent {
  const LineListAttempt();

  @override
  List<Object> get props => [];
}
