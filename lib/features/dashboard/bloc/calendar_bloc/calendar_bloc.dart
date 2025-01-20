import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarState get initialState => CalendarInitial();
  DashboardRepo dashboardRepo = DashboardRepo();
  CalendarBloc({required this.dashboardRepo}) : super(CalendarInitial()) {
    on<CalendarEvent>((event, emit) async {
      if (event is CalendarListAttempt) {
        try {
          emit(CalendarLoading());
          final calendarListResponseModel =
              await dashboardRepo.attemptCalendarList(event.month, event.year);
          if (calendarListResponseModel!.results!.isNotEmpty) {
            emit(CalendarLoaded(
                calendarListResponseModel: calendarListResponseModel));
          } else {
            emit(const CalendarException('error'));
          }
        } catch (e) {
          emit(CalendarException(e.toString()));
        }
      }
    });
  }
}
