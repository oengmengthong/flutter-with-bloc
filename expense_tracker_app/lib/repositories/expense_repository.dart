// lib/repositories/expense_repository.dart

import 'package:sqflite/sqflite.dart';
import '../models/expense.dart';
import '../services/database_service.dart';

class ExpenseRepository {
  final dbService = DatabaseService.instance;

  Future<int> insertExpense(Expense expense) async {
    final db = await dbService.database;
    return await db.insert('expenses', expense.toMap());
  }

  Future<int> updateExpense(Expense expense) async {
    final db = await dbService.database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(int id) async {
    final db = await dbService.database;
    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Expense>> getAllExpenses() async {
    final db = await dbService.database;
    final result = await db.query('expenses', orderBy: 'date DESC');
    return result.map((e) => Expense.fromMap(e)).toList();
  }

  Future<List<Expense>> getExpensesByCategory(String category) async {
    final db = await dbService.database;
    final result = await db.query(
      'expenses',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'date DESC',
    );
    return result.map((e) => Expense.fromMap(e)).toList();
  }

  // Add methods for filtering, searching, etc.
}