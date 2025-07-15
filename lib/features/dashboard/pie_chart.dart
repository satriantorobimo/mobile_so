import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_so/features/dashboard/bloc/pie_bloc/bloc.dart';
import 'package:mobile_so/features/dashboard/domain/repo/dashboard_repo.dart';
import 'package:mobile_so/features/navbar/navbar_provider.dart';
import 'package:mobile_so/utility/general_util.dart';
import 'package:mobile_so/utility/shared_pref_util.dart';
import 'package:mobile_so/utility/string_router_util.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart({super.key, required this.code, required this.date});
  final String code;
  final String date;

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  PieBloc pieBloc = PieBloc(dashboardRepo: DashboardRepo());

  final List<ChartData> chartData = [];
  @override
  void initState() {
    pieBloc.add(PieCalendartAttempt(widget.code, widget.date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: pieBloc,
        listener: (_, PieState state) {
          if (state is PieLoading) {}
          if (state is PieLoaded) {}
          if (state is PieError) {
            GeneralUtil().showSnackBarError(context, state.error!);
          }
          if (state is PieException) {
            if (state.error.toLowerCase() == 'unauthorized access') {
              GeneralUtil().showSnackBarError(context, 'Session Expired');
              var bottomPieProvider =
                  Provider.of<NavbarProvider>(context, listen: false);
              bottomPieProvider.setPage(0);
              bottomPieProvider.setTab(0);
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
            bloc: pieBloc,
            builder: (context, state) {
              if (state is PieLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is PieLoaded) {
                num totalValue = 0;
                for (var item in state.pieChartResponseModel.data!) {
                  chartData.add(ChartData(item.description!,
                      double.parse(item.percentageResult.toString())));
                }
                for (var element in chartData) {
                  totalValue += element.y;
                }
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SfCircularChart(
                      margin: EdgeInsets.all(20),
                      legend: Legend(
                        shouldAlwaysShowScrollbar: false,
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 14, color: Colors.white),
                        overflowMode: LegendItemOverflowMode.wrap,
                        toggleSeriesVisibility: true,
                        position: LegendPosition.bottom,
                        height: '30%',
                      ),
                      series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<ChartData, String>(
                          dataSource: chartData,
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          radius: '80%', // Increased radius for larger chart
                          dataLabelSettings: DataLabelSettings(
                            builder: (dynamic data,
                                dynamic point,
                                dynamic series,
                                int pointIndex,
                                int seriesIndex) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  data.x +
                                      ' ${(data.y / (totalValue / 100)).round()}' +
                                      '%',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            isVisible: true, // Enables labels
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            labelPosition: ChartDataLabelPosition
                                .outside, // Places labels outside
                            connectorLineSettings: ConnectorLineSettings(
                              type: ConnectorType
                                  .curve, // Adds a curved connector line
                              width: 2,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        )
                      ]),
                );
              }

              return Container();
            }));
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
