import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nhatnd/core/app_router.dart';

import 'core/di/injection.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppInitialization.I.initApp();
    runApp(MyApp());
  }, _onError)?.catchError((error, stackTrace) {
    _onError(error, stackTrace);
    exit(-1);
  });
}

void _onError(dynamic error, dynamic stackTrace) {
  if (kDebugMode) {
    print('ERROR: $error');
    print(stackTrace);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AppRouter.init();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: widget ?? const SizedBox(),
        );
      },
      routerConfig: AppRouter.router,
    );
  }
}

class AppInitialization {
  static final AppInitialization _instance = AppInitialization._privateConstructor();

  static AppInitialization get I => _instance;

  AppInitialization._privateConstructor();

  Future<void> initApp() async {
    initializeDi(GetIt.I);
    logger.d('APP Init: done');
  }
}
