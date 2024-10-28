// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contributor_event.dart';
import 'di/injection.dart';
import 'bloc/contributor_bloc.dart';
import 'pages/contributor_page.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ContributorBloc _contributorBloc = getIt<ContributorBloc>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Contributors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider.value(
        value: _contributorBloc..add(FetchContributors()),
        child: ContributorPage(),
      ),
    );
  }
}