import 'package:equatable/equatable.dart';

abstract class PrintEvent extends Equatable {
  const PrintEvent();
}

class PrintAttempt extends PrintEvent {
  const PrintAttempt({required this.assetCode});
  final String assetCode;

  @override
  List<Object> get props => [assetCode];
}
