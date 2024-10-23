// lib/ui/charts/expense_bar_chart.dart

import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;

import '../../models/expense_time_series.dart';

class ExpenseBarChart extends StatelessWidget {
  final List<ExpenseTimeSeries> data;

  ExpenseBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ExpenseTimeSeries, String>> series = [
      charts.Series(
        id: 'Expenses',
        data: data,
        domainFn: (ExpenseTimeSeries series, _) =>
            '${series.date.month}/${series.date.day}',
        measureFn: (ExpenseTimeSeries series, _) => series.amount,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    return charts.BarChart(
      series,
      animate: true,
      vertical: true,
    );
  }
}