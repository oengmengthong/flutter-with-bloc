import 'package:equatable/equatable.dart';

abstract class InternetEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckInternet extends InternetEvent {}
class InternetConnected extends InternetEvent {}
class InternetDisconnected extends InternetEvent {}
class InternetConnecting extends InternetEvent {}