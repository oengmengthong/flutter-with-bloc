import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';

class TodosCubit extends Cubit<List<Todo>> {
  TodosCubit() : super([]);

  void addTodo(Todo todo) {
    emit([...state, todo]);
  }

  void updateTodo(Todo updatedTodo) {
    emit(state.map((todo) {
      return todo.id == updatedTodo.id ? updatedTodo : todo;
    }).toList());
  }

  void deleteTodo(String id) {
    emit(state.where((todo) => todo.id != id).toList());
  }
}