import 'package:flutter/material.dart';
import 'package:nhatnd/core/base/base_bloc/base_bloc_state.dart';
import 'package:nhatnd/core/base/base_bloc/progress_state.dart';
import 'package:nhatnd/core/base/failure/api_failure.dart';
import 'package:nhatnd/examples/base_bloc_example/base_bloc_example_bloc.dart';

class BaseBlocExampleScreen extends StatefulWidget {
  final String title;

  const BaseBlocExampleScreen({required this.title, super.key});

  @override
  State<BaseBlocExampleScreen> createState() => _BaseBlocExampleScreenState();
}

class _BaseBlocExampleScreenState
    extends BaseState<BaseBlocExampleState, BaseBlocExampleBloc, BaseBlocExampleSr, BaseBlocExampleScreen> {
  @override
  BaseBlocExampleBloc createBloc() => BaseBlocExampleBloc();

  @override
  void onSR(BuildContext context, BaseBlocExampleSr sr) {
    if (sr is BaseBlocExampleSrShowDialog) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bloc dialog'),
            content: Text(sr.message),
            actions: <Widget>[TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          );
        },
      );
    }
  }

  @override
  void onFailure(BuildContext context, Failure failure) {
    debugPrint(failure.toString());
  }

  @override
  void onProgress(BuildContext context, BaseProgressState progress) {
    debugPrint(progress.toString());
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            blocBuilder(
              builder: (context, state) {
                return Text(
                  '${state is BaseBlocExampleData ? state.counter : 0}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => blocOf(context).add(BaseBlocExampleOnIncrement()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () => blocOf(context).addSr(BaseBlocExampleSrShowDialog('Hello')),
            tooltip: 'Show dialog',
            child: const Icon(Icons.message),
          ),
        ],
      ),
    );
  }
}
