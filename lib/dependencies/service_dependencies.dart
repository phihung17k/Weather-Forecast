import 'package:get_it/get_it.dart';

import '../services/services.dart';

class ServiceDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<IHomeService>(() => HomeService());
  }
}
