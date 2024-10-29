import 'package:flutter/widgets.dart';

mixin AppLifecycle<S extends StatefulWidget> on State<S> {
  AppLifecycleObserver get observer;
  late final AppLifecycleDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _delegate = AppLifecycleDelegate(observer: observer)..init();
  }

  @override
  void dispose() {
    _delegate.dispose();
    super.dispose();
  }
}

class AppLifecycleDelegate {
  final _owner = AppLifecycleOwner();
  final AppLifecycleObserver observer;

  AppLifecycleDelegate({required this.observer});

  void init() {
    _owner.addObserver(observer);
  }

  void dispose() {
    _owner.dispose();
  }
}

class AppLifecycleOwner with WidgetsBindingObserver {
  AppLifecycleObserver? _observer;

  void addObserver(AppLifecycleObserver observer) {
    _observer = observer;
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    _observer = null;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _observer?.onResume();
    } else if (state == AppLifecycleState.paused) {
      _observer?.onPause();
    }
  }
}

mixin AppLifecycleObserver {
  @protected
  void onResume() {}

  @protected
  void onPause() {}
}