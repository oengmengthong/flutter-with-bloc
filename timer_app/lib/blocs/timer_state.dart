import 'package:equatable/equatable.dart';
import '../models/timer_entry.dart';

abstract class TimerState extends Equatable {
  final Duration duration;

  TimerState(this.duration);

  @override
  List<Object?> get props => [duration];
}

class TimerInitial extends TimerState {
  TimerInitial() : super(Duration.zero);
}

class TimerRunInProgress extends TimerState {
  TimerRunInProgress(Duration duration) : super(duration);
}

class TimerRunPause extends TimerState {
  TimerRunPause(Duration duration) : super(duration);
}

class TimerHistoryLoaded extends TimerState {
  final List<TimerEntry> history;

  TimerHistoryLoaded(this.history) : super(Duration.zero);

  @override
  List<Object?> get props => [history];
}