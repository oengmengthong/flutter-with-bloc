import 'package:flutter_form_bloc/flutter_form_bloc.dart';

mixin FieldsFormBloc<TField, TSuccess, TFailure>
    on FormBloc<TSuccess, TFailure> {
  Map<TField, FieldBloc> get fieldBlocs;

  FieldBloc create(TField field);

  List<TField> getFields();
}