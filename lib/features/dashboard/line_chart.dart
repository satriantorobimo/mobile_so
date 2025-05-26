import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/bloc/line_bloc/bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinesChart extends StatefulWidget {
  const LinesChart({super.key});

  @override
  State<LinesChart> createState() => _LinesChartState();
}

class _LinesChartState extends State<LinesChart> {
  List<ChartDataList> chartData = [];
  LineBloc lineBloc = LineBloc(dashboardRepo: DashboardRepo());

  @override
  void initState() {
    super.initState();

    lineBloc.add(LineListAttempt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: lineBloc,
        listener: (_, LineState state) {
          if (state is LineLoading) {}
          if (state is LineLoaded) {
            Map<String, List<ChartData>> groupedData = {};
            Set<String> uniqueDescriptions = {};
            List<ChartDataList> uniqueChartData = [];

            for (var entry in state.lineChartResponseModel.data!) {
              String date =
                  entry.date!.substring(0, 10); // Keep only YYYY-MM-DD

              for (var item in entry.data!) {
                String code = item.description!;
                double total = (item.total as num).toDouble();

                if (!uniqueDescriptions.contains(code)) {
                  uniqueDescriptions.add(code);
                  groupedData.putIfAbsent(code, () => []);
                  groupedData[code]!.add(ChartData(date, total));
                } else {
                  groupedData[code]!.add(ChartData(date, total));
                }
              }
            }

            uniqueChartData = groupedData.entries
                .map((e) => ChartDataList(code: e.key, data: e.value))
                .toList();

            setState(() {
              chartData = uniqueChartData;
            });
          }
          if (state is LineError) {
            GeneralUtil().showSnackBarError(context, state.error!);
          }
          if (state is LineException) {
            if (state.error.toLowerCase() == 'unauthorized access') {
              GeneralUtil().showSnackBarError(context, 'Session Expired');
              var bottomLineProvider =
                  Provider.of<NavbarProvider>(context, listen: false);
              bottomLineProvider.setPage(0);
              bottomLineProvider.setTab(0);
              SharedPrefUtil.clearSharedPref();
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(context,
                    StringRouterUtil.loginScreenRoute, (route) => false);
              });
            } else {
              GeneralUtil().showSnackBarError(context, state.error);
            }
          }
        },
        child: BlocBuilder(
            bloc: lineBloc,
            builder: (context, state) {
              if (state is LineLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is LineLoaded) {
                return SfCartesianChart(
                  title: ChartTitle(
                      text: GeneralUtil.dateConvertLineMonthYear(
                          state.lineChartResponseModel.data![0].date!),
                      borderWidth: 2,
                      // Aligns the chart title to left
                      alignment: ChartAlignment.center,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: GeneralUtil.fontSize(context) * 0.35,
                      )),
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(
                        width: 0), // Removes vertical grid lines
                  ),
                  primaryYAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(
                        width: 0), // Removes horizontal grid lines
                  ),
                  legend: Legend(
                    shouldAlwaysShowScrollbar: false,
                    isVisible: true,
                    textStyle: TextStyle(
                        fontSize: GeneralUtil.fontSize(context) * 0.25,
                        color: Colors.white),
                    overflowMode: LegendItemOverflowMode.wrap,
                    toggleSeriesVisibility: true,
                    position: LegendPosition.bottom,
                    height: '250',
                  ),
                  series: <LineSeries<ChartData, String>>[
                    for (var chart in chartData)
                      LineSeries<ChartData, String>(
                        dataSource: chart.data,
                        name: chart.code,
                        xValueMapper: (ChartData data, _) =>
                            GeneralUtil.dateConvertLineDate(data.date),
                        yValueMapper: (ChartData data, _) => data.total,
                        markerSettings: MarkerSettings(isVisible: true),
                      )
                  ],
                );
              }

              return Container();
            }));
  }
}

class ChartData {
  final String date;
  final double total;
  ChartData(this.date, this.total);
}

class ChartDataList {
  final String code;
  final List<ChartData> data;
  ChartDataList({required this.code, required this.data});
}
