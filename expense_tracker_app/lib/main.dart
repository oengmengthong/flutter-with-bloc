// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/expense_bloc.dart';
import 'blocs/expense_event.dart';
import 'repositories/expense_repository.dart';
import 'ui/home_page.dart';

void main() {
  final expenseRepository = ExpenseRepository();
  runApp(BlocProvider(
      create: (context) => ExpenseBloc(expenseRepository: expenseRepository)
        ..add(LoadExpenses()),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Expense Tracker',
      home: HomePage(),
    );
  }
}
