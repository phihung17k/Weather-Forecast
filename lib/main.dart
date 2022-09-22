import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/dependencies/app_dependencies.dart';
import 'package:weather_forecast/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.setup();
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MaterialApp(
  //     title: "Weather Forecast",
  //     debugShowCheckedModeBanner: false,
  //     initialRoute: Routes.home,
  //     onGenerateRoute: (settings) => Routes.getRoutes(settings),
  //     useInheritedMediaQuery: true,
  //     locale: DevicePreview.locale(context),
  //     builder: DevicePreview.appBuilder,
  //   ),
  // ));
  runApp(
    MaterialApp(
      title: "Weather Forecast",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      onGenerateRoute: (settings) => Routes.getRoutes(settings),
    ),
  );
}
