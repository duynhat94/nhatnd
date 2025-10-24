part of 'base_bloc_example_bloc.dart';

@immutable
sealed class BaseBlocExampleSr {}

final class BaseBlocExampleSrShowDialog extends BaseBlocExampleSr {
  final String message;
  BaseBlocExampleSrShowDialog(this.message);
}