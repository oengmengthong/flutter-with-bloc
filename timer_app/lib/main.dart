import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/timer_bloc.dart';
import 'repositories/timer_repository.dart';
import 'ui/home_page.dart';

void main() {
  final timerRepository = TimerRepository();
  runApp(BlocProvider(
      create: (context) => TimerBloc(
            ticker: Ticker(),
            repository: timerRepository,
          ),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primaryColor: Colors.black87,
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
        ),
      ),
      home: const HomePage(),
    );
  }
}
