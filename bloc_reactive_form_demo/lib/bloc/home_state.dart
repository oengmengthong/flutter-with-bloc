import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> data;

  HomeLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);

  @override
  List<Object> get props => [error];
}