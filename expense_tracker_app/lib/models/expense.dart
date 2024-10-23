// lib/models/expense.dart

import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final int? id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? notes;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
      notes: map['notes'],
    );
  }

  @override
  List<Object?> get props => [id, title, amount, category, date, notes];
}