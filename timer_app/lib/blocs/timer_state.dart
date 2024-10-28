import 'package:equatable/equatable.dart';
import '../models/timer_entry.dart';

abstract class TimerState extends Equatable {
  final Duration duration;

  const TimerState(this.duration);

  @override
  List<Object?> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial() : super(Duration.zero);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);
}

class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);
}

class TimerHistoryLoaded extends TimerState {
  final List<TimerEntry> history;

  const TimerHistoryLoaded(this.history) : super(Duration.zero);

  @override
  List<Object?> get props => [history];
}