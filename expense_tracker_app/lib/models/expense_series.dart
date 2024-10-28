// lib/models/expense_series.dart

import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;

import 'package:equatable/equatable.dart';

class ExpenseSeries extends Equatable {
  final String category;
  final double amount;
  final charts.Color barColor;

  const ExpenseSeries({
    required this.category,
    required this.amount,
    required this.barColor,
  });

  @override
  List<Object?> get props => [category, amount, barColor];
}