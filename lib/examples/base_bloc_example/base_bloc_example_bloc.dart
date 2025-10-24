import 'package:flutter/foundation.dart';
import 'package:nhatnd/core/base/base_bloc/base_bloc.dart';
import 'package:nhatnd/core/base/failure/api_failure.dart';

part 'base_bloc_example_event.dart';
part 'base_bloc_example_state.dart';
part 'base_bloc_example_sr.dart';

class BaseBlocExampleBloc extends BaseBloc<BaseBlocExampleEvent, BaseBlocExampleState, BaseBlocExampleSr>{
  BaseBlocExampleBloc() : super(BaseBlocExampleInitial()) {
    on<BaseBlocExampleOnIncrement>((event, emit) {
      int counte = state is BaseBlocExampleData ? (state as BaseBlocExampleData).counter : 0;
      emit(BaseBlocExampleData(counte + 1));
      addSr(BaseBlocExampleSrShowDialog('test dialog'));
      onFailure(ApiFailure(ServerFailure.unknown));
      showProgress();
      hideProgress();
    },);
  }
}