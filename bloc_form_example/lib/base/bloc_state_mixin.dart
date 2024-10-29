import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BlocStateListenWhen<S> = bool Function(S previous, S current);
typedef BlocStateBuildWhen<S> = bool Function(S previous, S current);

mixin BlocStateMixin<B extends Cubit<S>, S, T extends StatefulWidget> on State<T> {
  @protected
  late final B bloc;

  @protected
  B initBloc(BuildContext context);

  @protected
  Widget blocBuilder(BuildContext context, S currentState);

  @protected
  BlocStateBuildWhen<S>? buildWhen;

  @protected
  BlocWidgetListener<S>? blocListener;

  @protected
  BlocStateListenWhen<S>? listenWhen;

  @protected
  bool autoDispose() => false;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    bloc = initBloc(context);
  }

  @override
  void dispose() {
    if (autoDispose()) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blocBuilderWidget = BlocBuilder<B, S>(
      bloc: bloc,
      buildWhen: buildWhen,
      builder: (context, currentState) => BlocProvider<B>.value(
        value: bloc,
        child: blocBuilder(context, currentState),
      ),
    );

    if (autoDispose()) {
      return BlocProvider<B>(
        create: (_) => bloc,
        child: blocBuilderWidget,
      );
    } else {
      return blocBuilderWidget;
    }
  }
}