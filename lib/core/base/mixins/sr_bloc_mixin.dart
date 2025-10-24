import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SingleResultProvider<SingleResult> {
  Stream<SingleResult> get singleResults;
}

abstract class SingleResultEmitter<SingleResult> {
  void addSr(SingleResult sr);
}

mixin SingleResultBlocMixin<Event, State, SR> on Bloc<Event, State> implements SingleResultProvider<SR>, SingleResultEmitter<SR> {
  @protected
  final StreamController<SR> _srController = StreamController.broadcast();

  @override
  Stream<SR> get singleResults => _srController.stream;

  @override
  void addSr(sr) {
    final observer = Bloc.observer;
    if (observer is SrBlocObserver) observer.onSr(this, sr);
    if (!_srController.isClosed) _srController.add(sr);
  }

  @override
  Future<void> close() {
    _srController.close();
    return super.close();
  }
}

/// Extending Observer to support logging SingleResult events
class SrBlocObserver<SR> extends BlocObserver {
  @protected
  @mustCallSuper
  //ignore: no-empty-block,avoid-unused-parameters
  void onSr(Bloc bloc, SR sr) {}
}