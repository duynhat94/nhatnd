import 'package:go_router/go_router.dart';
import 'package:nhatnd/examples/base_bloc_example/base_bloc_example_screen.dart';
import 'package:nhatnd/examples/base_cubit_example/base_cubit_example_screen.dart';

class AppRouter {
  static const _initialLocation = '/';
  static const _baseBlocExample = '/';
  static const _baseCubitExample = '/base_cubit';

  static String get baseBlocExample => _baseBlocExample;

  static final AppRouter _instance = AppRouter._privateConstructor();

  AppRouter._privateConstructor() {
    _initialize();
  }
  factory AppRouter.init() {
    return _instance;
  }

  static late GoRouter router;

  void _initialize({String initialLocation = _initialLocation}) {
    router = GoRouter(
      routes: [
        GoRoute(
          path: _baseBlocExample,
          name: 'BaseBlocExample',
          builder: (context, state) => BaseBlocExampleScreen(title: 'a'),
        ),
        GoRoute(path: _baseCubitExample, name: 'BaseCubit', builder: (context, state) => BaseCubitExampleScreen()),
      ],
      initialLocation: initialLocation,
    );
  }
}
