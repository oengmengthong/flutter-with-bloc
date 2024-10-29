import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'base/saveable_form_bloc.dart';

class SimpleFormBloc extends FormBloc<String, String>
    with SaveableFormBloc<String, String> {
  final nameField = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      _minLengthValidator,
    ],
  );

  final emailField = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  SimpleFormBloc() {
    addFieldBlocs(fieldBlocs: [nameField, emailField]);
  }

  static String? _minLengthValidator(String? value) {
    if (value != null && value.length >= 3) {
      return null; // Valid
    } else {
      return 'Name must be at least 3 characters long';
    }
  }

  @override
  void onSubmitting() async {
    // Simulate a save operation
    await Future.delayed(const Duration(seconds: 1));
    emitSuccess(canSubmitAgain: true);
  }

  @override
  void onSaving() {
    // Custom save logic
    emitSubmitting();
  }
}
