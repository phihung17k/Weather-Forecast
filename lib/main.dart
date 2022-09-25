import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  //for certificate map api
  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());
  HttpOverrides.global = MyHttpOverrides();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(
    MaterialApp(
      title: "Weather Forecast",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      onGenerateRoute: (settings) => Routes.getRoutes(settings),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
