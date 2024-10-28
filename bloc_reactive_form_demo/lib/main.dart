import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/register_bloc.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'home_screen.dart';
import 'register_form.dart'; // Import the HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => RegisterBloc(),
        child: Scaffold(
          appBar: AppBar(title: const Text('Register')),
          body: const RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Failed: ${state.error}')),
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ReactiveFormConfig(
              validationMessages: {
                'minLength': (control) =>
                    'The password must be at least 6 characters long',
                'email': (control) => 'The email value must be a valid email',
              },
              child: ReactiveForm(
                formGroup: registerForm,
                child: Column(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'email',
                      decoration: const InputDecoration(labelText: 'Email'),
                      validationMessages: {
                        'required': (control) => 'The email must not be empty',
                      },
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'password',
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validationMessages: {
                        'required': (control) =>
                            'The password must not be empty',
                      },
                    ),
                    const SizedBox(height: 16),
                    ReactiveFormConsumer(builder: (context, form, _) {
                      return state is RegisterLoading
                          ? const CircularProgressIndicator.adaptive()
                          : ElevatedButton(
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
                              child: const Text('Register'),
                            );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
