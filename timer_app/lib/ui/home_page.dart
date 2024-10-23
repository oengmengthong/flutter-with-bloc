import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/timer_bloc.dart';
import '../blocs/timer_event.dart';
import '../blocs/timer_state.dart';
import 'timer_controls.dart';
import 'history_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Stopwatch'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              context.read<TimerBloc>().add(LoadTimerHistory());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Elapsed Time',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Text(
                _formatDuration(duration),
                style: TextStyle(
                  fontFamily: 'Digital',
                  fontSize: 80,
                  color: Colors.greenAccent,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.greenAccent,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(child: TimerControls()
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final milliseconds = duration.inMilliseconds.remainder(1000);
    final seconds = duration.inSeconds.remainder(60);
    final minutes = duration.inMinutes.remainder(60);
    final hours = duration.inHours;

    String formattedTime;
    if (hours > 0) {
      formattedTime =
          '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      formattedTime =
          '${twoDigits(minutes)}:${twoDigits(seconds)}.${(milliseconds ~/ 10).toString().padLeft(2, '0')}';
    }
    return formattedTime;
  }
}