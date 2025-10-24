sealed class BaseProgressState {
  BaseProgressState();
}

class DefaultProgressState extends BaseProgressState {
  final bool showProgress;

  DefaultProgressState({required this.showProgress});
}