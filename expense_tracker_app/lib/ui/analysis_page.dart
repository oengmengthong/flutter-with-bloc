// lib/ui/analysis_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/expense_bloc.dart';
import '../blocs/expense_state.dart';
import '../models/expense.dart';
import '../models/expense_series.dart';
import '../models/expense_time_series.dart';
import 'charts/category_pie_chart.dart';
import 'charts/expense_bar_chart.dart';
import 'charts/expense_line_chart.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;

class AnalysisPage extends StatelessWidget {
  AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Analysis'),
      ),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            final expenses = state.expenses;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Expenses by Category',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 300, child: _buildCategoryPieChart(expenses)),
                  SizedBox(height: 20),
                  Text(
                    'Expenses Over Time',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 300, child: _buildExpenseLineChart(expenses)),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildCategoryPieChart(List<Expense> expenses) {
    Map<String, double> categoryData = {};
    expenses.forEach((expense) {
      categoryData.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    });

    final data = categoryData.entries.map((entry) {
      return ExpenseSeries(
        category: entry.key,
        amount: entry.value,
        barColor: charts.ColorUtil.fromDartColor(_getCategoryColor(entry.key)),
      );
    }).toList();

    return CategoryPieChart(data: data);
  }

  Widget _buildExpenseLineChart(List<Expense> expenses) {
    Map<DateTime, double> dateData = {};
    expenses.forEach((expense) {
      final date = DateTime(expense.date.year, expense.date.month, expense.date.day);
      dateData.update(
        date,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    });

    final data = dateData.entries.map((entry) {
      return ExpenseTimeSeries(
        date: entry.key,
        amount: entry.value,
      );
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return ExpenseLineChart(data: data);
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.redAccent;
      case 'Transport':
        return Colors.blueAccent;
      case 'Entertainment':
        return Colors.greenAccent;
      case 'Shopping':
        return Colors.orangeAccent;
      case 'Bills':
        return Colors.purpleAccent;
      default:
        return Colors.grey;
    }
  }
}