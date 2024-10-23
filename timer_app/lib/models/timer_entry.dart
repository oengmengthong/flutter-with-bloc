import 'package:equatable/equatable.dart';

class TimerEntry extends Equatable {
  final DateTime startTime;
  final DateTime? endTime;
  final Duration duration;

  TimerEntry({
    required this.startTime,
    this.endTime,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'duration': duration.inSeconds,
    };
  }

  factory TimerEntry.fromMap(Map<String, dynamic> map) {
    return TimerEntry(
      startTime: DateTime.parse(map['startTime']),
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
      duration: Duration(seconds: map['duration']),
    );
  }

  @override
  List<Object?> get props => [startTime, endTime, duration];
}