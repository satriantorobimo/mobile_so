import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'bloc.dart';

class BarBloc extends Bloc<BarEvent, BarState> {
  BarState get initialState => BarInitial();
  DashboardRepo dashboardRepo = DashboardRepo();
  BarBloc({required this.dashboardRepo}) : super(BarInitial()) {
    on<BarEvent>((event, emit) async {
      if (event is BarListAttempt) {
        try {
          emit(BarLoading());
          final barChartResponseModel = await dashboardRepo.attemptBarChart();
          if (barChartResponseModel!.result == 1) {
            emit(BarLoaded(barChartResponseModel: barChartResponseModel));
          } else if (barChartResponseModel.result == 0) {
            emit(BarError(barChartResponseModel.message));
          } else {
            emit(const BarException('error'));
          }
        } catch (e) {
          emit(BarException(e.toString()));
        }
      }
      if (event is BarCalendartAttempt) {
        try {
          emit(BarLoading());
          final barChartResponseModel = await dashboardRepo
              .attemptBarChartCalendar(event.opnameCode, event.date);
          if (barChartResponseModel!.result == 1) {
            emit(BarLoaded(barChartResponseModel: barChartResponseModel));
          } else if (barChartResponseModel.result == 0) {
            emit(BarError(barChartResponseModel.message));
          } else {
            emit(const BarException('error'));
          }
        } catch (e) {
          emit(BarException(e.toString()));
        }
      }
    });
  }
}
