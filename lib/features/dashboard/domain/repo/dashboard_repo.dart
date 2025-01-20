import 'package:mobile_so/features/dashboard/data/calendar_list_response_model.dart';
import 'package:mobile_so/features/dashboard/domain/api/dashboard_api.dart';

class DashboardRepo {
  final DashboardApi dashboardApi = DashboardApi();

  Future<CalendarListResponseModel?> attemptCalendarList(int month, int year) =>
      dashboardApi.attemptCalendarList(month, year);
}
