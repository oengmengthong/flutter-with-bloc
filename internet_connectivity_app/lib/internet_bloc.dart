import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'internet_event.dart';
import 'internet_state.dart';
import 'locator.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = getIt<Connectivity>();
  late StreamSubscription<dynamic> _connectivitySubscription;

  InternetBloc() : super(InternetInitial()) {
    on<CheckInternet>((event, emit) async {
      await _checkConnection(emit);
    });
    on<InternetConnected>((event, emit) {
      emit(InternetConnectedState());
    });
    on<InternetDisconnected>((event, emit) {
      emit(InternetDisconnectedState());
    });
    on<InternetConnecting>((event, emit) {
      emit(InternetConnectingState());
    });

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result is ConnectivityResult) {
        _handleConnectivityResult(result as ConnectivityResult);
      } else {
        for (var res in result) {
          _handleConnectivityResult(res);
        }
      }
    });
  }

  void _handleConnectivityResult(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      add(InternetDisconnected());
    } else {
      add(InternetConnected());
    }
  }

  Future<void> _checkConnection(Emitter<InternetState> emit) async {
    final result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      emit(InternetDisconnectedState());
    } else {
      emit(InternetConnectedState());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
