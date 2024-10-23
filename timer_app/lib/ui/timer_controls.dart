import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/timer_bloc.dart';
import '../blocs/timer_state.dart';
import '../blocs/timer_event.dart';

class TimerControls extends StatelessWidget {
  TimerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return _mapStateToActionButtons(context, state);
        },
      ),
    );
  }

  Widget _mapStateToActionButtons(BuildContext context, TimerState state) {
    final timerBloc = context.read<TimerBloc>();

    if (state is TimerInitial || state is TimerHistoryLoaded) {
      return Center(
        child: IconButton(
          icon: Icon(Icons.play_circle_fill),
          color: Colors.greenAccent,
          iconSize: 80,
          onPressed: () => timerBloc.add(TimerStarted()),
        ),
      );
    } else if (state is TimerRunInProgress) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.pause_circle_filled),
            color: Colors.yellowAccent,
            iconSize: 80,
            onPressed: () => timerBloc.add(TimerPaused()),
          ),
          IconButton(
            icon: Icon(Icons.stop_circle_outlined),
            color: Colors.redAccent,
            iconSize: 80,
            onPressed: () => timerBloc.add(TimerReset()),
          ),
        ],
      );
    } else if (state is TimerRunPause) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.play_circle_fill),
            color: Colors.greenAccent,
            iconSize: 80,
            onPressed: () => timerBloc.add(TimerResumed()),
          ),
          IconButton(
            icon: Icon(Icons.stop_circle_outlined),
            color: Colors.redAccent,
            iconSize: 80,
            onPressed: () => timerBloc.add(TimerReset()),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}