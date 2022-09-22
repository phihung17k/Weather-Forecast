import 'package:get_it/get_it.dart';

import 'bloc_dependencies.dart';
import 'page_dependencies.dart';
import 'service_dependencies.dart';

class AppDependencies {
  static GetIt get _injector => GetIt.I;
  static Future setup() async {
    await ServiceDependencies.setup(_injector);
    await BlocDependencies.setup(_injector);
    await PageDependencies.setup(_injector);
  }
}
