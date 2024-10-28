import 'package:bloc/bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    try {
      emit(RegisterLoading());
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock success response
      if (event.formData['email'] == 'fail@example.com') {
        throw Exception('Registration failed');
      }

      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}