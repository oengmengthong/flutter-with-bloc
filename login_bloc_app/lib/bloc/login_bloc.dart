import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email,
        isValidEmail: _validateEmail(event.email),
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        isValidPassword: _validatePassword(event.password),
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.isValidEmail && state.isValidPassword) {
        emit(state.copyWith(isSubmitting: true));
        // Simulate a network call
        await Future.delayed(Duration(seconds: 2));
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isFailure: true));
      }
    });
  }

  bool _validateEmail(String email) {
    return email.contains('@');
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }
}