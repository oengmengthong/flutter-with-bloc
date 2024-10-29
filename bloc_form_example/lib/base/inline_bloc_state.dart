import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BlocStateListener<S> = void Function(BuildContext context, S state);
typedef BlocCreate<B> = B Function(BuildContext context);

class InlineBlocState<B extends BlocBase<S>, S> extends StatelessWidget {
  final B? bloc;
  final BlocCreate<B>? create;
  final BlocWidgetBuilder<S> builder;
  final BlocStateListener<S>? listener;

  const InlineBlocState({
    super.key,
    this.bloc,
    this.create,
    required this.builder,
    this.listener,
  }) : assert((create != null) != (bloc != null));

  @override
  Widget build(BuildContext context) {
    return _BlocProvider<B, S>(
      bloc: bloc,
      create: create,
      child: _InlineBlocBuilder<B, S>(
        listener: listener,
        builder: builder,
      ),
    );
  }
}

class _BlocProvider<B extends BlocBase<S>, S> extends StatelessWidget {
  final B? bloc;
  final BlocCreate<B>? create;
  final Widget child;

  const _BlocProvider({
    super.key,
    this.bloc,
    this.create,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (create != null) {
      return BlocProvider<B>(
        create: create!,
        child: child,
      );
    } else if (bloc != null) {
      return BlocProvider<B>.value(
        value: bloc!,
        child: child,
      );
    } else {
      throw ArgumentError('Either bloc or create must be provided');
    }
  }
}

class _InlineBlocBuilder<B extends BlocBase<S>, S> extends StatelessWidget {
  final BlocStateListener<S>? listener;
  final BlocWidgetBuilder<S> builder;

  const _InlineBlocBuilder({super.key, this.listener, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      listener: listener ?? (_, __) {},
      builder: builder,
    );
  }
}