import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'bloc.dart';

class PieBloc extends Bloc<PieEvent, PieState> {
  PieState get initialState => PieInitial();
  DashboardRepo dashboardRepo = DashboardRepo();
  PieBloc({required this.dashboardRepo}) : super(PieInitial()) {
    on<PieEvent>((event, emit) async {
      if (event is PieCalendartAttempt) {
        try {
          emit(PieLoading());
          final pieChartResponseModel = await dashboardRepo
              .attemptPieChartCalendar(event.opnameCode, event.date);
          if (pieChartResponseModel!.result == 1) {
            emit(PieLoaded(pieChartResponseModel: pieChartResponseModel));
          } else if (pieChartResponseModel.result == 0) {
            emit(PieError(pieChartResponseModel.message));
          } else {
            emit(const PieException('error'));
          }
        } catch (e) {
          emit(PieException(e.toString()));
        }
      }
    });
  }
}
