// lib/ui/expense_list.dart

import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expense_detail_page.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(child: Text('No expenses added.'));
    }
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return ListTile(
          title: Text(expense.title),
          subtitle: Text(
              '${expense.category} - ${expense.date.toLocal().toString().split(' ')[0]}'),
          trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExpenseDetailPage(expense: expense)),
            );
          },
        );
      },
    );
  }
}