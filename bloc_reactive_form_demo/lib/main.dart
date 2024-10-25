import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/register_bloc.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'home_screen.dart'; // Import the HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FormGroup form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => RegisterBloc(),
        child: Scaffold(
          appBar: AppBar(title: Text('Register')),
          body: RegisterForm(form: form),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final FormGroup form;

  RegisterForm({required this.form});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Failed: ${state.error}')),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              ReactiveTextField<String>(
                formControlName: 'email',
                decoration: InputDecoration(labelText: 'Email'),
                validationMessages: {
                  'required': (control) => 'The email must not be empty',
                  'email': (control) => 'The email value must be a valid email',
                },
              ),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validationMessages: {
                  'required': (control) => 'The password must not be empty',
                  'minLength': (control) =>
                      'The password must be at least 6 characters long',
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (form.valid) {
                    final formData = form.value;
                    context
                        .read<RegisterBloc>()
                        .add(RegisterSubmitted(formData));
                  } else {
                    form.markAllAsTouched();
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
