// lib/ui/charts/expense_line_chart.dart

import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;

import '../../models/expense_time_series.dart';

class ExpenseLineChart extends StatelessWidget {
  final List<ExpenseTimeSeries> data;

  ExpenseLineChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ExpenseTimeSeries, DateTime>> series = [
      charts.Series(
        id: 'Expenses',
        data: data,
        domainFn: (ExpenseTimeSeries series, _) => series.date,
        measureFn: (ExpenseTimeSeries series, _) => series.amount,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      )
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}