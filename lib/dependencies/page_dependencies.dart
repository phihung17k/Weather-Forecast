import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../pages/pages.dart';

import '../routes.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => HomePage(injector()),
        instanceName: Routes.home);
    injector.registerFactory<Widget>(() => MapPage(injector()),
        instanceName: Routes.map);
  }
}
