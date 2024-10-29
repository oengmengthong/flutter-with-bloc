import 'package:equatable/equatable.dart';

abstract class InternetState extends Equatable {
  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}
class InternetConnectedState extends InternetState {}
class InternetDisconnectedState extends InternetState {}
class InternetConnectingState extends InternetState {}