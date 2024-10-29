import 'package:flutter_form_bloc/flutter_form_bloc.dart';

mixin SaveableFormBloc<SuccessResponse, FailureResponse>
    on FormBloc<SuccessResponse, FailureResponse> {
  void onSaving();

  void save() {
    onSaving();
  }
}