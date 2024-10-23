import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TimerStarted extends TimerEvent {}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerReset extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final Duration duration;

  TimerTicked(this.duration);

  @override
  List<Object?> get props => [duration];
}

class LoadTimerHistory extends TimerEvent {}

class ClearTimerHistory extends TimerEvent {}