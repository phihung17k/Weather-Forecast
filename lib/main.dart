import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_forecast/dependencies/app_dependencies.dart';
import 'package:weather_forecast/global/bloc/theme_bloc.dart';
import 'package:weather_forecast/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'global/bloc/theme_state.dart';
import 'utils.dart';

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

  HttpOverrides.global = MyHttpOverrides();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await FileUtils.readConstantsJson();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final ThemeBloc bloc = ThemeBloc();

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        bloc: bloc,
        builder: (context, state) {
          return MaterialApp(
              title: "Weather Forecast",
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.home,
              onGenerateRoute: (settings) => Routes.getRoutes(settings),
              theme: state.themeData,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales
              // const [
              //   Locale('en', 'US'),
              //   Locale('vi', 'VN'),
              // ],
              );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
