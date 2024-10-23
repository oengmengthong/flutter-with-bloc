// lib/ui/expense_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/expense.dart';
import '../blocs/expense_bloc.dart';
import '../blocs/expense_event.dart';

class ExpenseDetailPage extends StatelessWidget {
  final Expense expense;

  ExpenseDetailPage({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expense.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _confirmDelete(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Amount'),
              subtitle: Text('\$${expense.amount.toStringAsFixed(2)}'),
            ),
            ListTile(
              title: Text('Category'),
              subtitle: Text(expense.category),
            ),
            ListTile(
              title: Text('Date'),
              subtitle: Text(expense.date.toLocal().toString().split(' ')[0]),
            ),
            ListTile(
              title: Text('Notes'),
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
          title: Text('Delete Expense'),
          content: Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Delete'),
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