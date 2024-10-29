import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocAccessMixin<B extends BlocBase<Object?>, T extends StatefulWidget> on State<T> {
  B get bloc => context.read<B>();
  B get watch => context.watch<B>();
}