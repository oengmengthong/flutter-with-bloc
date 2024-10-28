import 'package:flutter/material.dart';
import 'counter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CounterBloc _bloc = CounterBloc();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Counter BLoC App')),
        body: Center(
          child: StreamBuilder<int>(
            stream: _bloc.counterStream,
            initialData: 0,
            builder: (context, snapshot) {
              return Text(
                'Counter: ${snapshot.data}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _bloc.increment,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
