import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'bloc.dart';

class LineBloc extends Bloc<LineEvent, LineState> {
  LineState get initialState => LineInitial();
  DashboardRepo dashboardRepo = DashboardRepo();
  LineBloc({required this.dashboardRepo}) : super(LineInitial()) {
    on<LineEvent>((event, emit) async {
      if (event is LineListAttempt) {
        try {
          emit(LineLoading());
          final lineChartResponseModel = await dashboardRepo.attemptLineChart();
          if (lineChartResponseModel!.result == 1) {
            emit(LineLoaded(lineChartResponseModel: lineChartResponseModel));
          } else if (lineChartResponseModel.result == 0) {
            emit(LineError(lineChartResponseModel.message));
          } else {
            emit(const LineException('error'));
          }
        } catch (e) {
          emit(LineException(e.toString()));
        }
      }
    });
  }
}
