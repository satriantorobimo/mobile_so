import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsListAttempt extends NewsEvent {
  const NewsListAttempt();

  @override
  List<Object> get props => [];
}
