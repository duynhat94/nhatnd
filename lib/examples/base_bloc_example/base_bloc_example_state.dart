part of 'base_bloc_example_bloc.dart';

@immutable
abstract class BaseBlocExampleState {}

final class BaseBlocExampleInitial extends BaseBlocExampleState {}

final class BaseBlocExampleData extends BaseBlocExampleState {
  final int counter;
  BaseBlocExampleData(this.counter);
}