// lib/blocs/expense_event.dart

import 'package:equatable/equatable.dart';
import '../models/expense.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadExpenses extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expense expense;

  AddExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class UpdateExpense extends ExpenseEvent {
  final Expense expense;

  UpdateExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpense extends ExpenseEvent {
  final int expenseId;

  DeleteExpense(this.expenseId);

  @override
  List<Object?> get props => [expenseId];
}

class FilterExpenses extends ExpenseEvent {
  final String? category;
  final DateTime? startDate;
  final DateTime? endDate;

  FilterExpenses({this.category, this.startDate, this.endDate});

  @override
  List<Object?> get props => [category, startDate, endDate];
}