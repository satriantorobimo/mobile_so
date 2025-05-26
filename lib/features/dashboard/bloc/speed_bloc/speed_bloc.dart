import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'bloc.dart';

class SpeedBloc extends Bloc<SpeedEvent, SpeedState> {
  SpeedState get initialState => SpeedInitial();
  DashboardRepo dashboardRepo = DashboardRepo();
  SpeedBloc({required this.dashboardRepo}) : super(SpeedInitial()) {
    on<SpeedEvent>((event, emit) async {
      if (event is SpeedListAttempt) {
        try {
          emit(SpeedLoading());
          final speedResponseModel = await dashboardRepo.attemptSpeed();
          if (speedResponseModel!.result == 1) {
            emit(SpeedLoaded(speedResponseModel: speedResponseModel));
          } else if (speedResponseModel.result == 0) {
            emit(SpeedError(speedResponseModel.message));
          } else {
            emit(const SpeedException('error'));
          }
        } catch (e) {
          emit(SpeedException(e.toString()));
        }
      }
    });
  }
}
