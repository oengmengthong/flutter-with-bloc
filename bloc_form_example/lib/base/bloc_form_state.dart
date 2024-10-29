import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

abstract class BlocFormState<
    B extends FormBloc<SuccessResponse, FailureResponse>,
    SuccessResponse,
    FailureResponse,
    S extends StatefulWidget> extends State<S> {
  @protected
  late final B formBloc;

  @protected
  B initFormBloc(BuildContext context) {
    return context.read<B>();
  }

  @protected
  bool autoDispose() => false;

  @protected
  Widget formBlocListener(BuildContext context);

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    formBloc = initFormBloc(context);
  }

  @override
  void dispose() {
    if (autoDispose()) {
      formBloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>.value(
      value: formBloc,
      child: formBlocListener(context),
    );
  }
}