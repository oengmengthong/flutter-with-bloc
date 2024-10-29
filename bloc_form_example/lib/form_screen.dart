import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'base/bloc_form_state.dart';
import 'simple_form_bloc.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState
    extends BlocFormState<SimpleFormBloc, String, String, FormScreen> {
  @override
  SimpleFormBloc initFormBloc(BuildContext context) {
    return SimpleFormBloc();
  }

  @override
  Widget formBlocListener(BuildContext context) {
    return FormBlocListener<SimpleFormBloc, String, String>(
      onSuccess: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully!')),
        );
      },
      onFailure: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submission failed.')),
        );
      },
      child: Builder(
        builder: (context) => buildForm(context),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    final formBloc = context.read<SimpleFormBloc>();

    return Scaffold(
      appBar: AppBar(title: Text('Simple Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.nameField,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.emailField,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            BlocBuilder<SimpleFormBloc, FormBlocState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed:
                      state is FormBlocSubmitting ? null : formBloc.submit,
                  child: state is FormBlocSubmitting
                      ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
