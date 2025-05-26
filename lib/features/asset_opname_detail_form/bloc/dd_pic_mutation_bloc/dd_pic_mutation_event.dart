import 'package:equatable/equatable.dart';

abstract class DDPicMutationEvent extends Equatable {
  const DDPicMutationEvent();
}

class DDPicMutationAttempt extends DDPicMutationEvent {
  const DDPicMutationAttempt({required this.action});
  final String action;

  @override
  List<Object> get props => [action];
}
