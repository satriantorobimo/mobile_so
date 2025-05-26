import 'package:equatable/equatable.dart';

abstract class AdditionalListEvent extends Equatable {
  const AdditionalListEvent();
}

class RegisterAttempt extends AdditionalListEvent {
  const RegisterAttempt();

  @override
  List<Object> get props => [];
}

class SellAttempt extends AdditionalListEvent {
  const SellAttempt();

  @override
  List<Object> get props => [];
}

class DisposalAttempt extends AdditionalListEvent {
  const DisposalAttempt();

  @override
  List<Object> get props => [];
}

class MaintenanceAttempt extends AdditionalListEvent {
  const MaintenanceAttempt();

  @override
  List<Object> get props => [];
}

class MutationAttempt extends AdditionalListEvent {
  const MutationAttempt();

  @override
  List<Object> get props => [];
}
