// lib/ui/add_expense_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/expense_bloc.dart';
import '../blocs/expense_event.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  AddExpensePage({super.key});

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  double _amount = 0.0;
  String _category = 'Other';
  DateTime _date = DateTime.now();
  String _notes = '';

  List<String> _categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Shopping',
    'Bills',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true, signed: false),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an amount' : null,
                onSaved: (value) => _amount = double.parse(value!),
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Category'),
                value: _category,
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value as String;
                  });
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Date: ${DateFormat.yMMMd().format(_date)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes'),
                maxLines: 3,
                onSaved: (value) => _notes = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Add Expense'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (datePicked != null) {
      setState(() {
        _date = datePicked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final expense = Expense(
        title: _title,
        amount: _amount,
        category: _category,
        date: _date,
        notes: _notes,
      );
      context.read<ExpenseBloc>().add(AddExpense(expense));
      Navigator.pop(context);
    }
  }
}