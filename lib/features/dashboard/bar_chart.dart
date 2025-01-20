import 'package:flutter/material.dart';
import 'package:mobile_so/features/dashboard/char_data.dart';
import 'package:mobile_so/features/dashboard/class_status.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarsChart extends StatelessWidget {
  final List<Status> data;

  const BarsChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Data for the charts
    final barChartData = [
      ChartData('On Repair', 50, Colors.orange),
      ChartData('Good', 300, Colors.green),
      ChartData('Broken', 20, Colors.red),
      ChartData('Others', 10, Colors.blue),
    ];

    return SfCartesianChart(
      backgroundColor: Colors.black,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      series: <CartesianSeries>[
        ColumnSeries<ChartData, String>(
          dataSource: barChartData,
          xValueMapper: (ChartData data, _) => data.label,
          yValueMapper: (ChartData data, _) => data.value,
          pointColorMapper: (ChartData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
      title: ChartTitle(
        text: 'Bar Chart (Daily Summary)',
        textStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
