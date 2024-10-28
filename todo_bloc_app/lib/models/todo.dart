import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final bool isCompleted;

  const Todo({
    required this.id,
    required this.task,
    this.isCompleted = false,
  });

  Todo copyWith({String? id, String? task, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, task, isCompleted];
}