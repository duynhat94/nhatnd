import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhatnd/core/base/mixins/failure_stream_mixin.dart';
import 'package:nhatnd/core/base/mixins/progress_stream_mixin.dart';
import 'package:nhatnd/core/base/mixins/sr_bloc_mixin.dart';

abstract class BaseBloc<Event, State, SR> extends Bloc<Event, State> with SingleResultBlocMixin<Event, State, SR>, ProgressStreamMixin, FailureStreamMixin {
  BaseBloc(super.initialState);

  void dispose() {
    closeProgressStream();
    closeFailureStream();
  }
}