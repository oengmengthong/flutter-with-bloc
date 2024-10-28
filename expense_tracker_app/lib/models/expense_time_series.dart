// lib/models/expense_time_series.dart


import 'package:equatable/equatable.dart';

class ExpenseTimeSeries extends Equatable {
  final DateTime date;
  final double amount;

  const ExpenseTimeSeries({
    required this.date,
    required this.amount,
  });

  @override
  List<Object?> get props => [date, amount];
}