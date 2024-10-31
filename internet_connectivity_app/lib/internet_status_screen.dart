import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_bloc.dart';
import 'internet_event.dart';
import 'internet_state.dart';

class InternetStatusScreen extends StatefulWidget {
  const InternetStatusScreen({super.key});

  @override
  State<InternetStatusScreen> createState() => _InternetStatusScreenState();
}

class _InternetStatusScreenState extends State<InternetStatusScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<InternetBloc>().add(CheckInternet()); // Corrected usage
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<InternetBloc>().add(CheckInternet()); // Corrected usage
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Internet Status"),
      ),
      body: BlocConsumer<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetConnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Connected successfully!"),
              backgroundColor: Colors.green,
            ));
          } else if (state is InternetDisconnectedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Disconnected"),
              backgroundColor: Colors.red,
            ));
          } else if (state is InternetConnectingState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Connecting..."),
              backgroundColor: Colors.orange,
            ));
          }
        },
        builder: (context, state) {
          if (state is InternetConnectedState) {
            return Center(child: Text("Internet is Connected"));
          } else if (state is InternetDisconnectedState) {
            return Center(child: Text("Internet is Disconnected"));
          } else if (state is InternetConnectingState) {
            return Center(child: Text("Connecting to Internet..."));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
