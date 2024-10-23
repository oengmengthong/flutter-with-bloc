// lib/blocs/expense_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'expense_event.dart';
import 'expense_state.dart';
import '../repositories/expense_repository.dart';
import '../models/expense.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseBloc({required this.expenseRepository}) : super(ExpenseLoading()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
    on<UpdateExpense>(_onUpdateExpense);
    on<DeleteExpense>(_onDeleteExpense);
    on<FilterExpenses>(_onFilterExpenses);
  }

  Future<void> _onLoadExpenses(
      LoadExpenses event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      final expenses = await expenseRepository.getAllExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onAddExpense(
      AddExpense event, Emitter<ExpenseState> emit) async {
    if (state is ExpenseLoaded) {
      await expenseRepository.insertExpense(event.expense);
      add(LoadExpenses());
    }
  }

  Future<void> _onUpdateExpense(
      UpdateExpense event, Emitter<ExpenseState> emit) async {
    if (state is ExpenseLoaded) {
      await expenseRepository.updateExpense(event.expense);
      add(LoadExpenses());
    }
  }

  Future<void> _onDeleteExpense(
      DeleteExpense event, Emitter<ExpenseState> emit) async {
    if (state is ExpenseLoaded) {
      await expenseRepository.deleteExpense(event.expenseId);
      add(LoadExpenses());
    }
  }

  Future<void> _onFilterExpenses(
      FilterExpenses event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      List<Expense> expenses;
      // Implement filtering logic based on event parameters
      if (event.category != null) {
        expenses =
            await expenseRepository.getExpensesByCategory(event.category!);
      } else {
        expenses = await expenseRepository.getAllExpenses();
      }
      // Further filter by date if needed
      if (event.startDate != null && event.endDate != null) {
        expenses = expenses.where((expense) {
          return expense.date.isAfter(event.startDate!) &&
              expense.date.isBefore(event.endDate!);
        }).toList();
      }
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}