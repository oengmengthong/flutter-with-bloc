// lib/presentation/blocs/auth/auth_event.dart

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  const LoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogoutRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}