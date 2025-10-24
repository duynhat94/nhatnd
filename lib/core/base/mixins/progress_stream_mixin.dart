import 'dart:async';

import 'package:nhatnd/core/base/base_bloc/progress_state.dart';

mixin class ProgressStreamMixin {
  final StreamController<BaseProgressState> _progressStreamController =
      StreamController<BaseProgressState>.broadcast();

  Stream<BaseProgressState> get progressStream =>
      _progressStreamController.stream;

  void showProgress({BaseProgressState? state}) {
    if (!_progressStreamController.isClosed) {
      _progressStreamController.add(
        state ?? DefaultProgressState(showProgress: true),
      );
    }
  }

  Future<void> hideProgress({BaseProgressState? state}) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    if (!_progressStreamController.isClosed) {
      _progressStreamController.add(
        state ?? DefaultProgressState(showProgress: false),
      );
    }
  }

  void closeProgressStream() {
    if (!_progressStreamController.isClosed) {
      _progressStreamController.close();
    }
  }
}