import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'timer_event.dart';
import 'timer_state.dart';
import '../repositories/timer_repository.dart';
import '../models/timer_entry.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final TimerRepository _repository;

  StreamSubscription<int>? _tickerSubscription;
  DateTime? _startTime;

  TimerBloc({required Ticker ticker, required TimerRepository repository})
      : _ticker = ticker,
        _repository = repository,
        super(const TimerInitial()) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
    on<TimerTicked>(_onTicked);
    on<LoadTimerHistory>(_onLoadHistory);
    on<ClearTimerHistory>(_onClearHistory);
  }

void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
  _startTime = DateTime.now();
  _tickerSubscription?.cancel();

  // Start the stopwatch
  _tickerSubscription = _ticker.tickUp().listen((ticks) {
    final duration = Duration(milliseconds: ticks * 10);
    add(TimerTicked(duration));
  });

  emit(const TimerRunInProgress(Duration.zero));
}

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) async {
    _tickerSubscription?.cancel();
    if (_startTime != null) {
      final entry = TimerEntry(
        startTime: _startTime!,
        endTime: DateTime.now(),
        duration: state.duration,
      );
      await _repository.saveTimerEntry(entry);
    }
    _startTime = null;
    emit(const TimerInitial());
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
  }

  Future<void> _onLoadHistory(
      LoadTimerHistory event, Emitter<TimerState> emit) async {
    final history = await _repository.getTimerHistory();
    emit(TimerHistoryLoaded(history));
  }

  Future<void> _onClearHistory(
      ClearTimerHistory event, Emitter<TimerState> emit) async {
    await _repository.clearHistory();
    emit(const TimerHistoryLoaded([]));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}

class Ticker {
  Stream<int> tickUp() {
    return Stream.periodic(
      const Duration(milliseconds: 10),
      (x) => x + 1,
    );
  }
}