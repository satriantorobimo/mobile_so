import 'package:equatable/equatable.dart';

abstract class AssetOpnameListEvent extends Equatable {
  const AssetOpnameListEvent();
}

class AssetOpnameListAttempt extends AssetOpnameListEvent {
  const AssetOpnameListAttempt();

  @override
  List<Object> get props => [];
}

class AssetOpnameLisDetailtAttempt extends AssetOpnameListEvent {
  const AssetOpnameLisDetailtAttempt(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}

class AssetOpnameScheduletAttempt extends AssetOpnameListEvent {
  const AssetOpnameScheduletAttempt(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}

class CalendarOpnameResulttAttempt extends AssetOpnameListEvent {
  const CalendarOpnameResulttAttempt(this.code, this.date);
  final String code;
  final String date;

  @override
  List<Object> get props => [code, date];
}
