import 'package:flutter/material.dart';

class ChartData {
  final String label; // Label for the x-axis
  final double value; // Value for the y-axis
  final Color? color; // Color for the data point (optional)

  ChartData(this.label, this.value, [this.color]);
}