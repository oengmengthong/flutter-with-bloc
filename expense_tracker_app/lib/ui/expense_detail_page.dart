// lib/ui/expense_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/expense.dart';
import '../blocs/expense_bloc.dart';
import '../blocs/expense_event.dart';

class ExpenseDetailPage extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailPage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expense.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _confirmDelete(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Amount'),
              subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
            ),
            ListTile(
              title: const Text('Category'),
              subtitle: Text(expense.category),
            ),
            ListTile(
              title: const Text('Date'),
              subtitle: Text(expense.date.toLocal().toString().split(' ')[0]),
            ),
            ListTile(
              title: const Text('Notes'),
              subtitle: Text(expense.notes ?? 'No notes'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Expense'),
          content: const Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                context
                    .read<ExpenseBloc>()
                    .add(DeleteExpense(expense.id!));
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}