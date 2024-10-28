import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/todos_cubit.dart';
import 'models/todo.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TodosCubit(),
        child: TodoPage(),
      ),
    );
  }
}

class TodoPage extends StatelessWidget {
  final TextEditingController _todoController = TextEditingController();
  final _uuid = const Uuid();

  TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo BLoC App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _todoController,
              decoration: const InputDecoration(labelText: 'Add a new task'),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final todo = Todo(
                    id: _uuid.v4(),
                    task: value,
                  );
                  context.read<TodosCubit>().addTodo(todo);
                  _todoController.clear();
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<TodosCubit, List<Todo>>(
              builder: (context, todos) {
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo.task),
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (value) {
                          final updatedTodo = todo.copyWith(
                            isCompleted: value,
                          );
                          context.read<TodosCubit>().updateTodo(updatedTodo);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TodosCubit>().deleteTodo(todo.id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}