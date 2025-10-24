import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

void initializeDi(GetIt getIt) {
  registerApp(getIt);
}

Logger get logger => GetIt.I<Logger>();

void registerApp(GetIt getIt) {
  getIt.registerSingleton<Logger>(Logger());
}
