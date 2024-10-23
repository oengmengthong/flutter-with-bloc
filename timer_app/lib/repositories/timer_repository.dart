import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/timer_entry.dart';

class TimerRepository {
  static const String _historyKey = 'timer_history';

  Future<void> saveTimerEntry(TimerEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];
    history.add(jsonEncode(entry.toMap()));
    await prefs.setStringList(_historyKey, history);
  }

  Future<List<TimerEntry>> getTimerHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];
    return history
        .map((entry) => TimerEntry.fromMap(jsonDecode(entry)))
        .toList();
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}