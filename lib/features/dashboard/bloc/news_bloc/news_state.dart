import 'package:equatable/equatable.dart';
import 'package:mobile_so/features/dashboard/data/news_response_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  const NewsLoaded({required this.newsResponseModel});
  final NewsResponseModel newsResponseModel;

  @override
  List<Object> get props => [newsResponseModel];
}

class NewsError extends NewsState {
  const NewsError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class NewsException extends NewsState {
  const NewsException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
