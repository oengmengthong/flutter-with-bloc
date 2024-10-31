// lib/presentation/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'product_list_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController(text: 'emilys');
  final TextEditingController passwordController = TextEditingController(text: 'emilyspass');

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => ProductListPage()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: usernameController,
                labelText: 'Username',
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return CustomButton(
                    text: 'Login',
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            LoginRequested(
                              username: usernameController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}