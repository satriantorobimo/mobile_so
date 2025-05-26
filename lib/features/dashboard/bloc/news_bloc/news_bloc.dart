import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsState get initialState => NewsInitial();
  DashboardRepo dashboardRepo = DashboardRepo();
  NewsBloc({required this.dashboardRepo}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is NewsListAttempt) {
        try {
          emit(NewsLoading());
          final newsResponseModel = await dashboardRepo.attemptNews();
          if (newsResponseModel!.result == 1) {
            emit(NewsLoaded(newsResponseModel: newsResponseModel));
          } else if (newsResponseModel.result == 0) {
            emit(NewsError(newsResponseModel.message));
          } else {
            emit(const NewsException('error'));
          }
        } catch (e) {
          emit(NewsException(e.toString()));
        }
      }
    });
  }
}
