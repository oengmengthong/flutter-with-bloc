import 'package:flutter/material.dart';
import 'base/app_lifecycle.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AppLifecycle<HomeScreen>, AppLifecycleObserver {
  @override
  AppLifecycleObserver get observer => this;

  @override
  void onResume() {
    print('App resumed');
  }

  @override
  void onPause() {
    print('App paused');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Lifecycle Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Form'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormScreen()),
            );
          },
        ),
      ),
    );
  }
}
