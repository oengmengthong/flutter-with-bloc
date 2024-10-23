// lib/blocs/expense_state.dart

import 'package:equatable/equatable.dart';
import '../models/expense.dart';

abstract class ExpenseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;

  ExpenseLoaded(this.expenses);

  @override
  List<Object?> get props => [expenses];
}

class ExpenseError extends ExpenseState {
  final String message;

  ExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}