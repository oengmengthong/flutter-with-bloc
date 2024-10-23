// lib/models/expense_time_series.dart

import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;

import 'package:equatable/equatable.dart';

class ExpenseTimeSeries extends Equatable {
  final DateTime date;
  final double amount;

  ExpenseTimeSeries({
    required this.date,
    required this.amount,
  });

  @override
  List<Object?> get props => [date, amount];
}