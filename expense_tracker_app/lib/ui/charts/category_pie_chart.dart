// lib/ui/charts/category_pie_chart.dart

import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;

import '../../models/expense_series.dart';

class CategoryPieChart extends StatelessWidget {
  final List<ExpenseSeries> data;

  CategoryPieChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ExpenseSeries, String>> series = [
      charts.Series(
        id: 'Expenses',
        data: data,
        domainFn: (ExpenseSeries series, _) => series.category,
        measureFn: (ExpenseSeries series, _) => series.amount,
        colorFn: (ExpenseSeries series, _) => series.barColor,
        labelAccessorFn: (ExpenseSeries row, _) =>
            '${row.category}: ${row.amount.toStringAsFixed(2)}',
      )
    ];

    return charts.PieChart<String>(
      series,
      animate: true,
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 100,
        arcRendererDecorators: [charts.ArcLabelDecorator()],
      ),
    );
  }
}