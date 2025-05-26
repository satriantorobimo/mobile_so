import 'package:mobile_so/features/dashboard/data/bar_chart_response_model.dart';
import 'package:mobile_so/features/dashboard/data/calendar_list_response_model.dart';
import 'package:mobile_so/features/dashboard/data/line_chart_response_model.dart';
import 'package:mobile_so/features/dashboard/data/news_response_model.dart';
import 'package:mobile_so/features/dashboard/data/pie_chart_response_model.dart';
import 'package:mobile_so/features/dashboard/data/speed_response_model.dart';
import 'package:mobile_so/features/dashboard/domain/api/dashboard_api.dart';

class DashboardRepo {
  final DashboardApi dashboardApi = DashboardApi();

  Future<CalendarListResponseModel?> attemptCalendarList(
          String month, String year) =>
      dashboardApi.attemptCalendarList(month, year);

  Future<NewsResponseModel?> attemptNews() => dashboardApi.attemptNews();
  Future<SpeedResponseModel?> attemptSpeed() => dashboardApi.attemptSpeed();
  Future<BarChartResponseModel?> attemptBarChart() =>
      dashboardApi.attemptBarChart();
  Future<LineChartResponseModel?> attemptLineChart() =>
      dashboardApi.attemptLineChart();
  Future<BarChartResponseModel?> attemptBarChartCalendar(
          String code, String date) =>
      dashboardApi.attemptBarChartCalendar(code, date);
  Future<PieChartResponseModel?> attemptPieChartCalendar(
          String code, String date) =>
      dashboardApi.attemptPieChartCalendar(code, date);
}
