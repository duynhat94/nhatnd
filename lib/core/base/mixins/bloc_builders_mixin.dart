import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ListenDelegate<S> = void Function(BuildContext context, S state);
typedef StateListener<S> = Widget Function(S state);
typedef SingleResultListener<SR> = void Function(
  BuildContext context,
  SR singleResult,
);

mixin class BlocBuildersMixin<B extends StateStreamable<S>, S, SR> {
  Widget blocConsumer({
    required StateListener<S> builder,
    required ListenDelegate<S> listener,
    BlocBuilderCondition<S>? buildWhen,
    BlocListenerCondition<S>? listenWhen,
  }) {
    return BlocConsumer<B, S>(
      builder: (_, state) => builder(state),
      listener: listener,
      buildWhen: buildWhen,
      listenWhen: listenWhen,
    );
  }

  Widget blocBuilder({
    required BlocWidgetBuilder<S> builder,
    BlocBuilderCondition<S>? buildWhen,
  }) {
    return BlocBuilder<B, S>(builder: builder, buildWhen: buildWhen);
  }

  Widget blocListener({
    required ListenDelegate<S> listener,
    Widget? child,
    BlocListenerCondition<S>? listenWhen,
  }) {
    return BlocListener<B, S>(
      listener: listener,
      listenWhen: listenWhen,
      child: child,
    );
  }
}