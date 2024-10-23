import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/timer_bloc.dart';
import '../blocs/timer_event.dart';
import '../blocs/timer_state.dart';
import '../models/timer_entry.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TimerBloc>().add(LoadTimerHistory());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('History'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              context.read<TimerBloc>().add(ClearTimerHistory());
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: BlocBuilder<TimerBloc, TimerState>(
          builder: (context, state) {
            if (state is TimerHistoryLoaded) {
              final history = state.history.reversed.toList();
              if (history.isEmpty) {
                return Center(
                  child: Text(
                    'No history available',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                );
              }
              return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final entry = history[index];
                  return ListTile(
                    leading: Icon(Icons.access_time, color: Colors.white70),
                    title: Text(
                      'Duration: ${_formatDuration(entry.duration)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Started at: ${entry.startTime.toLocal().toString().split('.')[0]}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}