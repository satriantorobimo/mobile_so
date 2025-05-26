import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/dashboard/data/speed_response_model.dart';

abstract class SpeedState extends Equatable {
  const SpeedState();

  @override
  List<Object> get props => [];
}

class SpeedInitial extends SpeedState {}

class SpeedLoading extends SpeedState {}

class SpeedLoaded extends SpeedState {
  const SpeedLoaded({required this.speedResponseModel});
  final SpeedResponseModel speedResponseModel;

  @override
  List<Object> get props => [speedResponseModel];
}

class SpeedError extends SpeedState {
  const SpeedError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class SpeedException extends SpeedState {
  const SpeedException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
